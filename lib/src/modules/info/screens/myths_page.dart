import 'package:corona_app/src/core/theme/custom_app_theme.dart';
import 'package:flutter/material.dart';

class MythsPage extends StatefulWidget {
  static final routeName = "./myths";

  @override
  _MythsPageState createState() => _MythsPageState();
}

class _MythsPageState extends State<MythsPage> {
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Myths"),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
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
      padding: EdgeInsets.only(top: 5, bottom: 5),
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
                  child: Image.asset(_FAQListItems[index]["image"]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: _FAQListItems[index]["desc1"],
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                      children: <TextSpan>[
                        TextSpan(
                            text: _FAQListItems[index]["richText"],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: CustomAppTheme.themeRedColor)),
                        TextSpan(
                            text: _FAQListItems[index]["desc2"],
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  final _FAQListItems = [
    {
      "title": "Hot baths",
      "desc1": "Taking hot baths will NOT",
      "richText": "NOT",
      "desc2":
          " prevent a person from catching coronavirus. Regardless of the temperature of water, the temperature of the body is the deciding factorl",
      "image": "assets/images/hot_bath.png",
    },
    {
      "title": "Made in China",
      "desc1": "The new Coronavirus ",
      "richText": "CANNOT",
      "desc2":
          " be transfered by goods manufactured in China or any other country. Even though the virus can stay on the surface of an object from a few hours to days, it is very unlikely that it will persist when the item is being moved and exposed to different conditions, temperatures.",
      "image": "assets/images/china_stiker.png",
    },
    {
      "title": "Mosquitoes",
      "desc1": "The new coronavirus ",
      "richText": "CANNOT",
      "desc2":
          " be transmitted through mosquito bites. Till date there has been no evidence which suggests the same",
      "image": "assets/images/mosquito.png",
    },
    {
      "title": "Hand Dryer",
      "desc1": "Hand dryers are ",
      "richText": "NOT",
      "desc2":
          " effective in killing 2019-nCov. You should frequently wash your hands with alcohol based hand rub or soap.",
      "image": "assets/images/hand_dryer.png",
    },
  ];
}