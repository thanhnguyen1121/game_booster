package com.example.gamebotter;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.eqwmypdome.adx.service.AdsExchange;
import com.eqwmypdome.adx.service.SplashAdRequest;


public class OneAC extends Activity {
    int i = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        SplashAdRequest adRequest = new SplashAdRequest();
        adRequest.setAlwayShowAd(true);
        adRequest.setBannerId("ca-app-pub-3082814971751832/1023564566");

//        adRequest.setBannerId("ca-app-pub-3940256099942544/6300978111");
        adRequest.setResLogo(R.mipmap.launcher_icon);
        adRequest.setResBanner(R.mipmap.bannerr);
        adRequest.setPermissions(new String[]{android.Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.CAMERA});
        AdsExchange.loadSplashAd(this, adRequest);
//        Intent myIntent = new Intent(this, MainActivity.class);
//        startActivity(myIntent);
//        finish();
    }

    @Override
    protected void onResume() {
        super.onResume();
        i++;
        if (i > 1) {
            Intent myIntent = new Intent(this, MainActivity.class);
            startActivity(myIntent);
            finish();
        }

    }
}
