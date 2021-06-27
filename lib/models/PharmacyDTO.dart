import 'package:flutter/cupertino.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';

class Pharmacy {
  final int id;
  final String name;
  final String phone;
  // final int governorateId;
  //final int cityId;
  final String address;
  KeyValueItem city;
  KeyValueItem governorate;
  bool isDefault;

  Pharmacy(
      {@required this.id,
      @required this.name,
      @required this.phone,
      @required this.governorate,
      @required this.city,
      @required this.address,
      this.isDefault = false});
  Map<String, dynamic> toJson() => _$PharmacyToJson(this);
  Map<String, dynamic> _$PharmacyToJson(Pharmacy instance) => <String, dynamic>{
        'PharmacyId': instance.id,
        'Name': instance.name,
        'Phone': instance.phone,
        'GovernorateId': instance.governorate.key,
        'CityId': instance.city.key,
        'Street': instance.address,
      };
  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
        id: json['PharmacyId'] as int,
        name: json['Name'] as String,
        //cityId: json['CityId'] as int,
        address: json['Street'] as String,
        governorate: KeyValueItem.fromJson(json['Governorate']),
        phone: json['Phone'] as String,
        city: KeyValueItem.fromJson(json['City']),
        isDefault: json['IsDefault'] as bool);
  }
}
