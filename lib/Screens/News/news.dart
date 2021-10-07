
import 'package:app/Screens/News/detalis.dart';
import 'package:app/Screens/News/listwidget.dart';
import 'package:app/Screens/News/shared/listitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class News extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<News>
    with SingleTickerProviderStateMixin {
      
  List<ListItem> listTiles = [
    ListItem("https://i.ibb.co/98JRbBB/2657925156-e3180ba45a-o.jpg",
        "WHY SOURCE RUBBER FROM SRI LANKA?", "Mr B", "31 Jan 2021",
        "Once, Sri Lanka was the cradles for the rubber industry, that revolutionised many industries across the globe, when a few hundred Brazillian rubber seeds received from the Kew Garden in London were planted in the Henarathgoda Botanical Garden in Gampaha in 1867. By 1900 a large extent of land in wet zone Sri Lanka was under rubber cultivation and by 1970s Sri Lanka had over 200,000 hectares of rubber plantations.\nToday the country is the 13th largest rubber producer in the world. There are about 136,625 hectares of rubber plantations in Sri Lanka and the industry employs a total of 200,000 individuals with more women employed at a grassroots level. Sri Lankan rubber and rubber-based product sector enjoys key competitive advantages including; \n AVAILABILITY OF PREMIUM QUALITY NATURAL RUBBER LATEX \n\n Currently, Sri Lanka is the main manufacturer of the best quality latex crepe rubber in the world and also the largest exporter latex crepe to the global market. Latex Crepe made in Sri Lanka is the highest quality natural rubber and considered the creme de la creme of rubber, fetching a premium price over all other types and grades. \n \n The country’s premium quality natural rubber type known as Lankaprene is odour free to the most extent, light-coloured, and clean is largely used for medical equipment and upmarket value-added products."),
    ListItem(
        "https://i.ibb.co/3pQTX6G/STr-Gdj-Qi-Xj-Pbd-CAax-QEGy-M-970-80-jpg.webp",
        "INDUSTRY CAPABILITY OF SRI LANKAN RUBBER & RUBBER PRODUCTS SECTOR",
        "Mr C",
        "30 Jan 2021","Once, Sri Lanka was the cradles for the rubber industry, that revolutionised many industries across the globe, when a few hundred Brazillian rubber seeds received from the Kew Garden in London were planted in the Henarathgoda Botanical Garden in Gampaha in 1867. By 1900 a large extent of land in wet zone Sri Lanka was under rubber cultivation and by 1970s Sri Lanka had over 200,000 hectares of rubber plantations."),
    ListItem(
        "https://www.linkpicture.com/q/Technology-helps-by-MEED-Editorial.jpeg",
        "RUBBER & RUBBER BASED PRODUCTS EXPORT PERFORMANCE",
        "Mr C",
        "30 Jan 2021","Once, Sri Lanka was the cradles for the rubber industry, that revolutionised many industries across the globe, when a few hundred Brazillian rubber seeds received from the Kew Garden in London were planted in the Henarathgoda Botanical Garden in Gampaha in 1867. By 1900 a large extent of land in wet zone Sri Lanka was under rubber cultivation and by 1970s Sri Lanka had over 200,000 hectares of rubber plantations."),
    ListItem("https://www.linkpicture.com/q/images_167.jpg",
        "MAJOR RUBBER & RUBBER PRODUCTS", "Mr D", "29 Jan 2021","Once, Sri Lanka was the cradles for the rubber industry, that revolutionised many industries across the globe, when a few hundred Brazillian rubber seeds received from the Kew Garden in London were planted in the Henarathgoda Botanical Garden in Gampaha in 1867. By 1900 a large extent of land in wet zone Sri Lanka was under rubber cultivation and by 1970s Sri Lanka had over 200,000 hectares of rubber plantations."),
    ListItem(
        "https://i.ibb.co/8m6qSRg/rubber-tree-rubber-trees-rubber-tree.jpg",
        "MORE COMPANY HIGHLIGHTS",
        "Mr E",
        "28 Jan 2021","Once, Sri Lanka was the cradles for the rubber industry, that revolutionised many industries across the globe, when a few hundred Brazillian rubber seeds received from the Kew Garden in London were planted in the Henarathgoda Botanical Garden in Gampaha in 1867. By 1900 a large extent of land in wet zone Sri Lanka was under rubber cultivation and by 1970s Sri Lanka had over 200,000 hectares of rubber plantations."),
  ];
  List<Tab> _tabList = [
    Tab(
      child: Text(""),
    ),
    // Tab(
    //   child: Text("Popular"),
    // ),
    // Tab(
    //   child: Text("Trending"),
    // ),
    // Tab(
    //   child: Text("Editor Choice"),
    // ),
    // Tab(
    //   child: Text("Category"),
    // ),
  ];
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabList.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        toolbarHeight: 110.0,
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: Icon(
        //     Icons.menu,
        //     color: Colors.black,
        //   ),
        // ),
        backgroundColor: Color(0xFF000000),
        centerTitle: true,
        title: Text(
          "Latest News",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(30.0),
          child: TabBar(
            indicatorColor: Colors.black,
            isScrollable: true,
            labelColor: Colors.white,
            controller: _tabController,
            tabs: _tabList,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: ListView.builder(
                itemCount: listTiles.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=>DetailsScreen(tag: listTiles[index].newsTitle, item: listTiles[index])));
                    },
                    child: listWidget(listTiles[index]),
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(8.0),
          //   child: Container(),
          // ),
        ],
      ),
    );
  }
}
