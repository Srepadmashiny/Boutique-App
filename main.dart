import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  String name;
  double price;

  Product(this.name, this.price);
}

class ShoppingCart {
  List<Product> items = [];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Padma\'s Boutique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BoutiquePage(),
        '/code': (context) => MyHomePage(),
        '/bill': (context) => BillPage(),
      },
    );
  }
}

class BoutiquePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Padma\'s Boutique'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/code');
          },
          child: Text('Browse our Catalogue'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ShoppingCart cart = ShoppingCart();

  List<Product> products = [
    Product("Shirt", 500.0),
    Product("Pant", 700.0),
    Product("Jeans", 800.0),
    Product("Skirt", 600.0),
    Product("Jumper", 900.0),
    Product("Jumpsuit", 1200.0),
    Product("Saree", 1000.0),
    Product("Kurti", 600.0),
    Product("Leggings", 400.0),
    Product("Dress", 1100.0),
    Product("Briefs", 200.0),
    Product("Underwear", 250.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalogue'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var product in products)
              ProductItem(
                product: product,
                onAddToCart: addToCart,
              ),
            CartWidget(
              cart: cart,
              onCheckout: () {
                Navigator.pushNamed(context, '/bill');
              },
            ),
          ],
        ),
      ),
    );
  }

  void addToCart(Product product) {
    setState(() {
      cart.items.add(product);
    });
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function(Product) onAddToCart;

  ProductItem({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Checkbox(
            value: false, // Replace with your checkbox logic
            onChanged: (bool? value) {
              // Handle checkbox state
            },
          ),
          SizedBox(width: 8.0),
          Text('${product.name} - \$${product.price.toStringAsFixed(2)}'),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              onAddToCart(product);
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}

class CartWidget extends StatelessWidget {
  final ShoppingCart cart;
  final VoidCallback onCheckout;

  CartWidget({required this.cart, required this.onCheckout});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shopping Cart',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          for (var item in cart.items)
            Text('${item.name} - \$${item.price.toStringAsFixed(2)}'),
          Text(
            'Total: \$${cart.items.map((item) => item.price).fold(0.0, (a, b) => a + b).toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: onCheckout,
            child: Text('Checkout'),
          ),
        ],
      ),
    );
  }
}

class BillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you for your purchase!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Back to Padma\'s Boutique'),
            ),
          ],
        ),
      ),
    );
  }
}





