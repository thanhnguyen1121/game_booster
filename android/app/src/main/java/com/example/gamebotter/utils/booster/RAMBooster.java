package com.example.gamebotter.utils.booster;

import android.app.Activity;
import android.content.Context;

import java.util.List;

public class RAMBooster {
    private Context context;
    private int free_memory;

    public RAMBooster(Context context ) {
        this.context = context;

    }

    public int getUnusedRAM() {
        try {
            return CPURAMUtil.getUsedRamPercent(this.context.getApplicationContext());
        } catch (Throwable throwable) {

            return 0;
        }
    }

    public int clearRAM() {
        RAMBoosterUtil.getInstance().freeMemory(this.context);
        try {
            this.free_memory = (int) CPURAMUtil.getFreeMemorySize(this.context.getApplicationContext());
        } catch (Throwable throwable) {
            this.free_memory = 0;
        }
        return this.free_memory;
    }
    public String getDeviceInfo(Activity activity){
        try {
            List<Integer> listRamStatus = RAMBoosterUtil.getInstance().getMemoryStatus(activity);

            return listRamStatus.toString();
        }catch (Exception ex){
            return "-1";
        }
    }
}