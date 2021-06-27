import 'dart:ui';

const BaseURL =
    //"http://asameh-001-site1.itempurl.com//API//"; //
    "http://192.168.1.11//PharmacyStockAPI//api//";
const GetBrands = BaseURL + "Utility//GetBrands?count=";
const GetGoverenmentes = BaseURL + "Utility//GetGovernorates";
const GetCities = BaseURL + "Utility//GetCities?governorateId=";
const GetProducts = BaseURL +
    "Product/GetProductsByBrand?pageNumber=%s&brandId=%s&isFavorite=%s&description=%s";
const addOrder = BaseURL + "Order/AddOrder?PharmacyId=%s";
const SetFavorite = BaseURL + "Product/ManageFavorite";
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const RegisterUser = BaseURL + "User//RegisterUser";
const GetOrderList = BaseURL + "Order/GetOrderList?pageNumber=%s";
const AddAddress = BaseURL + "Pharmacy/AddPharmacy";
const GetAddressList = BaseURL + "Pharmacy/GetPharmacyList";
const DeletePharmacy = BaseURL + "Pharmacy/DeletePharmacy";
const DefaultPharmacy = BaseURL + "Pharmacy/SetDefaultPharmacy";
const UpdateAddress = BaseURL + "Pharmacy/UpdatePharmacy";
