// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:api_integration_rs/controller/product_controller.dart';
import 'package:api_integration_rs/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log(1);
    final provider = Provider.of<ProductProvider>(context);
    provider.getDataFromApi();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'P R O D U C T S',
          style: GoogleFonts.amethysta(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: provider.isLoading
          ? loadingUi()
          // : provider.error.isNotEmpty
          //     ? errorUI(provider.error)
          : bodyUI(provider.product),
    );
  }

  Widget loadingUi() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitFadingCircle(
              color: Colors.grey,
              size: 80,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Loading',
            style: GoogleFonts.acme(fontSize: 25, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  // Widget errorUI(String error) {
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           error,
  //           style: GoogleFonts.akshar(
  //               fontWeight: FontWeight.bold, fontSize: 30, color: Colors.red),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget bodyUI(Products product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        // gridDelegate:
        //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: product.products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 20, bottom: 30, left: 8, right: 8),
            child: Container(
              // height: 100,
              // width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: kElevationToShadow[2]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      product.products[index].title.toString(),
                      style: GoogleFonts.aboreto(
                          fontSize: 27, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        product.products[index].images[0].toString(),
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      product.products[index].description,
                      style: GoogleFonts.adamina(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(
                      
                      children: [
                        Text(
                          'Stock left only : ',
                          style: GoogleFonts.adamina(
                              color: Colors.grey[700],
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          product.products[index].stock.toString(),
                          style: GoogleFonts.adamina(
                              color: const Color.fromARGB(255, 147, 16, 6),
                              fontSize: 23,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '€',
                          style: GoogleFonts.aboreto(
                              fontSize: 28, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          product.products[index].price.toString(),
                          style: GoogleFonts.aboreto(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Text(
                              'rating',
                              style: GoogleFonts.adamina(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              product.products[index].rating.toString(),
                              style: GoogleFonts.aboreto(
                                  color: const Color.fromARGB(255, 233, 175, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
