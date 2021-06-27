import 'package:flutter/cupertino.dart';
import 'package:my_shop/Services/user_service.dart';
import 'package:my_shop/Services/utility_service.dart';
import 'package:my_shop/locator.dart';
import 'package:my_shop/models/PharmacyDTO.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';

class AddressProvider with ChangeNotifier {
  List<KeyValueItem> _governorates = [];
  Pharmacy get defultPharmacy {
    return _defultPharmacy;
  }

  Pharmacy _defultPharmacy;

  Pharmacy get selectedPharmacy {
    return _selectedPharmacy;
  }

  List<KeyValueItem> get governorates {
    return [..._governorates];
  }

  KeyValueItem selectedGovernorate = KeyValueItem();
  List<KeyValueItem> cities = [];
  KeyValueItem selectedCity = KeyValueItem();
  List<Pharmacy> _pharmacies = [];
  List<Pharmacy> get pharmacies {
    return [..._pharmacies];
  }

  Pharmacy _selectedPharmacy;
  Future<void> initAddressProvider() async {
    await getGoverenment();
    await _getCityList();
    if (_pharmacies.length == 0) {
      _pharmacies = await UserService().getUserPharmacies();
    }
    _selectedPharmacy = new Pharmacy(
        id: null,
        name: '',
        phone: '',
        governorate: selectedGovernorate,
        city: selectedCity,
        address: '');
    // getDefultPharmacy();
    notifyListeners();
  }

  void selectGoverenment(int id) {
    selectedGovernorate =
        _governorates.firstWhere((element) => element.key == id);
    notifyListeners();
  }

  void selectCity(int id) {
    selectedCity = cities.firstWhere((element) => element.key == id);
    notifyListeners();
  }

  Future getGoverenment() async {
    try {
      if (_governorates.isEmpty) {
        _governorates = await locator<UtiltiyService>().getGoverenment();
      }
      if (_selectedPharmacy != null) {
        selectedGovernorate = _governorates.firstWhere(
            (element) => element.key == _selectedPharmacy.governorate.key);
      } else {
        selectedGovernorate = _governorates.first;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future _getCityList() async {
    try {
      if (cities.isEmpty) {
        cities =
            await locator<UtiltiyService>().getCities(selectedGovernorate.key);
      }
      if (_selectedPharmacy != null) {
        selectedCity = cities
            .firstWhere((element) => element.key == _selectedPharmacy.city.key);
      } else {
        selectedCity = cities.first;
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future getUserAddress() async {
    await initAddressProvider();
    _pharmacies = await UserService().getUserPharmacies();
  }

  void findByid(int id) {
    _selectedPharmacy = _pharmacies.firstWhere((phamacy) => phamacy.id == id);
  }

  Future<void> addAddress(Pharmacy pharmacy) async {
    var mypharmacy = Pharmacy(
      id: pharmacy.id,
      name: pharmacy.name,
      phone: pharmacy.phone,
      governorate: selectedGovernorate,
      city: selectedCity,
      address: pharmacy.address,
    );

    await UserService().addAddress(mypharmacy);
    await getUserAddress();
    _defultPharmacy = _pharmacies.last;
    notifyListeners();
  }

  Future<void> updateAddress(Pharmacy pharmacy) async {
    var mypharmacy = Pharmacy(
      id: pharmacy.id,
      name: pharmacy.name,
      phone: pharmacy.phone,
      governorate: selectedGovernorate,
      city: selectedGovernorate,
      address: pharmacy.address,
    );

    await UserService().updateAddress(mypharmacy);
    await getUserAddress();
    notifyListeners();
  }

  void setDefult(int pharmacyId) {
    int index = _pharmacies.indexWhere((element) => element.isDefault);
    if (index >= 0)
      _pharmacies[index].isDefault = !_pharmacies[index].isDefault;
    index = _pharmacies.indexWhere((element) => element.id == pharmacyId);
    _pharmacies[index].isDefault = !_pharmacies[index].isDefault;
    notifyListeners();
    UserService().setDefaultAddress(_pharmacies[index]);
  }

  void setSelectedPharmacy(int pharmacyId) {
    _defultPharmacy =
        _pharmacies.firstWhere((element) => element.id == pharmacyId);
    notifyListeners();
  }

  Future deleteAddresss(Pharmacy pharmacy) async {
    _pharmacies.removeWhere((pro) => pro.id == pharmacy.id);
    notifyListeners();
    await UserService().deleteAddress(pharmacy);

    //await getUserAddress();
  }

  void getDefultPharmacy() {
    _defultPharmacy = _pharmacies.firstWhere((element) => element.isDefault);
  }
}
