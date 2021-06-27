import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
enum UserTypeEnum {
  @JsonValue("Pharmacy")
  Pharmacy,
  @JsonValue("Stock")
  Stock,
  @JsonValue("Admin")
  Admin
}
@JsonSerializable()
enum LoginTypeEnum {
  @JsonValue("EmailAndPassword")
  EmailAndPassword,
  @JsonValue("Gmail")
  Gmail,
  @JsonValue("Phone")
  Phone
}
