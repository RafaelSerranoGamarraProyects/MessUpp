// To parse this JSON data, do
//
//     final getSpentByCategoryResponse = getSpentByCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetSpentByCategoryResponse getSpentByCategoryResponseFromJson(String str) => GetSpentByCategoryResponse.fromJson(json.decode(str));

String getSpentByCategoryResponseToJson(GetSpentByCategoryResponse data) => json.encode(data.toJson());

class GetSpentByCategoryResponse {
    GetSpentByCategoryResponse({
        required this.category,
        required this.total,
    });

    String category;
    double total;

    factory GetSpentByCategoryResponse.fromJson(Map<String, dynamic> json) => GetSpentByCategoryResponse(
        category: json["category"],
        total: json["total"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "total": total,
    };
}
