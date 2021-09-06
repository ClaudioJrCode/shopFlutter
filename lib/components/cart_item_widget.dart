import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => Provider.of<Cart>(context, listen: false)
          .removeItem(cartItem.productId),
      direction: DismissDirection.endToStart,
      key: Key(cartItem.id),
      background: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          alignment: Alignment.centerRight,
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          )),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            horizontalTitleGap: 20,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(cartItem.imgUrl),
            ),
            title: Text(cartItem.name),
            subtitle: Text(
              'Subtotal R\$: ${cartItem.price * cartItem.quantity} ',
            ),
            trailing: Text('${cartItem.quantity} un.'),
          ),
        ),
      ),
    );
  }
}
//FittedBox(child: Text(cartItem.price.toString()))