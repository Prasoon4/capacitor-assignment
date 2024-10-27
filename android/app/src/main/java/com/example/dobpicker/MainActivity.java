package com.example.dobpicker;

import android.os.Bundle;
import com.example.dobpicker.plugin.DialogPlugin;
import com.getcapacitor.BridgeActivity;

public class MainActivity extends BridgeActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        registerPlugin(DialogPlugin.class);
        super.onCreate(savedInstanceState);
    }
}
