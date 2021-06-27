import 'package:firebase_auth/firebase_auth.dart' as fire;
import 'package:my_shop/Services/pus_notification_service.dart';
import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/Utility/enums.dart';
import 'package:my_shop/models/PharmacyDTO.dart';
import '../models/userDto.dart';
import '../Utility/constant.dart';
import '../Services/utility_service.dart';

class UserService {
  Future<void> registerUser(fire.User user, LoginTypeEnum loginType) async {
    String instanceId = await PusNotificationService().intialise();
    UserDTO userDTO = UserDTO(instanceId, user.phoneNumber, user.toString(),
        UserTypeEnum.Pharmacy, loginType, user.uid);
    UtiltiyService().getListFromhttpAuthorizationPost(RegisterUser, userDTO,
        convert: (e) => userDTO.toJson());
  }

  Future<void> addAddress(Pharmacy pharmacy) async {
    return await UtiltiyService().httpAuthorizationPost(AddAddress, pharmacy);
  }

  Future<void> updateAddress(Pharmacy pharmacy) async {
    return await UtiltiyService()
        .httpAuthorizationPost(UpdateAddress, pharmacy);
  }

  Future<void> deleteAddress(Pharmacy pharmacy) async {
    return await UtiltiyService()
        .httpAuthorizationPost(DeletePharmacy, pharmacy);
  }

  Future<void> setDefaultAddress(Pharmacy pharmacy) async {
    return await UtiltiyService()
        .httpAuthorizationPost(DefaultPharmacy, pharmacy);
  }

  Future<List<Pharmacy>> getUserPharmacies() async {
    PagedList<Pharmacy> items = await UtiltiyService()
        .getListFromhttpAuthorizationGet(
            GetAddressList, (e) => Pharmacy.fromJson(e));
    return items.toMyList();
  }
}
