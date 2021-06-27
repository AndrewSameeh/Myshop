import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/Utility/constant.dart';
import 'package:my_shop/models/utility/KeyValueItem.dart';
import 'package:sprintf/sprintf.dart';
import '../locator.dart';
import './utility_service.dart';
import '../models/product.dart';
import '../Utility/PagedList.dart';

class ProductService {
  Future<PagedList<Product>> getProducts(
      int pageNumber, int brandId, bool isfavorite, String description) async {
    final String url = sprintf(GetProducts,
        ["$pageNumber", "$brandId", "$isfavorite", "$description"]);

    return await locator<UtiltiyService>()
        .getListFromhttpAuthorizationGet<Product>(
            url, (e) => Product.fromJson(e));
  }

  Future<void> favorite(int itemNumber, bool isfavorite) async {
    await locator<UtiltiyService>().getListFromhttpAuthorizationPost(
        SetFavorite,
        KeyValueItem(key: itemNumber, value: isfavorite.toString()));
  }
}
