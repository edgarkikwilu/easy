import 'package:easy_client/Helper/CustomTheme.dart';
import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({
    required String name,
    required int rating,
    required Image image,
  })  : _image = image,
        _name = name,
        _rating = rating;

  final String _name;
  final int _rating;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          SizedBox(height: 150, width: double.infinity, child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _image,
          )),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _name,
                      style: Theme.of(context).textTheme.bodyText1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.star,color: CustomColors.primary, size: 13),
                    const SizedBox(width: 5,),
                    Text("$_rating",
                      style: Theme.of(context).textTheme.caption!.copyWith(color: CustomColors.primary),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(fontWeight: FontWeight.w900,color: CustomColors.dark)
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // Text(_vendor,style: Theme.of(context).textTheme.caption),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}