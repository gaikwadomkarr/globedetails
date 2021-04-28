import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:globedetails/Helpers/Helpers.dart';
import 'package:globedetails/models/CountryDetail.dart';

class DetailsBottomSheet extends StatefulWidget {
  final String selectedCountry, selectedRegion;
  final Color selectedCountryColor;

  DetailsBottomSheet(
      this.selectedCountry, this.selectedRegion, this.selectedCountryColor);

  @override
  _DetailsBottomSheetState createState() => _DetailsBottomSheetState();
}

class _DetailsBottomSheetState extends State<DetailsBottomSheet> {
  List<CountryDetail> countryDetail;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCountryDetail();
  }

  void getCountryDetail() async {
    try {
      final response = await getDio().get(
          "https://restcountries.eu/rest/v2/name/${widget.selectedCountry}?fullText=true");

      print(response.statusCode.toString());
      if (response.statusCode == 200) {
        countryDetail = countryDetailFromJson(json.encode(response.data));
        print(countryDetail.first.name);
        setState(() {});
      }
    } on DioError catch (e) {
      print(e.response.data.toString());
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: new Text('Hello this is snackbar!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 5,
              width: 45,
              decoration: BoxDecoration(
                  color: widget.selectedCountryColor,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.selectedRegion + " / " + widget.selectedCountry,
              style: boldBlackStyle().copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            countryDetail != null
                ? Expanded(child: builddetail())
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  Widget builddetail() {
    return ListView(
      // mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: widget.selectedCountryColor,
          // height: 125,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            minLeadingWidth: 70,
            leading: Container(
              width: 80,
              height: 100,
              child: SvgPicture.network(
                countryDetail.first.flag,
                fit: BoxFit.fill,
              ),
            ),
            title: Text(
              countryDetail.first.name + " (${countryDetail.first.alpha3Code})",
              textAlign: TextAlign.start,
              textDirection: TextDirection.ltr,
              maxLines: 2,
              style: boldBigFontStyle(),
            ),
            subtitle: Text(countryDetail.first.capital),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: widget.selectedCountryColor,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Currencies ",
                style: boldBlackStyle()
                    .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  (countryDetail.first.currencies.first.symbol ?? "") +
                      " " +
                      (countryDetail.first.currencies.first.name ?? ""),
                  style: boldBigFontStyle().copyWith(fontSize: 20),
                  maxLines: 2,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: widget.selectedCountryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Calling Code ",
                style: boldBlackStyle()
                    .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              Text(
                "${countryDetail.first.callingCodes.join(",").toString()}",
                style: boldBigFontStyle().copyWith(fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: widget.selectedCountryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Population ",
                style: boldBlackStyle()
                    .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              Text(
                countryDetail.first.population.toString(),
                style: boldBigFontStyle().copyWith(fontSize: 20),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          color: widget.selectedCountryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dynonym ",
                style: boldBlackStyle()
                    .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
              ),
              Text(
                countryDetail.first.demonym,
                style: boldBigFontStyle().copyWith(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }
}
