import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models/TestData.dart';
import 'package:pet_adoption_app/ui/DetailsScreen.dart';
import '../providers/AuthProvider.dart';
import 'package:provider/provider.dart';


class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  dynamic height, width;
  bool isvisible = false;
  List<Testdata> listData = [];
  List<Testdata> filteredItems = [];

  int pageSize = 10;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;


  @override
  void initState() {
    AuthProvider authProvider = Provider.of(context, listen: false);
    authProvider.homeListData(10);
    getHomeData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !isLoading) {
        if(pageSize<100) {
          pageSize=pageSize+10;
          print("Paging Size: ${pageSize}");
          authProvider.homeListData(pageSize);
          getHomeData();
        }
      }
    });
    super.initState();
  }
  getHomeData(){
    setState(() {
      isLoading=true;
    });
    AuthProvider authProvider = Provider.of(context, listen: false);
    if (authProvider.listDataHome.isNotEmpty) {
      setState(() {
        listData = authProvider.listDataHome;
        filteredItems = authProvider.listDataHome;
        isLoading=false;
      });
    } else {
      setState(() {
        listData = [];
        filteredItems = [];
        isLoading=false;
      });
    }
    print("List :: ${listData.length}");
  }
  void filterItems(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredItems = listData
          .where((item) => item.title.toString().toLowerCase().contains(query)).toList();
    });
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
        title: Text("Home Page",),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
            TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.text,
            controller: authProvider.searchTEC,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Colors.teal.shade50,
              filled: true,
              contentPadding:EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)),
              hintText: 'Search....',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              prefixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    authProvider.searchTEC.text = '';
                  });
                },
              ),
            ),
            onChanged: (value) {
              setState(() {
                filterItems(value);
              });
            },
          ),
             SizedBox(
               height: 10,
             ),
              filteredItems.isNotEmpty ? ListView.builder(
      itemCount: filteredItems.length+(isLoading ? 1 : 0),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
                itemBuilder: (context,index){
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DetailsScreen(petsData:filteredItems[index])),).then((value) {
                      onBack();
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 8),
                      padding:const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: filteredItems[index].isAdopted==true ? Colors.green.shade100 : Colors.teal.shade50,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    child: Row(
                      children: [
                        Container(
                            height: height * 0.12,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffdde2e2).withOpacity(0.4),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "${filteredItems[index].image}",
                                  fit: BoxFit.cover),
                            )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${filteredItems[index].title}" ,
                              style: TextStyle(fontSize: 16,color: Colors.black),
                            ),
                            Text("Create Date: 28/01/2024",
                              style: TextStyle(fontSize: 16,color: Colors.black),
                            ),
                            Text(filteredItems[index].isAdopted==false ? "Status: Not Adopted" : "Status: Adopted",
                              style: TextStyle(fontSize: 16,color: Colors.black),
                            )
                          ],
                        ),
                      ),
                       Spacer(),
                       Icon(Icons.navigate_next)



                                ])),
                );
                },)
              :Center(
                  child: Column(
                    children: [
                      SizedBox(height: height * .5),
                      Text(
                        "No Data Found.",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  onBack() {
    getHomeData();
  }
}
