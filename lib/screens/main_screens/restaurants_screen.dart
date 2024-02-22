import 'dart:math';

import 'package:delivery_app/logg/logger.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class RestaurantScreen extends StatefulWidget {
  final Function(int) addItemToCart;
    const RestaurantScreen({Key? key, required this.addItemToCart}) : super(key: key);


  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  var dio = Dio();
  final items = [];
  
// Определите функцию для выполнения запроса
  Future<void> fetchSearchResults({String query = 'burger'}) async {
    try {
      // URL вашего запроса

      String url = 'https://api.spoonacular.com/food/menuItems/search';
      var queryParams = {
        'query': query,
        'minCalories': '50',
        'maxCalories': '800',
        'minCarbs': '10',
        'maxCarbs': '100',
        'minProtein': '10',
        'maxProtein': '100',
        'minFat': '1',
        'maxFat': '100',
        'offset': '606',
        'number': '10',
        'apiKey': 'f08315902a0d4c45b75f84587255f256',
      };

      // Выполнение GET-запроса
      Response response = await dio.get(url, queryParameters: queryParams);
      if (response.statusCode == 200) {
        setState(() {
          items.clear();
          items.addAll(response.data['menuItems']);
        });
      }
      // Вывод результатов
    } catch (e) {
      logger.e('Ошибка при выполнении запроса: $e');
    }
  }

  final _searchController = TextEditingController();

  void searchDeals() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      fetchSearchResults(query: query);
    } else {
      fetchSearchResults(); // Вызывается без параметров, если текст пустой
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    fetchSearchResults();
    setState(() {});
    logger.i(items);
    _searchController.addListener(searchDeals);
  }

  @override
  Widget build(BuildContext context) {
    // Определите функцию для выполнения запроса

    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          title: Row(
            children: [
              const SizedBox(
                width: 50,
                child: Icon(
                  Icons.delivery_dining_rounded,
                  color: Color(0xFF484444),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFf0fc8c),
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Color(0xFFf0fc8c)),
                    prefixIcon: const Icon(Icons.search_rounded),
                    prefixIconColor: const Color(0xFFf0fc8c),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 100, 99, 99),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFf0fc8c),
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: _searchController,
                ),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: theme.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
              itemExtent: 310,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: items.length,
              itemBuilder: (itemBuilder, index) {
                final deal = items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: GestureDetector(
                        onTap: () {
                          widget.addItemToCart(deal['id']);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: getImage(deal)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: <InlineSpan>[
                            const WidgetSpan(
                                child: Icon(
                              Icons.star_border,
                              color: Color(0xFFf0fc8c),
                              size: 20,
                            )),
                            TextSpan(
                                text:
                                    '4.5  ${int.parse((deal['id'] / 1000).toStringAsFixed(0)) - 100}₽ ${deal['title']}',
                                style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ));
  }

  Image getImage(deal) {
    if (deal['image'] == null || deal['image'].isEmpty) {
      // Возвращаем изображение-заполнитель, если URL невалиден
      return Image.asset(
        'assets/placeholder.png',
        fit: BoxFit.cover,
      );
    } else {
      // Используем Image.network, если URL валиден
      return Image.network(
        deal['image'],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Возвращаем изображение-заполнитель, если загрузка изображения завершилась ошибкой
          return Image.asset(
            'assets/placeholder.png',
            fit: BoxFit.cover,
          );
        },
      );
    }
  }
}
