import 'package:my_shop/Services/utility_service.dart';
import 'package:my_shop/Utility/PagedList.dart';
import 'package:my_shop/Utility/constant.dart';
import 'package:my_shop/models/CartDTO.dart';
import 'package:my_shop/models/OrderDTO.dart';
import 'package:sprintf/sprintf.dart';
import '../Utility/constant.dart' as c;

import '../locator.dart';

class OrderService {
  Future<void> addOrder(List<CartItem> items, int addressId) async {
    final String url = sprintf(c.addOrder, ["$addressId"]);

    await locator<UtiltiyService>().getListFromhttpAuthorizationPost(
      url,
      items,
    );
  }

  Future<PagedList<OrderItem>> getOrders(int pageNumber) async {
    final String url = sprintf(GetOrderList, ["$pageNumber"]);

    return await locator<UtiltiyService>()
        .getListFromhttpAuthorizationGet(url, (e) => OrderItem.fromJson(e));
  }
}
