package com.example.gamebotter;

import android.os.Build;
import android.os.Bundle;

import androidx.annotation.RequiresApi;

import com.example.gamebotter.utils.CallNative;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;


public class MainActivity extends FlutterActivity {

    CallNative callNative;

    @RequiresApi(api = Build.VERSION_CODES.N)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        callNative = new CallNative();

        callNative.callFlutterNative(this);
        callNative.callNativeFlutter(this);



    }


}
