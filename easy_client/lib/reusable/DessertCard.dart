import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:easy_client/Helper/helper.dart';
import 'package:flutter/material.dart';

class DessertCard extends StatelessWidget {
  const DessertCard({
    required String name,
    required String rating,
    required String shop,
    required String image,
  })  : _name = name,
        _rating = rating,
        _shop = shop,
        _image = image,
        super();

  final String _name;
  final String _rating;
  final String _shop;
  final String _image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: CachedNetworkImage(
              height: 180,fit: BoxFit.fitWidth,
              imageUrl: _image,
              placeholder: (context, url) => Image.asset(Helper.getAssetName("burger.png", "images")),
              errorWidget: (context, url, error) => Image.asset(Helper.getAssetName("burger.png", "images")),
            ),
          ),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.2),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 70,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name,
                    style: Helper.getTheme(context).headline4!.copyWith(color: Colors.white),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: CustomColors.primary),
                      const SizedBox(width: 5),
                      Text(
                        _rating,
                        style: TextStyle(color: CustomColors.primary),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _shop,
                        style: TextStyle(color: CustomColors.white),
                      ),
                      const SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(".", style: TextStyle(color: CustomColors.primary)),
                      ),
                      const SizedBox(width: 5)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}