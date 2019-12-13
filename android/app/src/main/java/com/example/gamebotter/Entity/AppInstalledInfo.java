package com.example.gamebotter.Entity;

import android.graphics.drawable.Drawable;

public class AppInstalledInfo {
    String appname;
    String packageName;
    Drawable icon;

    public AppInstalledInfo() {
    }

    public String getAppname() {
        return appname;
    }

    public void setAppname(String appname) {
        this.appname = appname;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public Drawable getIcon() {
        return icon;
    }

    public void setIcon(Drawable icon) {
        this.icon = icon;
    }
}
