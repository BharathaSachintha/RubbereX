class Plant {
  final String title;
  final String discription;
  final String price;
  final String height;
  final String image;
  final String temprature;
  final String port;

  Plant(
      {this.title,
      this.discription,
      this.price,
      this.height,
      this.image,
      this.temprature,
      this.port,});
}

List<Plant> plants = [
  Plant(
    title: "Rubber Plant S1",
    discription: "small leaf",
    height: "20.0 cm to 30.0 cm",
    temprature: "18c to 25c",
    image: "https://img.pngio.com/download-artificial-potted-plant-oregano-png-image-for-free-potted-plants-png-2000_2000.png",
    port: "Self Growing pot",
    price: "30.00"
  ),
  Plant(
    title: "Rubber Plant S2",
    discription: "small leaf",
    height: "40.0 cm to 50.0 cm",
    temprature: "18c to 25c",
    image: "https://img.pngio.com/download-artificial-potted-plant-oregano-png-image-for-free-potted-plants-png-2000_2000.png",
    port: "Self Growing pot",
    price: "50.00"
  ),
];
