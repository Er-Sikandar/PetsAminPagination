import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/ui/HomeScreen.dart';

import '../models/TestData.dart';

class AuthProvider with ChangeNotifier{
  TextEditingController searchTEC = TextEditingController();
  List<Testdata> listDataHome = [];


  autologin(BuildContext context) async {
    if (1==2) {
      return Timer(Duration(seconds: 3),() =>
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homescreen()),
                  (Route<dynamic> route) => false));
    } else {
      return Timer(Duration(seconds: 3),() =>
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Homescreen()),
                  (Route<dynamic> route) => false));
    }
  }

   homeListData(len){
    String imageUrl = "https://i.imgur.com/OB0y6MR.jpg";
    if(len==10) {
      for (int i = 1; i <= len; i++) {
        listDataHome.add(Testdata(id: i.toString(), title: "Pets ${i}", image: imageUrl, isAdopted: false));
      }
    }else{
      for (int i = len-9; i <= len; i++) {
        listDataHome.add(Testdata(id: i.toString(), title: "Pets ${i}", image: imageUrl, isAdopted: false));
      }
    }
}

  void updatePetAdoptionStatus(Testdata updatedPet) {
    int index = listDataHome.indexWhere((pet) => pet.id == updatedPet.id);
    if (index != -1) {
      listDataHome[index] = updatedPet;
      notifyListeners();
    }
  }




}