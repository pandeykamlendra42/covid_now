import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  static final routeName = "./faqs";

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<int> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.info_outline, color: Colors.white,),
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

  Widget _buildListItem1(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xff2D4361),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: ExpandIcon(
        onPressed: (v) {},
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
          _FAQListItems[index]["q"],
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
              color: const Color(0xa12D4361),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              _FAQListItems[index]["a"],
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.w300),
            ),
          )
        ],
      ),
    );
  }

  final _FAQListItems = const [
    {
      "q": "Is there anything I should not do?",
      "a": "The following measures ARE NOT effective against COVID-2019 and can be harmful: \n\n" +
          "\n-> Smoking" +
          "\n-> Wearing multiple masks" +
          "\n-> Taking self-medication such as antibiotics" +
          "\n-> In any case, if you have fever, cough and difficulty breathing seek medical care early to reduce the risk of developing a more severe infection and be sure to share your recent travel history with your health care provider."
    },
    {
      "q":
          "Is it safe to receive a package from any area where COVID-19 has been reported?",
      "a": ""
          "Yes. The likelihood of an infected person contaminating commercial goods is low and the risk of catching the virus that causes COVID-19 from a package that has been moved, travelled, and exposed to different conditions and temperature is also low. "
    },
    {
      "q": "How long does the virus survive on surfaces?",
      "a": "It is not certain how long the virus that causes COVID-19 survives on surfaces, but it seems to behave like other coronaviruses. Studies suggest that coronaviruses (including preliminary information on the COVID-19 virus) may persist on surfaces for a few hours or up to several days. This may vary under different conditions (e.g. type of surface, temperature or humidity of the environment). \n" +
          "If you think a surface may be infected, clean it with simple disinfectant to kill the virus and protect yourself and others. Clean your hands with an alcohol-based hand rub or wash them with soap and water. Avoid touching your eyes, mouth, or nose."
    },
    {
      "q": "Can I catch COVID-19 from my pet?",
      "a":
          "No. There is no evidence that companion animals or pets such as cats and dogs have been infected or could spread the virus that causes COVID-19."
    },
    {
      "q":
          "Can humans become infected with the COVID-19 from an animal source?",
      "a": "Coronaviruses are a large family of viruses that are common in animals. Occasionally, people get infected with these viruses which may then spread to other people. For example, SARS-CoV was associated with civet cats and MERS-CoV is transmitted by dromedary camels. Possible animal sources of COVID-19 have not yet been confirmed. \n" +
          "To protect yourself, such as when visiting live animal markets, avoid direct contact with animals and surfaces in contact with animals. Ensure good food safety practices at all times. Handle raw meat, milk or animal organs with care to avoid contamination of uncooked foods and avoid consuming raw or undercooked animal products."
    },
    {
      "q": "How long is the incubation period for COVID-19?",
      "a":
          "The “incubation period” means the time between catching the virus and beginning to have symptoms of the disease. Most estimates of the incubation period for COVID-19 range from 1-14 days, most commonly around five days. These estimates will be updated as more data become available."
    },
    {
      "q": "How to put on, use, take off and dispose of a mask?",
      "a": "-> Remember, a mask should only be used by health workers, care takers, and individuals with respiratory symptoms, such as fever and cough. \n" +
          "-> Before touching the mask, clean hands with an alcohol-based hand rub or soap and water \n" +
          "-> Take the mask and inspect it for tears or holes.\n" +
          "-> Orient which side is the top side (where the metal strip is).\n" +
          "-> Ensure the proper side of the mask faces outwards (the coloured side).\n" +
          "-> Place the mask to your face. Pinch the metal strip or stiff edge of the mask so it moulds to the shape of your nose.\n" +
          "-> Pull down the mask’s bottom so it covers your mouth and your chin.\n" +
          "-> After use, take off the mask; remove the elastic loops from behind the ears while keeping the mask away from your face and clothes, to avoid touching potentially contaminated surfaces of the mask.\n" +
          "-> Discard the mask in a closed bin immediately after use.\n" +
          "-> Perform hand hygiene after touching or discarding the mask – Use alcohol-based hand rub or, if visibly soiled, wash your hands with soap and water."
    },
    {
      "q": "Should I wear a mask to protect myself?",
      "a": "Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19. Disposable face mask can only be used once. If you are not ill or looking after someone who is ill then you are wasting a mask. There is a world-wide shortage of masks, so WHO urges people to use masks wisely. \n \n" +
          "WHO advises rational use of medical masks to avoid unnecessary wastage of precious resources and mis-use of masks (see Advice on the use of masks). \n \n" +
          "The most effective ways to protect yourself and others against COVID-19 are to frequently clean your hands, cover your cough with the bend of elbow or tissue and maintain a distance of at least 1 meter (3 feet) from people who are coughing or sneezing. See basic protective measures against the new coronavirus for more information."
    },
    {
      "q": "Is COVID-19 the same as SARS?",
      "a":
          "No. The virus that causes COVID-19 and the one that causes Severe Acute Respiratory Syndrome (SARS) are related to each other genetically, but they are different. SARS is more deadly but much less infectious than COVID-19. There have been no outbreaks of SARS anywhere in the world since 2003."
    },
    {
      "q": "Is there a vaccine, drug or treatment for COVID-19?",
      "a": "Not yet. To date, there is no vaccine and no specific antiviral medicine to prevent or treat COVID-2019. However, those affected should receive care to relieve symptoms. People with serious illness should be hospitalized. Most patients recover thanks to supportive care. \n\n" +
          "Possible vaccines and some specific drug treatments are under investigation. They are being tested through clinical trials. WHO is coordinating efforts to develop vaccines and medicines to prevent and treat COVID-19. \n \n" +
          "The most effective ways to protect yourself and others against COVID-19 are to frequently clean your hands, cover your cough with the bend of elbow or tissue, and maintain a distance of at least 1 meter (3 feet) from people who are coughing or sneezing. (See Basic protective measures against the new coronavirus)."
    },
    {
      "q": "Are antibiotics effective in preventing or treating the COVID-19?",
      "a":
          "No. Antibiotics do not work against viruses, they only work on bacterial infections. COVID-19 is caused by a virus, so antibiotics do not work. Antibiotics should not be used as a means of prevention or treatment of COVID-19. They should only be used as directed by a physician to treat a bacterial infection"
    },
    {
      "q": "Who is at risk of developing severe illness?",
      "a":
          "While we are still learning about how COVID-2019 affects people, older persons and persons with pre-existing medical conditions (such as high blood pressure, heart disease, lung disease, cancer or diabetes) appear to develop serious illness more often than others."
    },
    {
      "q": "Should I worry about COVID-19?",
      "a": "Illness due to COVID-19 infection is generally mild, especially for children and young adults. However, it can cause serious illness: about 1 in every 5 people who catch it need hospital care. It is therefore quite normal for people to worry about how the COVID-19 outbreak will affect them and their loved ones.\n\n" +
          "We can channel our concerns into actions to protect ourselves, our loved ones and our communities. First and foremost among these actions is regular and thorough hand-washing and good respiratory hygiene. Secondly, keep informed and follow the advice of the local health authorities including any restrictions put in place on travel, movement and gatherings. Learn more about how to protect yourself at \n\nhttps://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public"
    },
    {
      "q": "How likely am I to catch COVID-19?",
      "a": "The risk depends on where you  are - and more specifically, whether there is a COVID-19 outbreak unfolding there.\n" +
          "For most people in most locations the risk of catching COVID-19 is still low. However, there are now places around the world (cities or areas) where the disease is spreading. For people living in, or visiting, these areas the risk of catching COVID-19 is higher. Governments and health authorities are taking vigorous action every time a new case of COVID-19 is identified. Be sure to comply with any local restrictions on travel, movement or large gatherings. Cooperating with disease control efforts will reduce your risk of catching or spreading COVID-19.\n" +
          "COVID-19 outbreaks can be contained and transmission stopped, as has been shown in China and some other countries. Unfortunately, new outbreaks can emerge rapidly. It’s important to be aware of the situation where you are or intend to go. WHO publishes daily updates on the COVID-19 situation worldwide. You can see these at \nhttps://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports/",
    },
    {
      "q": "What are the symptoms of COVID-19?",
      "a":
          "The most common symptoms of COVID-19 are fever, tiredness, and dry cough. Some patients may have aches and pains, nasal congestion, runny nose, sore throat or diarrhea. These symptoms are usually mild and begin gradually. Some people become infected but don’t develop any symptoms and don't feel unwell. Most people (about 80%) recover from the disease without needing special treatment. Around 1 out of every 6 people who gets COVID-19 becomes seriously ill and develops difficulty breathing. Older people, and those with underlying medical problems like high blood pressure, heart problems or diabetes, are more likely to develop serious illness. People with fever, cough and difficulty breathing should seek medical attention.",
    },
    {
      "q": "What is COVID-19?",
      "a":
          "COVID-19 is the infectious disease caused by the most recently discovered coronavirus. This new virus and disease were unknown before the outbreak began in Wuhan, China, in December 2019.",
    },
    {
      "q": "What is a coronavirus?",
      "a":
          "Coronaviruses are a large family of viruses which may cause illness in animals or humans.  In humans, several coronaviruses are known to cause respiratory infections ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS). The most recently discovered coronavirus causes coronavirus disease COVID-19.",
    },
  ];
}
