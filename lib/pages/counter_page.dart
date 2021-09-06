import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Exemplo de Contador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              CounterProvider.of(context)?.state.value.toString() ?? '0',
              style: TextStyle(fontSize: 25),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() => CounterProvider.of(context)?.state.inc());
              },
            ),
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() => CounterProvider.of(context)?.state.dec());
              },
            ),
          ],
        ),
      ),
    );
  }
}
