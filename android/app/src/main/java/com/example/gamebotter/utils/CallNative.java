package com.example.gamebotter.utils;


import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.icu.text.DecimalFormat;
import android.net.Uri;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.MediaStore;
import android.util.DisplayMetrics;
import android.widget.Toast;

import androidx.annotation.RequiresApi;

import com.crashlytics.android.answers.Answers;
import com.crashlytics.android.answers.CustomEvent;
import com.example.gamebotter.App;
import com.example.gamebotter.Entity.DeviceInfo;
import com.example.gamebotter.Entity.DeviceSystemInfo;
import com.example.gamebotter.utils.booster.CPURAMUtil;
import com.example.gamebotter.utils.booster.RAMBooster;
import com.example.gamebotter.utils.sharedpref.SharedPrefsUtils;
import com.example.ratedialog.RatingDialog;
import com.google.gson.Gson;

import java.util.Timer;
import java.util.TimerTask;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class CallNative implements EventChannel.StreamHandler, RatingDialog.RatingDialogInterFace {
    private static final String CHANNEL = "CALL_FLUTTER_NATIVE";
    private static final String SET_WALLPAPER = "SET_WALLPAPER";
    Context context;

    public void showRateDialog() {
        if (App.RATE) {
            App.RATE = false;
            int count = SharedPrefsUtils.getInstance(context).getInt("rate");

            if (count < 2) {
                RatingDialog ratingDialog = new RatingDialog(context);
                ratingDialog.setRatingDialogListener(this);
                ratingDialog.showDialog();
            }
        }


    }


    public void addVideoToGallery(final String filePath, final Context context) {
        ContentValues values = new ContentValues();
        values.put(MediaStore.Video.Media.DATA, filePath);
        context.getContentResolver().insert(
                MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
        context.sendBroadcast(new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, Uri.parse(filePath)));

    }

    public static final String CALL_NATIVE_FLUTTER = "CALL_NATIVE_FLUTTER";
    private String TAG = CallNative.class.getSimpleName();

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void callFlutterNative(FlutterActivity context) {
        this.context = context;

        new MethodChannel(context.getFlutterView(), CHANNEL).setMethodCallHandler(
//
                (methodCall, result) -> {

                    if (methodCall.method.equals("TRAKING")) {
                        Answers.getInstance().logCustom(new CustomEvent("CLick : " + methodCall.argument("id"))); // not good
                    }




                    if (methodCall.method.equals("RATE")) {
                        showRateDialog();
                    }
                    if (methodCall.method.equals("BOOSTER")) {
                        RAMBooster ramBooster = new RAMBooster(context);
                        int booster = ramBooster.clearRAM();
                        Intent intent = context.getPackageManager()
                                .getLaunchIntentForPackage(methodCall.argument("id"));
                        if (intent == null) {
                            Toast.makeText(context, "errror", Toast.LENGTH_SHORT).show();
                            return;
                        }

                        intent.addCategory("android.intent.category.LAUNCHER");
                        context.startActivity(intent);
                        Toast.makeText(context, "boosted " + booster + "Mb", Toast.LENGTH_SHORT).show();
                    }
                    if (methodCall.method.equals("GET_SYSTEM_INFO")) {
                        DeviceSystemInfo deviceSystemInfo = new DeviceSystemInfo();
                        DisplayMetrics dm = new DisplayMetrics();
                        context.getWindowManager().getDefaultDisplay().getMetrics(dm);

                        deviceSystemInfo.setResolution("" + dm.heightPixels + "x" + dm.widthPixels);
                        deviceSystemInfo.setScreenSize("" + (double)Math.round(Math.sqrt(Math.pow(dm.widthPixels / dm.xdpi, 2) + Math.pow(dm.heightPixels / dm.ydpi, 2))*10)/10);
                        deviceSystemInfo.setModel(Build.MODEL.toString());
                        deviceSystemInfo.setCpu(Build.HARDWARE.toString());
                        deviceSystemInfo.setAndroiVersion(Build.VERSION.RELEASE.toString());


                        deviceSystemInfo.setCpuCore(Runtime.getRuntime().availableProcessors() + "");

                        IntentFilter iFilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);


                        result.success(new Gson().toJson(deviceSystemInfo));


                    }
                    if(methodCall.method.equals("GET_RAM_ROM_INFO")){
                        try {
                            System.out.println("vào hàm");
                            float totalRam = CPURAMUtil.getTotalRam(context);
                            float freeRam = CPURAMUtil.getFreeMemorySize(context);
                            int percentRam = (int) (((freeRam) / totalRam) * 100);
                            float totalRom = CPURAMUtil.getTotalRom();
                            float useRom = totalRom - CPURAMUtil.getAvailableRom();
                            int percentRom = (int) (((useRom) / totalRom) * 100);

                            DeviceInfo deviceInfo = new DeviceInfo(
                                    new DecimalFormat(".##").format(totalRam).toString(),
                                    new DecimalFormat(".##").format(freeRam).toString(),
                                    new DecimalFormat("##").format(percentRam).toString(),
                                    new DecimalFormat("##").format(CPURAMUtil.getTemperatureCPU()).toString(),
                                    new DecimalFormat(".##").format(totalRom).toString(),
                                    new DecimalFormat(".##").format(useRom).toString(),
                                    new DecimalFormat("##").format(percentRom).toString());
                            result.success(new Gson().toJson(deviceInfo));
                            // eventSink.success(i + "");
                        } catch (Throwable throwable) {
                            System.out.println("lỗi");
                            throwable.printStackTrace();
                        }
                    }
                    if(methodCall.method.equals("BOOSTER_RAM")){
                        RAMBooster ramBooster = new RAMBooster(context);
                        int booster = ramBooster.clearRAM();
                        result.success(booster+"");
                    }

                    if(methodCall.method.equals("GET_NETWORK_SPEED")){
                        WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
                        WifiInfo wifiInfo = wifiManager.getConnectionInfo();
                        if (wifiInfo != null) {
                            Integer linkSpeed = wifiInfo.getLinkSpeed();
                            System.out.println("aaaaaaaaaaaa:" +linkSpeed.toString());//measured using WifiInfo.LINK_SPEED_UNITS
                            result.success(linkSpeed.toString());
                        }
                    }


                }
        );
    }


    int i;

    Timer myTimer;
    TimerTask doThis;
    Handler handler = new Handler(Looper.getMainLooper());

    public void callNativeFlutter(FlutterActivity context) {
        i = 0;
        new EventChannel(context.getFlutterView(), CALL_NATIVE_FLUTTER).setStreamHandler(this);
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {


        myTimer = new Timer();
        int delay = 0;   // delay for 30 sec.
        int period = 5000;  // repeat every 60 sec.
        doThis = new TimerTask() {
            @RequiresApi(api = Build.VERSION_CODES.N)
            public void run() {
                i++;
                handler.post(() -> {
                    try {
                        float totalRam = CPURAMUtil.getTotalRam(context);
                        float freeRam = CPURAMUtil.getFreeMemorySize(context);
                        int percentRam = (int) (((freeRam) / totalRam) * 100);
                        float totalRom = CPURAMUtil.getTotalRom();
                        float useRom = totalRom - CPURAMUtil.getAvailableRom();
                        int percentRom = (int) (((useRom) / totalRom) * 100);

                        DeviceInfo deviceInfo = new DeviceInfo(
                                new DecimalFormat(".##").format(totalRam).toString(),
                                new DecimalFormat(".##").format(freeRam).toString(),
                                new DecimalFormat("##").format(percentRam).toString(),
                                new DecimalFormat("##").format(CPURAMUtil.getTemperatureCPU()).toString(),
                                new DecimalFormat(".##").format(totalRom).toString(),
                                new DecimalFormat(".##").format(useRom).toString(),
                                new DecimalFormat("##").format(percentRom).toString());
                        eventSink.success(new Gson().toJson(deviceInfo).toString());
                        // eventSink.success(i + "");
                    } catch (Throwable throwable) {
                        throwable.printStackTrace();
                    }

                });


            }
        };

        myTimer.scheduleAtFixedRate(doThis, delay, period);

    }

    @Override
    public void onCancel(Object o) {
        myTimer.cancel();

    }

    @Override
    public void onDismiss() {

    }

    @Override
    public void onSubmit(float rating) {
        int count = SharedPrefsUtils.getInstance(context).getInt("rate");
        count++;
        SharedPrefsUtils.getInstance().putInt("rate", count);
        UtilsMenu.rateApp(context);
//        LogUtils.e("onSubmit" + rating);

    }


    @Override
    public void onRatingChanged(float rating) {
//        LogUtils.e("onRatingChanged" + rating);
    }



}
