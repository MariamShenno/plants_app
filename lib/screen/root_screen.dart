import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/constants.dart';
import 'package:plants_app/models/plants.dart';
import 'package:plants_app/screen/cart_screen.dart';
import 'package:plants_app/screen/favorite_screen.dart';
import 'package:plants_app/screen/home_screen.dart';
import 'package:plants_app/screen/profile_screen.dart';
import 'package:plants_app/screen/scan-screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int bottomNavIndex = 0;
  List<Plant> favorites = [];
  List<Plant> myCart = [];

//Listof the screens
  List<Widget> widgetOptionScreen() {
    return [
      const HomeScreen(),
      FavoriteScreen(
        favoritedPlants: favorites,
      ),
      CartScreen(
        addedToCartPlants: myCart,
      ),
      const ProfileScreen(),
    ];
  }

//List of the screen Icon
  List<IconData> iconList = const [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

//List of Screens titles
  List<String> titleList = const [
    "Home",
    "Favorite",
    "Cart",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleList[bottomNavIndex],
              style: TextStyle(
                color: Constants.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            Icon(
              Icons.notifications,
              color: Constants.blackColor,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: bottomNavIndex,
        children: widgetOptionScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: const ScanScreen(),
              type: PageTransitionType.bottomToTop,
            ),
          );
        },
        backgroundColor: Constants.primaryColor,
        child: const Icon(Icons.qr_code_scanner_outlined, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        splashColor: Constants.primaryColor,
        activeColor: Constants.primaryColor,
        inactiveColor: Colors.black.withOpacity(.5),
        icons: iconList,
        activeIndex: bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        onTap: (index) {
          setState(() {
            bottomNavIndex = index;
            final List<Plant> favoritedPlants = Plant.getFavoritedPlants();
            final List<Plant> addToCartPlants = Plant.addedToCartPlants();

            favorites = favoritedPlants;
            myCart = addToCartPlants.toSet().toList();
          });
        },
      ),
    );
  }
}
