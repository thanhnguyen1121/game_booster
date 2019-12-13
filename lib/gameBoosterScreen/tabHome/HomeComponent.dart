import 'dart:typed_data';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/gameBoosterScreen/tabHome/HomeViewModel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'HomePresenter.dart';

class HomeComponent extends StatefulWidget {
  @override
  _HomeComponentState createState() => _HomeComponentState();
}

class _HomeComponentState extends State<HomeComponent>
    with TickerProviderStateMixin
    implements BaseView {
  BasePresenter _presenter;
  HomeViewModel _viewModel;
  int currentIndex = 0;
  static var selectedPos = 2;
  AnimationController _controllerAnimate;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  CircularBottomNavigationController _navigationController;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.blue),
    new TabItem(Icons.layers, "Detail", Colors.red),
    new TabItem(Icons.assignment, "Device Info", Colors.cyan),
  ]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = new HomePresenter();
    _presenter.init(this);
    _navigationController = new CircularBottomNavigationController(selectedPos);
    _controllerAnimate = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    var percentStrogate;
    var percentCpu;
    var percentRom;
    bool isSelectAppToLaunch = false;
    int indexSelectAppToLaunch;

    if (_viewModel != null) {
      percentStrogate =
          int.parse(_viewModel.dataDevices["percentageMemory"]) / 100;
      percentCpu = int.parse(_viewModel.dataDevices["temperatureCPU"]) / 100;
      percentRom = int.parse(_viewModel.dataDevices["percentageRom"]) / 100;

      print("cpu:" + percentCpu.toString());

//      print("percent cpu:" + percentCpu.toString());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Game Booster"),
      ),
      body: _viewModel != null
          ? Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black12,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20, left: 60),
                            child: CircularPercentIndicator(
                                radius: 150.0,
                                lineWidth: 4.0,
                                percent: percentStrogate,
                                startAngle: 135.0,
                                center: _buildInSideStrogate(),
                                progressColor: percentStrogate <= 0.5
                                    ? Colors.green
                                    : percentStrogate > 0.5 &&
                                            percentStrogate <= 0.8
                                        ? Colors.amber
                                        : Colors.red),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3, left: 250),
                            child: CircularPercentIndicator(
                              radius: 90.0,
                              lineWidth: 4.0,
                              percent: percentCpu - 0.5,
                              startAngle: 180.0,
                              center: _buildInSideCPU(),
                              progressColor: percentCpu - 0.5 <= 0.85
                                  ? Colors.green
                                  : percentCpu - 0.5 > 0.85 &&
                                          percentCpu - 0.5 <= 1
                                      ? Colors.amber
                                      : Colors.red,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 80, left: 180),
                            child: CircularPercentIndicator(
                              radius: 120.0,
                              lineWidth: 4.0,
                              percent: percentRom,
                              startAngle: 180.0,
                              center: _buildInSideRam(),
                              progressColor: percentRom <= 0.5
                                  ? Colors.green
                                  : percentRom > 0.5 && percentRom < 0.8
                                      ? Colors.amber
                                      : Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                        elevation: 5.0,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "lib/images/bgkgrnd_main.png",
                                      ),
                                      fit: BoxFit.fitWidth)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: <Widget>[
                                        RotationTransition(
                                          turns: Tween(begin: 0.0, end: 1.0)
                                              .animate(_controllerAnimate),
                                          child: Image.asset(
                                            "lib/images/ic_circle.png",
                                            width: 80,
                                            height: 80,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 17.0),
                                          child: _viewModel.isSelectedApp ==
                                                  true
                                              ? Image.memory(
                                                  new Uint8List.fromList(List<
                                                      int>.from(_viewModel
                                                              .listAppBoosterSelected[
                                                          _viewModel
                                                              .indexSelectedApp]
                                                      ["icon"])),
                                                  width: 40.0,
                                                  height: 40.0)
                                              : SizedBox(
                                                  width: 0,
                                                ),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text("Add games and Apps"),
                                      _viewModel.showProcess
                                          ? Container(
                                              margin: EdgeInsets.only(top: 10),
                                              padding: EdgeInsets.only(
                                                  top: 5.0, bottom: 5.0),
                                              child: new LinearPercentIndicator(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    152,
                                                animation: true,
                                                lineHeight: 5.0,
                                                animationDuration: 2500,
                                                percent: 1.0,
                                                linearStrokeCap:
                                                    LinearStrokeCap.roundAll,
                                                progressColor: Colors.green,
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      _presenter.action(
                                          Constances.GET_ALL_APP_FROM_SYSTEM,
                                          {"context": context});
                                    }),
                              ],
                            ),
                          ],
                        )),
                    _viewModel.listAppBoosterSelected.length != 0
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 15.0, right: 15.0, bottom: 70.0),
                            child: GridView.count(
                                childAspectRatio: 200 / 80,
                                shrinkWrap: true,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                crossAxisCount: 2,
                                physics: ScrollPhysics(),
                                children: new List<Widget>.generate(
                                    _viewModel.listAppBoosterSelected.length,
                                    (index) {
                                  var item =
                                      _viewModel.listAppBoosterSelected[index];
                                  var icon = List<int>.from(item["icon"]);

                                  return new GridTile(
                                    child: Container(
                                      width: 120.0,
                                      height: 80,
                                      child: new Card(
                                          color: Colors.blue.shade200,
                                          child: ListTile(
                                            onTap: () {
                                              _controllerAnimate.forward(
                                                  from: 0.0);
                                              setState(() {
                                                _viewModel.isSelectedApp = true;
                                                _viewModel.indexSelectedApp =
                                                    index;
                                              });
//
                                              _presenter.action(
                                                  Constances.LAUNCH_APP, {
                                                "context": context,
                                                "launch_app": _viewModel
                                                        .listAppBoosterSelected[
                                                    index]["packageName"]
                                              });
                                            },
                                            leading: Image.memory(
                                              new Uint8List.fromList(icon),
                                              width: 40.0,
                                              height: 40.0,
                                            ),
                                            title: Text(
                                              item["appName"],
                                              style: TextStyle(fontSize: 13.0),
                                            ),
                                          )),
                                    ),
                                  );
                                })),
                          )
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text("No App <3"),
                            ),
                          )
                  ],
                ),
                _viewModel.isLoadAds
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment(0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment(0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
    );
  }

  _buildInSideStrogate() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _viewModel.dataDevices["percentageRom"].toString(),
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 3.0),
                child: Text(
                  "%",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _viewModel.dataDevices["usedRom"].toString() + "Gb",
                  style: TextStyle(color: Colors.blue, fontSize: 12.0),
                ),
                Text("/" + _viewModel.dataDevices["totalRom"].toString() + "Gb",
                    style: TextStyle(color: Colors.black, fontSize: 12.0))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text("Strogate",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20)),
          ),
        ],
      ),
    );
  }

  _buildInSideCPU() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _viewModel.dataDevices["temperatureCPU"].toString(),
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              Text(
                "°F",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ],
          ),
          Text("CPU",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20)),
        ],
      ),
    );
  }

  _buildInSideRam() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _viewModel.dataDevices["percentageMemory"].toString(),
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "%",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _viewModel.dataDevices["freeMemory"].toString(),
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
              Text(
                  "/" + _viewModel.dataDevices["totalMemory"].toString() + "Mb",
                  style: TextStyle(color: Colors.black, fontSize: 12.0))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("RAM",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
        ],
      ),
    );
  }

  @override
  uiUpdate(viewModel) {
    setState(() {
      _viewModel = viewModel;
    });
  }
}
