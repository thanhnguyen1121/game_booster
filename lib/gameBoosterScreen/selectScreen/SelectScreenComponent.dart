import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/gameBoosterScreen/tabDetailFunction/DetailFunctionComponent.dart';
import 'package:guide_gaming/gameBoosterScreen/tabDeviceInfo/DeviceInfoComponent.dart';
import 'package:guide_gaming/gameBoosterScreen/tabHome/HomeComponent.dart';

import 'SelectScreenPresenter.dart';

class SelectScreenComponent extends StatefulWidget {
  @override
  _SelectScreenComponentState createState() => _SelectScreenComponentState();
}

class _SelectScreenComponentState extends State<SelectScreenComponent>
    implements BaseView {
  BasePresenter _presenter;

  int currentIndex = 0;

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
    _presenter = new SelectScreenPresenter();
    _presenter.init(this);
    _navigationController = new CircularBottomNavigationController(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                _navigationController.value = currentIndex;
              });
//              setState(() {
//                currentIndex = index;
//              });
              print("onPageChanged currentIndex" + currentIndex.toString());
            },
            children: <Widget>[
              HomeComponent(),
              DetailFunctionComponent(),
              DeviceInfoComponent(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CircularBottomNavigation(
              tabItems,
              selectedPos: currentIndex,
              selectedCallback: (int selectedPos) {
                setState(() {
                  currentIndex = selectedPos;
                  pageController.animateToPage(selectedPos,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease);
                });
                print("clicked on $currentIndex");
              },
              controller: _navigationController,
            ),
          )
        ],
      ),
    );
  }

  @override
  uiUpdate(viewModel) {
    // TODO: implement uiUpdate
    return null;
  }
}
