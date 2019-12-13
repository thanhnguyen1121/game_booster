package com.example.gamebotter.Entity;

public class DeviceInfo {
    String totalMemory;
    String freeMemory;
    String percentageMemory;
    String temperatureCPU;
    String totalRom;
    String usedRom;
    String percentageRom;

    public DeviceInfo(String totalMemory, String freeMemory, String percentageMemory, String temperatureCPU, String totalRom, String usedRom, String percentageRom) {
        this.totalMemory = totalMemory;
        this.freeMemory = freeMemory;
        this.percentageMemory = percentageMemory;
        this.temperatureCPU = temperatureCPU;
        this.totalRom = totalRom;
        this.usedRom = usedRom;
        this.percentageRom = percentageRom;
    }
}
