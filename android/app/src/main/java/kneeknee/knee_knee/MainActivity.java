package kneeknee.knee_knee;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothDevice;
import android.os.Bundle;
import android.os.Handler;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

import com.harrysoft.androidbluetoothserial.BluetoothManager;
import com.harrysoft.androidbluetoothserial.BluetoothSerialDevice;
import com.harrysoft.androidbluetoothserial.SimpleBluetoothDeviceInterface;

import java.util.ArrayList;
import java.util.List;
//import 'dart:developer';

public class MainActivity extends FlutterActivity {

  private SimpleBluetoothDeviceInterface deviceInterface;
  BluetoothManager bluetoothManager;
  String hcman = "20:18:07:13:56:00";
  List<String> list = new ArrayList<String>();

  //hcman is string used to hold mac adress of hc05

  private static final String CHANNEL = "get_w_data";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

// Setup our BluetoothManager
    bluetoothManager = BluetoothManager.getInstance();

    List<BluetoothDevice> pairedDevices = bluetoothManager.getPairedDevicesList();


    for (BluetoothDevice device : pairedDevices) {
      Log.d("My Bluetooth App", "Device name: " + device.getName());
      if(device.getName() == "HC-05"){hcman = device.getAddress();}
      Log.d("My Bluetooth App", "Device MAC Address: " + device.getAddress());
    }



    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                // Note: this method is invoked on the main thread.

                if (call.method.equals("xxxxx")) {

//                  text = call.argument("text");
//                  String batteryLevel = RandomFunction(text);

//                  twentysecfunc();
                  Log.d("My Bluetooth App", "c1" );
                  connectDevice(hcman);
                  Log.d("My Bluetooth App", "c2" );

                  //delay 20 seconds
                  final Handler handler = new Handler();
                  handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                      //Do something after 20000ms
                      onCloseConnection();
                      if (list != null) {
                        result.success(list);
                        list.clear();
                      } else {
                        result.error("...ERROR", "some error happened", null);
                      }
                    }
                  }, 20000);

//                  if (list != null) {
//                    result.success(list);
//                    list.clear();
//                  } else {
//                    result.error("...ERROR", "some error happened", null);
//                  }
                } else {
                  result.notImplemented();
                }
              }
            });

  }

//  private void twentysecfunc(){
//    Log.d("My Bluetooth App", "c1" );
//    connectDevice(hcman);
//    Log.d("My Bluetooth App", "c2" );
//
//    //delay 20 seconds
//    final Handler handler = new Handler();
//    handler.postDelayed(new Runnable() {
//      @Override
//      public void run() {
//        //Do something after 20000ms
//        onCloseConnection();
//      }
//    }, 20000);
//  }

//  @SuppressLint("CheckResult")
  private void connectDevice(String mac) {
    bluetoothManager.openSerialDevice(mac)
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(this::onConnected, this::onError);
  }

  private void onConnected(BluetoothSerialDevice connectedDevice) {
    // You are now connected to this device!
    // Here you may want to retain an instance to your device:
    deviceInterface = connectedDevice.toSimpleDeviceInterface();

    // Listen to bluetooth events
    deviceInterface.setListeners(this::onMessageReceived, this::onMessageSent, this::onError);

    Log.d("My Bluetooth App", "On Connected XX");
  }

  private void onMessageSent(String s) {
    //
  }

  private void onMessageReceived(String message) {
    Log.d("My Bluetooth App", message);
    list.add(message);
  }

  private void onError(Throwable error) {
    Log.d("My Bluetooth App", "Error:  "+error);
  }

  private void onCloseConnection(){
    bluetoothManager.closeDevice(deviceInterface); // Close by interface instance

  }
}
