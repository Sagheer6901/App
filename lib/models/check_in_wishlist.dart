
import 'dart:convert';

CheckInWishlist checkInWishlistFromJson(String str) => CheckInWishlist.fromJson(json.decode(str));

String checkInWishlistToJson(CheckInWishlist data) => json.encode(data.toJson());

class CheckInWishlist {
  CheckInWishlist({
    this.numRows,
  });

  int? numRows;

  factory CheckInWishlist.fromJson(Map<String, dynamic> json) => CheckInWishlist(
    numRows: json["num_rows"],
  );

  Map<String, dynamic> toJson() => {
    "num_rows": numRows,
  };
}
