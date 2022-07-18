import 'dart:convert';

UserProfile UserfProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String individualPostToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    this.id,
    this.name,
    this.email,
    this.address,
    this.contact,
    this.date,
    this.image,
    this.country,
    this.city,
    this.carNo,
    this.licenseNo,
    this.licensePic,
    this.age,
    this.experience,
    this.language,
    this.password,
    this.role,
    this.vstatus,
    this.vkey,
    this.vkeytime,
    this.fcode,
    this.nic,
    this.verstatus,
    this.location,
    this.services,
    this.servicetype,
    this.otpEmailStatus,
    this.otpPhoneStatus,
  });

  String? id;
  String? name;
  String? email;
  String? address;
  String? contact;
  dynamic? date;
  dynamic? image;
  dynamic? country;
  dynamic? city;
  dynamic? carNo;
  dynamic? licenseNo;
  dynamic? licensePic;
  dynamic? age;
  dynamic? experience;
  dynamic? language;
  String? password;
  String? role;
  String? vstatus;
  dynamic? vkey;
  dynamic? vkeytime;
  dynamic? fcode;
  dynamic? nic;
  dynamic? verstatus;
  dynamic? location;
  dynamic? services;
  String? servicetype;
  String? otpEmailStatus;
  String? otpPhoneStatus;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        contact: json["contact"],
        date: json["date"],
    // date: DateTime.parse(json["date"]),

        image: json["image"],
        country: json["country"],
        city: json["city"],
        carNo: json["car_no"],
        licenseNo: json["license_no"],
        licensePic: json["license_pic"],
        age: json["age"],
        experience: json["experience"],
        language: json["language"],
        password: json["password"],
        role: json["role"],
        vstatus: json["vstatus"],
        vkey: json["vkey"],
        vkeytime: json["vkeytime"],
        fcode: json["fcode"],
        nic: json["nic"],
        verstatus: json["verstatus"],
        location: json["location"],
        services: json["services"],
        servicetype: json["servicetype"],
        otpEmailStatus: json["otp_email_status"],
        otpPhoneStatus: json["otp_phone_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "contact": contact,
    "date":date,
    // "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "image": image,
        "country": country,
        "city": city,
        "car_no": carNo,
        "license_no": licenseNo,
        "license_pic": licensePic,
        "age": age,
        "experience": experience,
        "language": language,
        "password": password,
        "role": role,
        "vstatus": vstatus,
        "vkey": vkey,
        "vkeytime": vkeytime,
        "fcode": fcode,
        "nic": nic,
        "verstatus": verstatus,
        "location": location,
        "services": services,
        "servicetype": servicetype,
        "otp_email_status": otpEmailStatus,
        "otp_phone_status": otpPhoneStatus,
      };
}
