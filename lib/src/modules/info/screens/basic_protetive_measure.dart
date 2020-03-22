import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:corona_app/src/core/widgets/disclaimer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasicProtectiveMeasure extends StatefulWidget {
  static final routeName = "./protective-measures";

  @override
  _BasicProtectiveMeasureState createState() => _BasicProtectiveMeasureState();
}

class _BasicProtectiveMeasureState extends State<BasicProtectiveMeasure> {
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Basic Protective Measures"),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, DisclaimerPage.routeName);
            },
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height - 60,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: _FAQListItems.length,
          itemBuilder: (context, index) {
            return _buildListItem(context, index);
          },
        ),
      ),
    );
  }


  Widget _buildListItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xff2D4361),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ExpansionTile(
        onExpansionChanged: (v) {
          print("index $selectedIndex");
          selectedIndex.contains(index)
              ? selectedIndex.remove(index)
              : selectedIndex.add(index);
          setState(() {});
        },
        initiallyExpanded: selectedIndex.contains(index),
        backgroundColor: Colors.transparent,
        title: Text(
          _FAQListItems[index]["title"],
          style: TextStyle(
              fontFamily: CustomAppTheme.fontName,
              color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        trailing: Icon(
          selectedIndex.contains(index)
              ? Icons.keyboard_arrow_up
              : Icons.keyboard_arrow_down,
          color: Colors.white70,
          size: 28,
        ),
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Colors.transparent,
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(_FAQListItems[index]["image"]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _FAQListItems[index]["desc"],
                    style: TextStyle(
                        fontFamily: CustomAppTheme.fontName,
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  final _FAQListItems =  [
    {
      "title": "Wash your hands",
      "desc":
          "frequently wash your hands when they are dirty, before and after eatting.Clean with alcohol based hand-rub or soap when dry.",
      "image": "assets/images/washing_hands.svg",
    },
    {
      "title": "Avoid Close Contact",
      "desc": "Avoid close contact with people who are sick or have a fever.",
      "image": "assets/images/waving.svg",
    },
    {
      "title": "Properly Cook Food",
      "desc":
          "Even in areas experiencing outbreaks, meat can be safely consumed if these items are thoroughly cooked and properly handled.",
      "image": "assets/images/non_veg.svg",
    },
    {
      "title": "Cover while sneezing",
      "desc": "Cover mouth and nose with flexed elbow while sneezing.",
      "image": "assets/images/sneezing.svg",
    },
    {
      "title": "Segregate Kitchen Items",
      "desc":
          "Use different chopping knife and board for raw meat and cooked food",
      "image": "assets/images/cutting_knife.svg",
    },
  ];
}
