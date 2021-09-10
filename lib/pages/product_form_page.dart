import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/appbar.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imgUrlFocus = FocusNode();
  final _imgUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void initState() {
    super.initState();
    _imgUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['description'] = product.description;
        _formData['imgUrl'] = product.imgUrl;
        _formData['price'] = product.price;

        _imgUrlController.text = product.imgUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imgUrlFocus.dispose();
    _imgUrlFocus.removeListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  bool? isValidImgUrl([String url = '']) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool isValidFileType = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && isValidFileType;
  }

  submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    Provider.of<ProductList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Product Form',
        actions: [
          IconButton(
              onPressed: () {
                submitForm();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: InputDecoration(labelText: 'Name of Product'),
                textInputAction: TextInputAction.next,
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (name) {
                  if (name!.trim().length < 3 || name.trim().length > 50) {
                    return 'The name must have between 3 and 50 characters';
                  }
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_priceFocus),
              ),
              TextFormField(
                  initialValue: _formData['price']?.toString(),
                  decoration: InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  focusNode: _priceFocus,
                  onSaved: (price) =>
                      _formData['price'] = double.parse(price ?? ''),
                  keyboardType: TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_descriptionFocus),
                  validator: (_price) {
                    final priceString = _price ?? '';
                    final price = double.tryParse(priceString) ?? -1;

                    print(price);
                  }),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocus,
                maxLines: 3,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                keyboardType: TextInputType.multiline,
                validator: (_desc) {
                  final desc = _desc ?? '';
                  if (desc.trim().isEmpty) {
                    return 'Description Needed!';
                  }
                  if (desc.trim().length < 10) {
                    return 'The description must have more then 10 characters!';
                  }
                  return null;
                },
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_imgUrlFocus),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'URL of Image'),
                      focusNode: _imgUrlFocus,
                      controller: _imgUrlController,
                      onSaved: (imgUrl) => _formData['imgUrl'] = imgUrl ?? '',
                      keyboardType: TextInputType.url,
                      validator: (_imgUrl) {
                        final img = _imgUrl ?? '';
                        if (!isValidImgUrl(img)!) {
                          return 'Invalid URL';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submitForm(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right:
                            1), //right 1 para descontar tamanho da borda do container
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imgUrlController.text.isEmpty
                        ? Text('URL not found')
                        : Image.network(_imgUrlController.text),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
