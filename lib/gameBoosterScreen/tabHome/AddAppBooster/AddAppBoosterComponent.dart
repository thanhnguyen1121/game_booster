import 'package:flutter/material.dart';
import 'package:guide_gaming/base/BasePresenter.dart';
import 'package:guide_gaming/base/BaseView.dart';
import 'package:guide_gaming/constances/Constances.dart';

import 'AddAppBoosterPresenter.dart';
import 'AddAppBoosterViewModel.dart';

class AddAppBoosterComponent extends StatefulWidget {
  @override
  _AddAppBoosterComponentState createState() => _AddAppBoosterComponentState();
}

class _AddAppBoosterComponentState extends State<AddAppBoosterComponent>
    implements BaseView {
  BasePresenter _presenter;
  AddAppBoosterViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = new AddAppBoosterPresenter();
    _presenter.init(this);
  }

  var dataSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _presenter.action(Constances.INTENT_BACK, {
                "context": context,
                "data": {"ahihii": "bbbbbbb"}
              });
            }),
        title: Text("Add game booster"),
      ),
      body: _viewModel != null
          ? Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: ListView.builder(
                      itemCount: _viewModel.dataApp.length,
                      itemBuilder: (context, index) {
                        var item = _viewModel.dataApp[index];
                        return Card(
                          elevation: 4.0,
                          child: ListTile(
                            onTap: () {
                              _presenter.action("CHANE_SATE_APP", index);
                            },
                            leading: Image.memory(item['icon']),
                            title: Text(item['appName']),
                            trailing: item['check']
                                ? Icon(Icons.check_box)
                                : Icon(Icons.check_box_outline_blank),
                          ),
                        );
                      }),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _presenter.action(Constances.INTENT_BACK, {
            "context": context,
            "data": {"data": dataSelected}
          });
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.green,
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
