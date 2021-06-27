import 'package:my_shop/Utility/enums.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserDTO {
  String name;
  String email;
  String phone;
  String password;
  UserTypeEnum userType;
  String token;
  String uid;
  String instanceId;
  LoginTypeEnum loginType;
  String userInfo;

  UserDTO(this.instanceId, this.phone, this.userInfo, this.userType,
      this.loginType, this.uid,
      {this.name});
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
  Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
        'Email': instance.email,
        'Phone': instance.phone,
        //'Token': instance.token,
        'UserType': instance.userType
            .toString()
            .substring(instance.userType.toString().indexOf('.') + 1),
        'LoginType': instance.loginType
            .toString()
            .substring(instance.loginType.toString().indexOf('.') + 1),
        'UID': instance.uid,
        'InstanceId': instance.instanceId,
        'UserInfo': instance.userInfo
      };
}
