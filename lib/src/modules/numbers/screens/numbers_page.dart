import 'dart:async';

import 'package:corona_app/src/core/storage/preferences/preference_manager.dart';
import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/pie_chart_donut.dart';
import 'package:corona_app/src/modules/numbers/models/covid_daily_model.dart';
import 'package:corona_app/src/modules/numbers/models/covid_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumbersPage extends StatefulWidget {
  static final routeName = "./numbers";
  String selectedCountry = "world";

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage>
    with AutomaticKeepAliveClientMixin {
  List<CovidDailyModel> listItems = [];
  int prevTotalConf = 0, prevTotalRec = 0, prevConf = 0, prevRecovered = 0;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: CustomAppTheme.primaryColor,
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
            height: MediaQuery.of(context).size.height,
            color: CustomAppTheme.primaryColor,
            child: _buildInfoWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoWidget() {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    final numberFormat = new NumberFormat("#,###,###", "en_US");
    return FutureBuilder<CovidResponse>(
      future: PreferenceManager().getCovidResponse(),
      builder: (_, AsyncSnapshot<CovidResponse> snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else {
          listItems = snapshot.data.dailyCovidResponse.data;
          //Timer(Duration(milliseconds: 200), () => _scrollController.jumpTo(_scrollController.position.maxScrollExtent));
          return ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5, bottom: 25),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overview",
                  style: TextStyle(
                      fontFamily: CustomAppTheme.fontName,
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Card(
                elevation: 1,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Container(
                            alignment: Alignment.center,
                            height: 230,
                            width: 230,
                            child: DonutPieChart.withSampleData(
                                snapshot.data.worldListResponse),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 30, top: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: "Confirmed\n",
                                    style: TextStyle(
                                        fontFamily: CustomAppTheme.fontName,
                                        color: CustomAppTheme.accentColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${numberFormat.format(snapshot.data.worldListResponse.confirmed)}",
                                        style: TextStyle(
                                            fontFamily: CustomAppTheme.fontName,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 26),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Recovered\n",
                                      style: TextStyle(
                                          fontFamily: CustomAppTheme.fontName,
                                          color: CustomAppTheme.themeGreenColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                      children: [
                                        TextSpan(
                                          text:
                                              "${numberFormat.format(snapshot.data.worldListResponse.recovered)}",
                                          style: TextStyle(
                                              fontFamily: CustomAppTheme.fontName,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 26),
                                        )
                                      ]),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: "Deaths\n",
                                    style: TextStyle(
                                        fontFamily: CustomAppTheme.fontName,
                                        color: Color(0xFFC82424),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    children: [
                                      TextSpan(
                                        text:
                                            "${numberFormat.format(snapshot.data.worldListResponse.deaths)}",
                                        style: TextStyle(
                                            fontFamily: CustomAppTheme.fontName,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 26),
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 35, bottom: 10),
                child: Text(
                  "Daily Updates",
                  style: TextStyle(
                      color: CustomAppTheme.accentColor,
                      fontFamily: CustomAppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              Container(
                height: _height * 0.6,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 150),
                child: ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: listItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return _buildListItem(
                          listItems[listItems.length - (index + 1)],
                          listItems[(index + 2 < listItems.length
                              ? listItems.length - (index + 2)
                              : listItems.length - (index + 1))],
                          numberFormat, index);
                    }),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildListItem(CovidDailyModel model, CovidDailyModel nextModel,
      NumberFormat numberformat, int index) {
    var dateTime = DateFormat("yyyy/MM/dd").parse(model.date);
    int confirmed = model.confirmed, recovered = model.recovered;
    bool isUpIconConf = false, isUpIconRec = false;

    if (index != listItems.length - 1 && model != nextModel) {
      confirmed = model.confirmed - nextModel.confirmed;
      isUpIconConf = prevConf < confirmed;
      prevConf = confirmed;
      recovered = model.recovered - nextModel.recovered;
      isUpIconRec = prevRecovered < recovered;
      prevRecovered = recovered;
    }

    prevTotalConf = model.confirmed;
    prevTotalRec = model.recovered;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          colors: const [
            Color(0xff2D4361),
            Color(0xff2D4361),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "${DateFormat("d MMM yyyy").format(dateTime)}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: CustomAppTheme.fontName,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Total ${numberformat.format(model.chinaConf)} cases in China and ${numberformat.format(model.otherLocationConf)} at other locations",
                    style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        fontFamily: CustomAppTheme.fontName),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 3),
                        child: Icon(
                          isUpIconConf
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: CustomAppTheme.accentColor,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Confirmed : ${numberformat.format(confirmed)}",
                              style: TextStyle(
                                  color: CustomAppTheme.themeYellowColor,
                                  fontFamily: CustomAppTheme.fontName,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          isUpIconRec
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: CustomAppTheme.accentColor,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 3, right: 10),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Recovered : ${numberformat.format(recovered)}",
                              style: TextStyle(
                                  color: CustomAppTheme.themeGreenColor,
                                  fontFamily: CustomAppTheme.fontName,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
