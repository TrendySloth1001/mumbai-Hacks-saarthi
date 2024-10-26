import 'package:flutter/material.dart';

class FoodItem {
  final int id;
  final String name;
  final double price;
  final String category;

  FoodItem({required this.id, required this.name, required this.price, required this.category});
}

class Restaurant {
  final int id;
  final String name;
  final double rating;

  Restaurant({required this.id, required this.name, required this.rating});
}

class FoodShoppingPage extends StatefulWidget {
  @override
  _FoodShoppingPageState createState() => _FoodShoppingPageState();
}

class _FoodShoppingPageState extends State<FoodShoppingPage> {
  final List<FoodItem> foodItems = [
    FoodItem(id: 1, name: 'Butter Chicken', price: 250, category: 'food'),
    FoodItem(id: 2, name: 'Paneer Tikka', price: 200, category: 'food'),
    FoodItem(id: 3, name: 'Masala Dosa', price: 100, category: 'food'),
    FoodItem(id: 4, name: 'Biryani', price: 180, category: 'food'),
    FoodItem(id: 5, name: 'Gulab Jamun', price: 50, category: 'food'),
    FoodItem(id: 6, name: 'Coca Cola', price: 40, category: 'goodies'),
    FoodItem(id: 7, name: 'Lays Chips', price: 20, category: 'goodies'),
    FoodItem(id: 8, name: 'Chocolate Bar', price: 30, category: 'goodies'),
  ];

  final List<Restaurant> restaurants = [
    Restaurant(id: 1, name: 'Spice Garden', rating: 4.5),
    Restaurant(id: 2, name: 'Tandoori Nights', rating: 4.2),
    Restaurant(id: 3, name: 'South Indian Delight', rating: 4.0),
  ];

  String searchTerm = '';
  String activeTab = 'all';

  List<FoodItem> get filteredItems {
    return foodItems.where((item) =>
      item.name.toLowerCase().contains(searchTerm.toLowerCase()) &&
      (activeTab == 'all' || item.category == activeTab)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Shopping', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food items or restaurants...',
                  prefixIcon: Icon(Icons.search, color: Colors.green),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchTerm = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTabButton('All', 'all'),
                  _buildTabButton('Food', 'food'),
                  _buildTabButton('Goodies', 'goodies'),
                ],
              ),
              SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                item.name,
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '₹${item.price.toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart, size: 16),
                                    SizedBox(width: 8),
                                    Text('Add to Cart'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                'Nearby Restaurants',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  final restaurant = restaurants[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(restaurant.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Rating: ${restaurant.rating}/5'),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text('View Menu', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, String value) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          activeTab = value;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: activeTab == value ? Colors.green : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }
}
