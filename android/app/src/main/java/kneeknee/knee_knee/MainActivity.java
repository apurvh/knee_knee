package kneeknee.knee_knee;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothDevice;
import android.os.Bundle;

import io.flutter.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.schedulers.Schedulers;

import com.harrysoft.androidbluetoothserial.BluetoothManager;
import com.harrysoft.androidbluetoothserial.BluetoothSerialDevice;
import com.harrysoft.androidbluetoothserial.SimpleBluetoothDeviceInterface;

import java.util.List;
//import 'dart:developer';

public class MainActivity extends FlutterActivity {

  private SimpleBluetoothDeviceInterface deviceInterface;
  BluetoothManager bluetoothManager;
  String hcman = "20:18:07:13:56:00";
  //hc man is string used to hold mac adress of hc05

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

    Log.d("My Bluetooth App", "c1" );
    connectDevice(hcman);
    Log.d("My Bluetooth App", "c2" );


  }

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

  }

  private void onError(Throwable error) {
    Log.d("My Bluetooth App", "Error:  "+error);
  }
}
