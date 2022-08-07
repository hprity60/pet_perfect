import 'dart:io';

class PetRegistrationModel {
  String petName;
  String breed;
  String gender;
  String userName;
  String phone;
  String mobile;
  String email;
  String house;
  String street;
  String city;
  String state;
  String pinCode;
  File image;
  String userImage;
  String thumbnail;
  String status;
  String registrationId;

  PetRegistrationModel({
    this.breed,
    this.city,
    this.email,
    this.gender,
    this.house,
    this.image,
    this.mobile,
    this.petName,
    this.phone,
    this.thumbnail,
    this.pinCode,
    this.state,
    this.street,
    this.userName,
    this.status,
    this.registrationId,
    this.userImage,
  });

  factory PetRegistrationModel.fromJson(Map<String, dynamic> json) =>
      PetRegistrationModel(
        breed: json['breed'] ?? '',
        city: json['city'] ?? '',
        email: json['email'] ?? '',
        gender: json['gender'] ?? '',
        house: json['house'] ?? '',
        image: json['image'] ?? '',
        mobile: json['mobile'] ?? '',
        petName: json['petName'] ?? '',
        phone: json['phone'] ?? '',
        pinCode: json['pinCode'] ?? '',
        state: json['state'] ?? '',
        street: json['street'] ?? '',
        userName: json['userName'] ?? '',
        status: json['status'] ?? '',
        registrationId: json['registrationId'] ?? '',
        userImage: json['userImage'],
        thumbnail: json["thumbnail"],
      );
}
