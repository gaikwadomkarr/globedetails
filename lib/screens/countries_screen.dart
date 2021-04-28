import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globedetails/Helpers/Helpers.dart';
import 'package:globedetails/models/Countries.dart';
import 'package:globedetails/widgets/details_bottomsheet.dart';

class CountriesScreen extends StatefulWidget {
  final String selectedRegion;
  final Color selectedRegionColor;

  CountriesScreen({this.selectedRegion, this.selectedRegionColor});
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Color newColor;
  List<Countries> countriesScreen;
  Future<List<Countries>> refresh;
  List<bool> _selected;

  @override
  void initState() {
    super.initState();

    PaintingBinding.instance.imageCache.clear();
    newColor = widget.selectedRegionColor.withOpacity(0.3);
    getCountries();
  }

  void getCountries() async {
    try {
      countriesScreen = [];
      final response = await getDio().get(
          "https://restcountries.eu/rest/v2/region/${widget.selectedRegion}");

      print("this is get cuntries response code " +
          response.statusCode.toString());
      if (response.statusCode == 200) {
        print("this is response json " + response.data.toString());
        final data = response.data;

        for (Map i in data) {
          countriesScreen.add(Countries.fromJson(i));
        }
        print("this is data from countries => " + countriesScreen.toString());
        _selected = [];
        _selected = List.generate(countriesScreen.length, (i) => false);
        setState(() {});
        refresh = refreshCallback();
      }
    } on DioError catch (e) {
      print(e.response.data.toString());
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: new Text('Hello this is snackbar!')));
    }
  }

  Future<List<Countries>> refreshCallback() async {
    return countriesScreen;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(widget.selectedRegion),
          backgroundColor: widget.selectedRegionColor,
          centerTitle: true,
        ),
        body: Container(
          child: buildCountries(),
        ),
      )),
    );
  }

  Widget buildCountries() {
    return FutureBuilder<List<Countries>>(
      future: refresh,
      builder: (BuildContext context, AsyncSnapshot<List<Countries>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Container(child: Text('Loading data...')),
          );
        } else if (countriesScreen.length > 0) {
          return ListView(
            children: List.generate(countriesScreen.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: _selected[index]
                      ? newColor.withOpacity(0.8).withAlpha(150)
                      : newColor,
                ),
                child: ListTile(
                  enabled: true,
                  enableFeedback: true,
                  title: Text(
                    countriesScreen[index].name,
                    style: boldBlackStyle(),
                  ),
                  trailing: SizedBox(
                    width: 60,
                    height: 40,
                    child: SvgPicture.network(
                      countriesScreen[index].flag,
                      fit: BoxFit.fill,
                      placeholderBuilder: (BuildContext context) => Container(
                          padding: const EdgeInsets.all(30.0),
                          child: const CircularProgressIndicator()),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < _selected.length; i++) {
                        _selected[i] = false;
                      }
                      _selected[index] = true;
                    });
                    print(_selected.toString());
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => DetailsBottomSheet(
                            countriesScreen[index].name,
                            widget.selectedRegion,
                            newColor));
                  },
                ),
              );
            }),
          );
        } else {
          return Center(
            child: Text("No data available"),
          );
        }
      },
    );
  }

  void toggleSelection(int index) {}
}
