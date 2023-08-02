class Items {
  final String inumber;
  final String title;
  final String discription;
  final String price;
  final String height;
  final String image;
  final String gram;

  Items({
    required this.inumber,
    required this.title,
    required this.discription,
    required this.price,
    required this.height,
    required this.image,
    required this.gram,
  });
}

List<Items> items = [
  Items(
      inumber: "C-1",
      title: "CAPMERAK Rubber Tapping Knife",
      discription: "Gebung / Bi- directional,Carbon Steel",
      height: "37 cm",
      gram: "380 g",
      image:
          "https://www.linkpicture.com/q/c1knife.jpg",
      price: "1500.00"),
  Items(
      inumber: "C-2",
      title: "CAPMERAK Rubber Tapping Knife",
      discription: "Gebung / Bi- directional,Carbon Steel",
      height: "34 cm",
      gram: "300 g",
      image:
          "https://www.linkpicture.com/q/c2knife.jpg",
      price: "1250.00"),
  Items(
      inumber: "T-1",
      title: "CAPMERAK Rubber Tapping Knife",
      discription: "Gebung / Bi- directional,Carbon Steel",
      height: "27 cm",
      gram: "290 g",
      image:
          "https://www.linkpicture.com/q/c1knife_1.jpg",
      price: "1000.00"),
];
