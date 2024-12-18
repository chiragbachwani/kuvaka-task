import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? name;
  String? email;
  String? phone;
  DateTime? dateOfBirth;
  String? vehicleRegNo;
  String? vehicle;
  String? pincode;
  String? address;
  String? driverLicensePath;
  String? insurancePath;

  UserData({
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.vehicleRegNo,
    this.vehicle,
    this.pincode,
    this.address,
    this.driverLicensePath,
    this.insurancePath,
  });

  // Convert to a Map for Firebase upload
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'vehicleRegNo': vehicleRegNo,
      'vehicle': vehicle,
      'pincode': pincode,
      'address': address,
      'driverLicensePath': driverLicensePath,
      'insurancePath': insurancePath,
      'timestamp': FieldValue.serverTimestamp(), // Firebase timestamp
    };
  }
}
