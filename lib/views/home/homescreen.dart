import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodpanda_clone/cuisines.dart';
import 'package:foodpanda_clone/get_model.dart';
import 'package:foodpanda_clone/shop_model.dart';
import 'package:foodpanda_clone/views/home/widgets/cuisine.dart';
import 'package:foodpanda_clone/views/home/widgets/cus_sliverbanner.dart';
import 'package:foodpanda_clone/views/home/widgets/gridfood.dart';
import 'package:foodpanda_clone/views/home/widgets/mydrawer_cus.dart';
import 'package:foodpanda_clone/views/home/widgets/near_restaurant.dart';
import 'package:foodpanda_clone/views/home/widgets/slidercardone.dart';
import 'package:foodpanda_clone/views/home/widgets/slidercardthree.dart';
import 'package:foodpanda_clone/views/home/widgets/top_restaurant.dart';
import 'package:foodpanda_clone/views/home/widgets/voucher.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final VoidCallback? refreshCallback;
  const HomeScreen({Key? key, this.refreshCallback}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<RestaurantModel> futureRestaurant;
  late Future<CuisinesModel> futureCuisines;

  Future<RestaurantModel> fetchRestaurantData() async {
    final response = await http.get(Uri.parse(
        'https://cms.istad.co/api/food-panda-restaurants?populate=*'));
    if (response.statusCode == 200) {
      return restaurantModelFromJson(response.body);
    } else {
      // Handle the error case
      throw Exception('Failed to fetch restaurant data');
    }
  }

  Future<CuisinesModel> fetchCuisines() async {
    final res = await http.get(
        Uri.parse('https://cms.istad.co/api/food-panda-cuisines?populate=%2A'));
    if (res.statusCode == 200) {
      return cuisinesModelFromJson(res.body);
    } else {
      throw Exception("Failed to fetch Cuisines");
    }
  }

  Future<void> handleDataRefresh() async {
    // Perform data refresh on this page
    await fetchRestaurantData();
    await fetchCuisines();

    // Notify the parent widget that the refresh is complete
    widget.refreshCallback?.call();
  }

  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurantData();
    futureCuisines = fetchCuisines();
    widget.refreshCallback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.pink[600],
        ),
        backgroundColor: Colors.pink[600],
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
        ),
        title: Row(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                      text: "262 St 150a\n",
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  TextSpan(text: "Phom Penh"),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.card_travel))
          ],
        ),
      ),
      drawer: const MyDrawerCus(),
      body: RefreshIndicator(
        onRefresh: () async{
          await handleDataRefresh();
        },
        child: CustomScrollView(
          slivers: [
            const MysliverBanerCus(),
            const SliderOneCard(),
            const SliderThreeCard(),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 12, left: 20, bottom: 5),
                child: Text(
                  "Popular Restaurants",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
                  height: 350,
                  child: FutureBuilder<RestaurantModel>(
                    future: futureRestaurant,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = snapshot.data!.data![index].attributes;
                            final idpass = snapshot.data!.data![index].id?.toInt();
                            return TopRestaurant(
                                idpass: idpass,
                                item: item,
                                refreshCallback: handleDataRefresh);
                          },
                        );
                      }
                      return const Center(
                        child: Text('No data available.'),
                      );
                    },
                  ),
                )),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  "Cuisines",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 340,
                child: FutureBuilder<CuisinesModel>(
                  future: futureCuisines, // Set the future here
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.data == null || snapshot.data!.data!.isEmpty) {
                      return const Center(
                        child: Text('No data available.'),
                      );
                    }

                    return GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        final item = snapshot.data!.data![index].attributes;
                        final url = item?.thumbnail?.data?.attributes?.url;
                        return Cuisines(items: item, uri: url);
                      },
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Text(
                  "Pick up at a restaurant near you",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 330,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover),
                ),
                child: SizedBox(
                  height: 320,
                  child: FutureBuilder<RestaurantModel>(
                    future: futureRestaurant,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = snapshot.data!.data![index].attributes;
                            final idpass = snapshot.data!.data![index].id?.toInt();
                            return TopRestaurant(
                                idpass: idpass,
                                item: item,
                                refreshCallback: handleDataRefresh);
                          },
                        );
                      }
                      return const Center(
                        child: Text('No data available.'),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 20, bottom: 10),
                child: Text(
                  "Your daily deals",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Voucher();
                      }),
                )),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shops",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const Padding(
                            padding: EdgeInsets.only(right: 20, top: 10),
                            child: Column(
                              children: [
                                GridFood(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "Become a pro",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            TextSpan(
                              text: "\nand get exclusive deals",
                              style: TextStyle(color: Colors.black87, fontSize: 18),
                            ),
                          ])),
                      const Spacer(),
                      Image.network(
                          'https://images.deliveryhero.io/image/foodpanda/pandapro/img_top.png'),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "Try panda rewards",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            TextSpan(
                              text: "\nEarn points and win prizes",
                              style: TextStyle(color: Colors.black87, fontSize: 18),
                            ),
                          ])),
                      const Spacer(),
                      Image.network(
                          'https://images.deliveryhero.io/image/foodpanda/corporate/landing_page/illustration_allowancepaupau.png'),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300, width: 1)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: "Earn a 3\$ voucher",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            TextSpan(
                              text: "\nwhen you refer a friend",
                              style: TextStyle(color: Colors.black87, fontSize: 18),
                            ),
                          ])),
                      const Spacer(),
                      Image.asset('assets/images/gift.png'),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
