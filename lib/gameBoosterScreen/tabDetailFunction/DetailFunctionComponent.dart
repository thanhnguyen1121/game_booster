import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';
import 'package:guide_gaming/gameBoosterScreen/tabDetailFunction/DetailFunctionViewModel.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'DetailFunctionPresenter.dart';

class DetailFunctionComponent extends StatefulWidget {
  @override
  _DetailFunctionComponentState createState() =>
      _DetailFunctionComponentState();
}

class _DetailFunctionComponentState extends State<DetailFunctionComponent>
    implements BaseView {
  BasePresenter _presenter;
  DetailFunctionViewModel _viewModel;

  int currentIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = new DetailFunctionPresenter();
    _presenter.init(this);
  }

  @override
  Widget build(BuildContext context) {
    var usedRam, totalRam, percentRam;
    var usedStorage, totalStorage, percentStorage;
    var temperatureCPU;

    if (_viewModel != null) {
      usedRam = double.parse(_viewModel.dataRam["freeMemory"]);
      totalRam = double.parse(_viewModel.dataRam["totalMemory"]);
      percentRam = usedRam / totalRam;
      usedStorage = double.parse(_viewModel.dataRam["usedRom"]);
      totalStorage = double.parse(_viewModel.dataRam["totalRom"]);
      percentStorage = usedStorage / totalStorage;
      temperatureCPU = double.parse(_viewModel.dataRam["temperatureCPU"]) / 100;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        backgroundColor: Colors.green,
      ),
      body: _viewModel != null
          ? Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
//                                color: Colors.red,
                                child: Text(
                                  "RAM",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Icon(Icons.wifi),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: LinearPercentIndicator(
                                                    width: 250.0,
                                                    lineHeight: 14.0,
                                                    percent: percentRam,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    progressColor: percentRam <=
                                                            0.5
                                                        ? Colors.blue
                                                        : percentRam > 0.5 &&
                                                                percentRam <=
                                                                    0.8
                                                            ? Colors.amber
                                                            : Colors.red,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            usedRam.toString() +
                                                                "/",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          Text(totalRam
                                                                  .toString() +
                                                              "Mb")
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            _presenter.action(
                                                                Constances
                                                                    .CLICK_BOOSTER_RAM,
                                                                {
                                                                  "context":
                                                                      context
                                                                });
                                                          },
                                                          child:
                                                              Text("Booster"))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
//                                color: Colors.red,
                                child: Text(
                                  "Storage",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Icon(Icons.wifi),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: LinearPercentIndicator(
                                                    width: 250.0,
                                                    lineHeight: 14.0,
                                                    percent: percentStorage,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    progressColor:
                                                        percentStorage <= 0.5
                                                            ? Colors.blue
                                                            : percentStorage >
                                                                        0.5 &&
                                                                    percentStorage <=
                                                                        0.8
                                                                ? Colors.amber
                                                                : Colors.red,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            usedStorage
                                                                    .toString() +
                                                                "/",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          Text(totalStorage
                                                                  .toString() +
                                                              "Gb")
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            _presenter.action(
                                                                Constances
                                                                    .CLICK_BOOSTER_STORAGE,
                                                                {
                                                                  "context":
                                                                      context
                                                                });
                                                          },
                                                          child: Text("Clearn"))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(left: 8.0),
                                alignment: Alignment.centerLeft,
                                width: double.infinity,
//                                color: Colors.red,
                                child: Text(
                                  "CPU",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Icon(Icons.wifi),
                                          )),
                                      Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: LinearPercentIndicator(
                                                    width: 250.0,
                                                    lineHeight: 14.0,
                                                    percent:
                                                        temperatureCPU - 0.5,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    progressColor: temperatureCPU -
                                                                0.5 <=
                                                            0.5
                                                        ? Colors.blue
                                                        : temperatureCPU - 0.5 >
                                                                    0.5 &&
                                                                temperatureCPU -
                                                                        0.5 <=
                                                                    0.8
                                                            ? Colors.amber
                                                            : Colors.red,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            (temperatureCPU *
                                                                        100)
                                                                    .toString() +
                                                                " ℉",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                        ],
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            _presenter.action(
                                                                Constances
                                                                    .CLICK_BOOSTER_STORAGE,
                                                                {
                                                                  "context":
                                                                      context
                                                                });
                                                          },
                                                          child:
                                                              Text("Cool Down"))
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      child: Card(
                        elevation: 5.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Network",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(Icons.wifi),
                                  Column(
                                    children: <Widget>[
                                      Text("Comming soon"),
                                      Text("Comming soon")
                                    ],
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _presenter.action(
                                            Constances.CLICK_NETWORK,
                                            {"context": context});
                                      },
                                      child: Text("Detail"))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox.shrink(),
                  )
                ],
              ),
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

  @override
  uiUpdate(viewModel) {
    setState(() {
      _viewModel = viewModel;
    });
  }
}
