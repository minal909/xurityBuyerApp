class CardImages {
  String? imgUrl;
  String? sellerId;
  bool? isVisible;

  CardImages({
    this.imgUrl,
    this.isVisible,
    this.sellerId,
  });

  factory CardImages.fromJson(Map<String, dynamic> json) {
    return CardImages(
      imgUrl: json['imgUrl'],
      isVisible: json['visible'],
      sellerId: json['seller_id'],
    );
  }
}
