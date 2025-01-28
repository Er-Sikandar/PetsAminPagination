class Testdata {
  String? id;
  String? title;
  String? image;
  bool? isAdopted;

  Testdata({this.id,this.title, this.image,this.isAdopted});

 /* Testdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    isAdopted = json['isAdopted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['isAdopted'] = this.isAdopted;
    return data;
  }*/
}