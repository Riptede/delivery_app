import 'package:delivery_app/logg/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List itemsToCart;
  const CartScreen({super.key, required this.itemsToCart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var dio = Dio();
  final items = [];
  Future<void> fetchSearchResults(query) async {
    try {
      // URL вашего запроса

      String url = 'https://api.spoonacular.com/food/menuItems/$query';
      var queryParams = {
        'apiKey': 'f08315902a0d4c45b75f84587255f256',
      };

      // Выполнение GET-запроса
      Response response = await dio.get(url, queryParameters: queryParams);
      if (response.statusCode == 200) {
        setState(() {
          items.add([
            response.data['title'].toString(),
            response.data['price'].toString()
          ]);
        });
      }
      // Вывод результатов
    } catch (e) {
      logger.e('Ошибка при выполнении запроса: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.itemsToCart.length; i++) {
      fetchSearchResults(widget.itemsToCart[i]);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cart",
                  style: theme.textTheme.titleLarge,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(const Color(0xFF383434)),
                  ),
                  onPressed: () =>{
                    
                  }, child: Text("Buy",style: theme.textTheme.headlineMedium,))
              ],
            ),
          ),
          backgroundColor: theme.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Center(
            child: items.isNotEmpty
                ? ListView.separated(
                    itemCount: widget.itemsToCart.length,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      if (index >= items.length) return Container();
                      logger.i(items);
                      return Column(children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  items[index][0],
                                  style: theme.textTheme.bodyMedium,
                                ),
                                Text(
                                  '${items[index][1] == null ? items[index][1] : int.parse(items[index][0].length.toString()) + 200} ₽',
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ]),
                        )
                      ]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  )
                : Text("Cart is empty"),
          ),
        ));
  }
}
