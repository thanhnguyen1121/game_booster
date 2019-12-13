package com.example.gamebotter.utils.booster;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Environment;
import android.os.StatFs;
import android.util.Log;

import com.example.gamebotter.BuildConfig;
import com.example.gamebotter.Entity.OneCpuInfo;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.RandomAccessFile;
import java.util.ArrayList;
import java.util.regex.Pattern;

public class CPURAMUtil {
    private static int sLastCpuCoreCount = -1;

    public static int calcCpuCoreCount() {
        if (sLastCpuCoreCount >= 1) {
            return sLastCpuCoreCount;
        }
        try {
            sLastCpuCoreCount = new File("/sys/devices/system/cpu/").listFiles(new FileFilter() {
                public boolean accept(File pathname) {
                    if (Pattern.matches("cpu[0-9]", pathname.getName())) {
                        return true;
                    }
                    return false;
                }
            }).length;
        } catch (Exception e) {
            sLastCpuCoreCount = Runtime.getRuntime().availableProcessors();
        }
        return sLastCpuCoreCount;
    }

    public static int takeCurrentCpuFreq() {
        return readIntegerFile("/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq");
    }

    public static int takeMinCpuFreq() {
        return readIntegerFile("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq");
    }

    public static int takeMaxCpuFreq() {
        return readIntegerFile("/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq") + 100000;
    }

    private static int readIntegerFile(String filePath) {
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(filePath)), 1000);
            String line = reader.readLine();
            reader.close();
            return Integer.parseInt(line);
        } catch (Exception e) {
            return 0;
        }
    }

    public static ArrayList<OneCpuInfo> takeCpuUsageSnapshot() {
        ArrayList<OneCpuInfo> result = new ArrayList<>();
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new InputStreamReader(new FileInputStream("/proc/stat")), 1000);
            while (reader.read() != -1) {
                String line = reader.readLine();
                if (line == null || !line.startsWith("cpu")) {
                    reader.close();
                } else {
                    String[] tokens = line.split(" +");
                    OneCpuInfo oci = new OneCpuInfo();
                    oci.setIdle(Long.parseLong(tokens[4]));
                    long a = ((((Long.parseLong(tokens[1]) + Long.parseLong(tokens[2])) + Long.parseLong(tokens[3])) + oci.getIdle()) + Long.parseLong(tokens[5])) + Long.parseLong(tokens[6]) + Long.parseLong(tokens[7]);
                    oci.setTotal(a);
                    result.add(oci);
                }
            }
        } catch (Exception e) {

        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {

                }
            }
        }
        return result;
    }

    public static int[] calcCpuUsages(ArrayList<OneCpuInfo> currentInfo, ArrayList<OneCpuInfo> lastInfo) {
        int[] iArr = null;
        if (!(currentInfo == null || lastInfo == null)) {
            int nLast = lastInfo.size();
            int nCurr = currentInfo.size();
            if (nLast == 0 || nCurr == 0) {
                Log.d("ERROR", " no info: [" + nLast + "][" + nCurr + "]");
            } else {
                int n;
                if (nLast < nCurr) {
                    n = nLast;
                } else {
                    n = nCurr;
                }
                iArr = new int[n];
                for (int i = 0; i < n; i++) {
                    OneCpuInfo last = (OneCpuInfo) lastInfo.get(i);
                    OneCpuInfo curr = (OneCpuInfo) currentInfo.get(i);
                    int totalDiff = (int) (curr.getTotal() - last.getTotal());
                    if (totalDiff > 0) {
                        iArr[i] = 100 - ((((int) (curr.getIdle() - last.getIdle())) * 100) / totalDiff);
                    } else {
                        iArr[i] = 0;
                    }
                }
            }
        }
        return iArr;
    }

    public static String formatFreq(int clockHz) {
        if (clockHz < 1000000) {
            return (clockHz / 1000) + " MHz";
        }
        return ((clockHz / 1000) / 1000) + "." + (((clockHz / 1000) / 100) % 10) + " GHz";
    }

    public static long getFreeMemorySize(Context context) throws Throwable {
        long total_ram = 0;
        try {
            RandomAccessFile reader = new RandomAccessFile("/proc/meminfo", "r");
            try {
                total_ram = Long.parseLong(reader.readLine().replaceAll("\\D+", BuildConfig.FLAVOR)) / 1024;
            } catch (IOException e) {
                return total_ram - getUsedMemorySize(context);
            }
        } catch (IOException e2) {
            return total_ram - getUsedMemorySize(context);
        }
        return total_ram - getUsedMemorySize(context);
    }

    public static long getTotalRam(Context context) throws Throwable {
        long total_ram = 0;

        RandomAccessFile reader = new RandomAccessFile("/proc/meminfo", "r");
        try {
            total_ram = Long.parseLong(reader.readLine().replaceAll("\\D+", BuildConfig.FLAVOR)) / 1024;
        } catch (IOException e) {
            return -1 ;
        }

        return total_ram;
    }

    public static long getUsedMemorySize(Context context) {
        ActivityManager activityManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        ActivityManager.MemoryInfo memoryInfo = new ActivityManager.MemoryInfo();
        activityManager.getMemoryInfo(memoryInfo);
        return memoryInfo.availMem / 1048576;
    }

    public static int getUsedRamPercent(Context context) throws Throwable {
        return (int) ((getUsedMemorySize(context) * 100) / (getUsedMemorySize(context) + getFreeMemorySize(context)));
    }


    //Lấy bộ nhớ Rom còn trống
    public static float getAvailableRom() {
        File path = Environment.getDataDirectory();
        StatFs stat = new StatFs(path.getPath());
        long bytesAvailable = 0;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.JELLY_BEAN_MR2)
            bytesAvailable = (long) stat.getBlockSizeLong() * (long) stat.getAvailableBlocksLong();
        else
            bytesAvailable = (long) stat.getBlockSize() * (long) stat.getAvailableBlocks();
        float total = bytesAvailable / (1024.f * 1024.f * 1024f);
        return total;
    }

    public static float getTotalRom() {
        File path = Environment.getDataDirectory();
        StatFs stat = new StatFs(Environment.getExternalStorageDirectory().getPath());
        long bytesAvailable = (long) stat.getBlockSize() * (long) stat.getBlockCount();
        long gbAvailable = bytesAvailable / (1048576 * 1024);
        return gbAvailable;
    }

    public static float getTemperatureCPU() {
        try {
            int freeRam = 0;
            Process process = Runtime.getRuntime().exec("cat sys/class/thermal/thermal_zone0/temp");
            process.waitFor();
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));
            String line = reader.readLine();
            if (line != null) {
                float temp = Float.parseFloat(line);
                return ((temp / 1000.0f) * 1.8f + 32);

            } else {
                return 51;
            }

        } catch (Exception ex) {
            return -1;
        }
    }

}
