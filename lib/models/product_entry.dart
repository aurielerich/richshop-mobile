// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    int ongkir;
    String description;
    String? thumbnail;
    String category;
    int rating;
    int itemViews;
    bool isFeatured;
    DateTime createdAt;
    bool isRecommended;
    int? userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.ongkir,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.rating,
        required this.itemViews,
        required this.isFeatured,
        required this.createdAt,
        required this.isRecommended,
        required this.userId,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        ongkir: json["ongkir"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        rating: json["rating"],
        itemViews: json["item_views"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
        isRecommended: json["is_recommended"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "ongkir": ongkir,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "rating": rating,
        "item_views": itemViews,
        "is_featured": isFeatured,
        "created_at": createdAt.toIso8601String(),
        "is_recommended": isRecommended,
        "user_id": userId,
    };
}