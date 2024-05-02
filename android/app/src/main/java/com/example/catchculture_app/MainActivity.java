package com.example.catchculture_app;
import android.webkit.CookieManager;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    public void onCreate() {

        // 쿠키 허용
        CookieManager cookieManager = CookieManager.getInstance();
        cookieManager.setAcceptCookie(true);
    }
}
