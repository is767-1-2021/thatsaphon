import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/controllers/historyController.dart';
import 'package:final_app/models/historyModel.dart';
import 'package:final_app/pages/historyPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _topDisplayState = "";
  String _mainDisplayState = "0";
  String _temporyMainDisplayState = "0";
  bool _isMainStateChanged = false;
  String _operation = "";

  double excuteOperator(String a, String operator, String n) {
    if (a.contains("(")) a = a.substring(1, a.length - 1);
    if (n.contains("(")) n = n.substring(1, n.length - 1);
    if (operator == "÷") return double.parse(a) / double.parse(n);
    if (operator == "×") return double.parse(a) * double.parse(n);
    if (operator == "+") return double.parse(a) + double.parse(n);
    if (operator == "-") return double.parse(a) - double.parse(n);

    return double.parse(a);
  }

  @override
  Widget build(BuildContext context) {
    calculate() {
      if (_mainDisplayState == "0" &&
          _isMainStateChanged == false &&
          _topDisplayState == "") {
        return null;
      }
      if (_mainDisplayState == "0" &&
          _isMainStateChanged == false &&
          _operation != "")
        setState(() {
          _topDisplayState =
              _topDisplayState.substring(0, _topDisplayState.length - 3);
        });
      if (_mainDisplayState != "0")
        setState(() {
          _topDisplayState += _mainDisplayState;
        });
      var splited = _topDisplayState.split(" ");
      if (splited.length == 1) {
        _topDisplayState = "";
        return;
      }
      print(splited);
      double accumulateCal = 0;
      if (splited.length < 2) accumulateCal = double.parse(splited[0]);
      for (var i = 0; i < splited.length; i++) {
        if (i > 1) {
          if (i != 2 && i % 2 == 0) {
            accumulateCal = excuteOperator(
                accumulateCal.toString(), splited[i - 1], splited[i]);
          }
          if (i == 2 && i % 2 == 0) {
            accumulateCal =
                excuteOperator(splited[i - 2], splited[i - 1], splited[i]);
          }
        }
      }
      if (accumulateCal.toString().length > 13) {
        _temporyMainDisplayState = "Error";
        _mainDisplayState = "0";
        _topDisplayState = "";
        _operation = "";
        _isMainStateChanged = false;
        return;
      }
      context.read<HistoriesModel>().addHistory(HistoryModel(
          _topDisplayState, accumulateCal.toString(), Timestamp.now()));
      HistoryController()
          .addHistory(_topDisplayState, accumulateCal.toString());
      setState(() {
        _temporyMainDisplayState = accumulateCal.toString();
        _mainDisplayState = "0";
        _topDisplayState = "";
        _operation = "";
        _isMainStateChanged = false;
      });
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Standard"),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.open_in_new))
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryPage()));
            },
            child: Container(
              child: Icon(Icons.history),
              padding: EdgeInsets.only(right: 15),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                color: Colors.blueGrey),
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      _topDisplayState,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                color: Colors.blueGrey),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: _temporyMainDisplayState.length > 13 ||
                            _mainDisplayState.length > 13
                        ? Text(
                            "Error",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.clip,
                          )
                        : Text(
                            _temporyMainDisplayState != "0"
                                ? _temporyMainDisplayState
                                : _mainDisplayState,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                color: Colors.blueGrey),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "MC",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "MR",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "M+",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "M-",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "MS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 95,
                  height: 70,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                  child: Center(
                    child: Text(
                      "%",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _mainDisplayState = "0";
                      _temporyMainDisplayState = "0";
                      _isMainStateChanged = true;
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "CE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _mainDisplayState = "0";
                      _temporyMainDisplayState = "0";
                      _topDisplayState = "";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "C",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_temporyMainDisplayState != "0") {
                      _mainDisplayState = _temporyMainDisplayState;
                    }
                    _operation = "";
                    _isMainStateChanged = true;
                    _temporyMainDisplayState = "0";
                    if (_mainDisplayState != "0")
                      _mainDisplayState = _mainDisplayState.substring(
                          0, _mainDisplayState.length - 1);
                    setState(() {});
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 95,
                  height: 70,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                  child: Center(
                    child: Text(
                      "1/x",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 95,
                  height: 70,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                  child: Center(
                    child: Text(
                      "x^2",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 95,
                  height: 70,
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                  child: Center(
                    child: Text(
                      "√x",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_operation != "" && !_isMainStateChanged) {
                      _topDisplayState = _topDisplayState.substring(
                              0, _topDisplayState.length - 3) +
                          " ÷ ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "÷";
                      _isMainStateChanged = false;
                    }
                    if (_operation == "") {
                      if (_mainDisplayState.contains("-"))
                        _topDisplayState += "(" + _mainDisplayState + ") ÷ ";
                      else
                        _topDisplayState += _mainDisplayState + " ÷ ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "÷";
                      _isMainStateChanged = false;
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "÷",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "7";
                      if (_mainDisplayState == "0") _mainDisplayState = "7";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "7",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "8";
                      if (_mainDisplayState == "0") _mainDisplayState = "8";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "8",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "9";
                      if (_mainDisplayState == "0") _mainDisplayState = "9";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "9",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_operation != "" && !_isMainStateChanged) {
                      _topDisplayState = _topDisplayState.substring(
                              0, _topDisplayState.length - 3) +
                          " × ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "×";
                    }
                    if (_operation == "") {
                      if (_mainDisplayState.contains("-"))
                        _topDisplayState += "(" + _mainDisplayState + ") × ";
                      else
                        _topDisplayState += _mainDisplayState + " × ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "×";
                      _isMainStateChanged = false;
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "×",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "4";
                      if (_mainDisplayState == "0") _mainDisplayState = "4";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "4",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "5";
                      if (_mainDisplayState == "0") _mainDisplayState = "5";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "5",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "6";
                      if (_mainDisplayState == "0") _mainDisplayState = "6";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "6",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_operation != "" && !_isMainStateChanged) {
                      _topDisplayState = _topDisplayState.substring(
                              0, _topDisplayState.length - 3) +
                          " - ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "-";
                    }
                    if (_operation == "") {
                      if (_mainDisplayState.contains("-"))
                        _topDisplayState += "(" + _mainDisplayState + ") - ";
                      else
                        _topDisplayState += _mainDisplayState + " - ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "-";
                      _isMainStateChanged = false;
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "-",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "1";
                      if (_mainDisplayState == "0") _mainDisplayState = "1";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "2";
                      if (_mainDisplayState == "0") _mainDisplayState = "2";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "3";
                      if (_mainDisplayState == "0") _mainDisplayState = "3";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                      _operation = "";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_operation != "" && !_isMainStateChanged) {
                      _topDisplayState = _topDisplayState.substring(
                              0, _topDisplayState.length - 3) +
                          " + ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "+";
                    }
                    if (_operation == "") {
                      if (_mainDisplayState.contains("-"))
                        _topDisplayState += "(" + _mainDisplayState + ") + ";
                      else
                        _topDisplayState += _mainDisplayState + " + ";
                      if (_mainDisplayState != "0") {
                        _temporyMainDisplayState = _mainDisplayState;
                      }
                      _mainDisplayState = "0";
                      _operation = "+";
                      _isMainStateChanged = false;
                    }
                    setState(() {});
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 38, 46, 100)),
                    child: Center(
                      child: Text(
                        "+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState != "0") {
                        if (_mainDisplayState.contains("-"))
                          _mainDisplayState = _mainDisplayState.substring(1);
                        else
                          _mainDisplayState = "-" + _mainDisplayState;
                      }
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "±",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (_mainDisplayState != "0") _mainDisplayState += "0";
                      _isMainStateChanged = true;
                      _temporyMainDisplayState = "0";
                    });
                    _operation = "";
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_mainDisplayState.length == 13) return;
                      if (!_mainDisplayState.contains("."))
                        _mainDisplayState += ".";
                    });
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(6, 13, 15, 100)),
                    child: Center(
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    calculate();
                  },
                  child: Container(
                    width: 95,
                    height: 70,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(21, 85, 131, 100)),
                    child: Center(
                      child: Text(
                        "=",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
