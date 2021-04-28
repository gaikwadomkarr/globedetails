import 'dart:math';

import 'package:flutter/material.dart';
import 'package:globedetails/Helpers/Helpers.dart';
import 'package:globedetails/screens/countries_screen.dart';

class RegionScreen extends StatefulWidget {
  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  List<String> regions = ["Africa", "Americas", "Asia", "Europe", "Oceania"];
  List<Color> regionColors;

  @override
  void initState() {
    super.initState();
    regionColors = [];
    regions.forEach((element) {
      regionColors.add(Color.fromRGBO(Random().nextInt(256),
          Random().nextInt(256), Random().nextInt(125), 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Regions"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10),
          child: ListView(
            children: List.generate(regions.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: regionColors[index],
                ),
                child: ListTile(
                  enabled: true,
                  enableFeedback: true,
                  title: Text(
                    regions[index],
                    style: boldBlackStyle(),
                  ),
                  trailing: Icon(Icons.forward),
                  onTap: () {
                    print(
                        "Tapped on region ${regions[index]} and its color is ${regionColors[index]}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CountriesScreen(
                                  selectedRegion: regions[index],
                                  selectedRegionColor: regionColors[index],
                                )));
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
