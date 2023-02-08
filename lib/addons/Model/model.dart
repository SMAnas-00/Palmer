class DataModel {
  final String title;
  final String imagename;
  final double price;
  DataModel(this.title, this.imagename, this.price);
}

List<DataModel> datalist = [
  DataModel("Packages", "images/img_slider1.jpg", 300),
  DataModel("Hajj", "images/img_slider2.jpg", 10000),
  DataModel("Ummrahh", "images/img_slider3.jpg", 5000)
];
