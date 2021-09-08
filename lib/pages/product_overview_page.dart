import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/appbar.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/products_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverViewPage extends StatefulWidget {
  ProductOverViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _ProductOverViewPageState createState() => _ProductOverViewPageState();
}

class _ProductOverViewPageState extends State<ProductOverViewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<ProductList>(context);
    return Scaffold(
        appBar: AppBarWidget(
          title: 'Shop',
          actions: [
            PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                    child: Text('Your Favs'), value: FilterOptions.Favorites),
                PopupMenuItem(
                    child: Text('All items'), value: FilterOptions.All),
              ],
              onSelected: (FilterOptions selectedValue) {
                setState(
                  () {
                    if (selectedValue == FilterOptions.Favorites) {
                      _showFavoriteOnly = true;
                    } else {
                      _showFavoriteOnly = false;
                    }
                  },
                );
              },
            ),
            Consumer<Cart>(
              builder: (context, cart, child) => cart.itemsCount <= 0
                  ? Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.CART_PAGE);
                          },
                          icon: Icon(Icons.shopping_bag_outlined)))
                  : Badge(
                      value: cart.itemsCount.toString(),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.CART_PAGE);
                        },
                        icon: Icon(Icons.shopping_bag),
                      ),
                    ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ProductsGrid(_showFavoriteOnly),
        ),
        drawer: AppDrawer());
  }
}
