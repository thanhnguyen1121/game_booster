package com.example.gamebotter;

import android.content.Context;

import com.crashlytics.android.Crashlytics;

import com.eqwmypdome.adx.service.AdsExchange;
import com.google.firebase.FirebaseApp;

import io.fabric.sdk.android.Fabric;
import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    static Context context;
    public static boolean RATE = true;
    public static Context getContext() {
        return context;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        FirebaseApp.initializeApp(this);
        Fabric.with(this, new Crashlytics());
        context = this;
        AdsExchange.init(this, "5df0b29c0e95af0e4f9c44ff");
    }
}
