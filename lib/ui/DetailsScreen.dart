import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/TestData.dart';
import 'package:provider/provider.dart';
import '../providers/AuthProvider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pet_adoption_app/utils/MyFun.dart';

class DetailsScreen extends StatefulWidget {
  Testdata petsData;

  DetailsScreen({super.key, required this.petsData});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var _selectIndex = 0;
  dynamic height, width;
  List<String> petsImgList = [];

  @override
  void initState() {
    print("Pets Name: ${widget.petsData.title}");
    for (int i = 1; i <= 5; i++) {
      petsImgList.add("${widget.petsData.image}");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: false);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Details Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
         child: Column(
           children: [
             petsImgList.isNotEmpty
                 ? CarouselSlider(
               items: petsImgList.map((i) {
                 return Builder(
                   builder: (BuildContext context) {
                     return Hero(
                       tag: 'petImage-${widget.petsData.id}',
                       child: Container(
                         width: width * 0.9,
                         decoration: BoxDecoration(
                             borderRadius:
                             BorderRadius.circular(13),
                             image: DecorationImage(
                               image: NetworkImage(
                                   "${i}"),
                               fit: BoxFit.fill,
                             )),
                       ),
                     );
                   },
                 );
               }).toList(),
               options: CarouselOptions(
                 onPageChanged: (index, reason) {
                   setState(() {
                     _selectIndex = index;
                   });
                 },
                 height: 250,
                 enlargeCenterPage: true,
                 autoPlay: true,
                 aspectRatio: 2,
                 viewportFraction: 1,
                 autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                 enableInfiniteScroll: true,
                 autoPlayAnimationDuration:
                 const Duration(milliseconds: 500),
                 // viewportFraction: 0.8,
               ),
             ) : Container(),
             SizedBox(
               height: 20,
             ),
             Text("${widget.petsData.title}" ,
               style: TextStyle(fontSize: 18),
             ),
             Text("Create Date: 28/01/2024" ,
               style: TextStyle(fontSize: 14,color: Colors.grey),
             ),

             Text("The Historical Bond Between Humans and Pets:- The history of pets dates back thousands of years. Early humans domesticated animals like dogs for hunting and protection, while cats were valued for controlling pests in agricultural societies. Over time, these practical purposes expanded to include emotional and social roles. Today, pets are not just helpers or companions; they are often considered integral parts of families. This deep connection highlights the enduring importance of pets in human lives."+
               "\n\nThe Benefits of Having Pets:- Owning a pet offers numerous benefits that span physical, emotional, and social well-being. Studies have shown that pet owners experience lower blood pressure, reduced stress levels, and improved heart health. The simple act of petting a dog or cat can release endorphins, promoting relaxation and happiness." ,
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 14,color: Colors.grey.shade700),
             ),
               SizedBox(
                 height: 100,
               ),
             ElevatedButton(
               onPressed: () async {
                 setState(() {
                   widget.petsData.isAdopted = true;
                    authProvider.updatePetAdoptionStatus(widget.petsData);
                 });
               MyFun().CustToastMassage("You’ve now adopted ${widget.petsData.title}");
               },
               style: ElevatedButton.styleFrom(
                   minimumSize: Size(double.infinity, 45),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(12),
                   ),
                   backgroundColor: widget.petsData.isAdopted==true ? Colors.grey.shade300 : Colors.teal.shade50,
                   shadowColor:widget.petsData.isAdopted==true ? Colors.grey.shade300 : Colors.teal.shade50),
               child: Text(
                 widget.petsData.isAdopted==true ? 'Adopted' : 'Adopt Me',
                 style: TextStyle(
                     fontSize: 16, color: Colors.black,),
                 ),
               ),
           ],
         ),
        ),
      ),
    );
  }
}
