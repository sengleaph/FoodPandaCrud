
import 'package:flutter/material.dart';
import 'package:foodpanda_clone/views/DetailRestaurant/widgets/popularcart.dart';
import 'package:foodpanda_clone/views/checkout/viewcart_page.dart';

class Restaurant extends StatefulWidget {
  @override
  _Restaurant createState() => _Restaurant();
}

class _Restaurant extends State<Restaurant> {
  List<String> productTitles = [
    "Popular",
    "Colonel Stacker",
    "A La Carte",
    "Burger",
    "Stack",
    "ComboMeal"
  ];
  int currentTabIndex = 0;
  PageController _pageController = PageController(keepPage: true);

  // Sample data for products in each category
  List<Product> popularProducts = [
    Product(name: "Product 1", description: "Description of Product 1."),
    Product(name: "Product 2", description: "Description of Product 2."),
    Product(name: "Product 3", description: "Description of Product 3."),
    Product(name: "Product 4", description: "Description of Product 4."),
  ];

  List<Product> ColenelStacker = [
    Product(name: "burger Product 1", description: "Description of Burger Product 1."),
    Product(name: "burger Product 2", description: "Description of Burger Product 2."),
    Product(name: "burger Product 3", description: "Description of Burger Product 3."),

  ];

  List<Product> ALaCarte = [
    Product(name: "leg Product 1", description: "Description of leg Product 1."),
    Product(name: "leg Product 2", description: "Description of leg Product 2."),
    Product(name: "leg Product 3", description: "Description of leg Product 3."),
  ];

  List<Product> Burger = [
    Product(name: "Burger Product 1", description: "Description of Burger Product 1."),
    Product(name: "Burger Product 2", description: "Description of Burger Product 2."),
    Product(name: "Burger Product 3", description: "Description of Burger Product 3."),
  ];

  List<Product> Snake = [
    Product(name: "Snake Product 1", description: "Description of Snake Product 1."),
    Product(name: "Snake Product 2", description: "Description of Snake Product 2."),
    Product(name: "Snake Product 3", description: "Description of Snake Product 3."),
  ];

  List<Product> ComboMeal = [
    Product(name: "meal Product 1", description: "Description of meal Product 1."),
    Product(name: "meal Product 2", description: "Description of meal Product 2."),
    Product(name: "meal Product 3", description: "Description of meal Product 3."),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentTabIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Delivery",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "20 min",
              style: TextStyle(fontSize: 15, color: Colors.pinkAccent),
            )
          ],
        ),
        actions: const [
          Icon(
            Icons.favorite_border_outlined,
            color: Colors.pinkAccent,
            size: 30,
          ),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.share_outlined,
            color: Colors.pinkAccent,
          ),
          SizedBox(
            width: 25,
          ),
          Icon(
            Icons.search,
            color: Colors.pinkAccent,
            size: 35,
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "KFC Kampuchea Krom",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black54, fontSize: 36),
                        children: <TextSpan>[
                          TextSpan(text: '3.8km away |'),
                          TextSpan(
                              text: ' Free delivery',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      textScaleFactor: 0.5,
                    ),
                    const Text(
                      "More info",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border_outlined,
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(fontSize: 36),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '4.8',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              TextSpan(
                                  text: ' .79 ratings',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                          textScaleFactor: 0.5,
                        ),
                      ],
                    ),
                    const Text(
                      "See reviews",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.alarm_add_outlined,
                          color: Colors.pinkAccent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Delivery 20 min",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        )
                      ],
                    ),
                    Text(
                      "Change",
                      style: TextStyle(
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
            height: 50,
            decoration: const BoxDecoration(color: Colors.white),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productTitles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Padding( // Add Padding widget
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal padding
                    child: Text(
                      productTitles[index],
                      style: TextStyle(
                        fontSize: 18,
                        color: index == currentTabIndex ? Colors.blue : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: productTitles.length,
            itemBuilder: (context, index) {
              return _buildProductSection(index);
            },
          ),
        ),
      ]),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ViewCartPage()));
          // Add your onPressed logic here
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "1",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    Text(
                      "View your cart",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Text(
                      "\$ 6.25",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildProductSection(int index) {
    // Conditionally choose ListView or GridView based on the category's index
    if (index == 0) {
      return ProductSection(
        title: productTitles[index],
        products: popularProducts,
        isGridView: false,
      );
    } else {
      return ProductSection(
        title: productTitles[index],
        products: _getProductsForCategory(index),
        isGridView: true,
      );
    }
  }

  List<Product> _getProductsForCategory(int categoryIndex) {
    switch (categoryIndex) {
      case 1:
        return ALaCarte;
      case 2:
        return ColenelStacker;
      case 3:
        return Burger;
      case 4:
        return Snake;
      case 5:
        return ComboMeal;
      default:
        return [];
    }
  }
}

class Product {
  final String name;
  final String description;

  Product({required this.name, required this.description});
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<Product> products;
  final bool isGridView;

  ProductSection({
    required this.title,
    required this.products,
    required this.isGridView,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (!isGridView)
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust the number of columns as needed
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: products.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildProductCard(products[index]);
                },
              )
            else
              for (var product in products)
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.white70,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Colonel Stacker Ala Carte", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const Text(
                                '1pc Colonel Stacker + 1 Whipped Potato R + 1 Fries R...',
                                style: TextStyle(color: Colors.black45),
                                maxLines: 2, // Set max lines for the description
                                overflow: TextOverflow.ellipsis, // Add ellipsis if it exceeds max lines
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  const Text("from \$ 1.60"),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[350],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.fire_hydrant),
                                          Text("Popular"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Image.asset("assets/images/kfc1.png", height: 150),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 6),
                            //   child: Align(
                            //     alignment: Alignment.bottomRight,
                            //     child: Container(
                            //       width: 40,
                            //       height: 40,
                            //       decoration: BoxDecoration(
                            //         color: Colors.pinkAccent,
                            //         borderRadius: BorderRadius.circular(50),
                            //       ),
                            //       // child: IconButton(
                            //       //   onPressed: () {},
                            //       //   icon: const Icon(Icons.add, color: Colors.white),
                            //       // ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            // Add more content for the product section if needed
          ],
        ),
      ),
    );
  }
  Widget _buildProductCard(Product product) {
    return const PopularCart();
  }
}