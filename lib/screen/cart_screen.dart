import 'package:flutter/material.dart';
import 'package:plants_app/constants.dart';
import 'package:plants_app/models/plants.dart';
import 'package:plants_app/widget/plant_widget.dart';

class CartScreen extends StatefulWidget {
  final List<Plant> addedToCartPlants;
  const CartScreen({Key? key, required this.addedToCartPlants}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: widget.addedToCartPlants.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Icon(Icons.shopping_cart,color: Constants.primaryColor, size: 200,),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your Cart is Empty',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        height: size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.addedToCartPlants.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return PlantWidget(
                        index: index, plantList: widget.addedToCartPlants);
                  }),
            ),
            Column(
              children: [
                const Divider(thickness: 1.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Totals',style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w300,
                    ),
                    ),
                      Text(r'$65', style: TextStyle(
                        fontSize: 24.0,
                        color: Constants.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}