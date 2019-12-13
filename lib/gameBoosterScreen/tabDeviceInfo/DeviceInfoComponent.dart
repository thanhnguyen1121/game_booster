import 'package:flutter/material.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/gameBoosterScreen/tabDeviceInfo/DeviceInfoViewModel.dart';

import 'DeviceInfoPresenter.dart';

class DeviceInfoComponent extends StatefulWidget {
  @override
  _DeviceInfoComponentState createState() => _DeviceInfoComponentState();
}

class _DeviceInfoComponentState extends State<DeviceInfoComponent>
    implements BaseView {
  BasePresenter _presenter;
  DeviceInfoViewModel _viewModel;

  int currentIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = new DeviceInfoPresenter();
    _presenter.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Device Information"),
        ),
        body: ListView(
          children: <Widget>[_buildContent()],
        ));
  }

  _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100.0),
      child: _viewModel != null
          ? Column(
              children: <Widget>[
                Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.assignment,
                                size: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Device Information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Model:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataSystem["model"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "CPU:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataSystem["cpu"].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Screen Size:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataSystem["screenSize"]
                                          .toString() +
                                      " Inch",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Ram:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (double.parse(_viewModel
                                                  .dataMemory["totalRAM"]
                                                  .toString()) /
                                              (1024 * 1024 * 1024))
                                          .toStringAsFixed(2) +
                                      " Gb",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Available Stogate:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (double.parse(_viewModel.dataMemory[
                                                      "availableInternalMemorySize"]
                                                  .toString()) /
                                              (1024 * 1024 * 1024))
                                          .toStringAsFixed(2) +
                                      " Gb",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Stogate:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (double.parse(_viewModel.dataMemory[
                                                      "totalInternalMemorySize"]
                                                  .toString()) /
                                              (1024 * 1024 * 1024))
                                          .toStringAsFixed(2) +
                                      " Gb",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Resolution:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataSystem["resolution"]
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Android version:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataSystem["androiVersion"]
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Card(
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.battery_unknown,
                                size: 40,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Battery Information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25.0),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Battery Percentage:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataBattery["batteryPercentage"]
                                          .toString() +
                                      "%",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Battery Technology:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataBattery["batteryTechnology"]
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Charging Source:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataBattery["chargingSource"]
                                      .toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Battery Temperature:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (_viewModel.dataBattery["batteryTemperature"]
                                          .toStringAsFixed(1) +
                                      "°C"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Battery Health:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (_viewModel.dataBattery["batteryHealth"]
                                      .toString()),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Device Charging:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  (_viewModel.dataBattery["isDeviceCharging"]
                                      .toString()),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Battery Voltage:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                ),
                                Text(
                                  _viewModel.dataBattery["batteryVoltage"]
                                          .toString() +
                                      "mV",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.0,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment(0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
    );
  }

  @override
  uiUpdate(viewModel) {
    setState(() {
      _viewModel = viewModel;
    });
    print("aaaaaa:" + _viewModel.dataSystem.toString());
    print("aaaaaa:" + _viewModel.dataMemory.toString());
    print("aaaaaa:" + _viewModel.dataBattery.toString());
  }
}
