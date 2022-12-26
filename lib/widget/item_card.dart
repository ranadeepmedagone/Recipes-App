import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.strMeal,
      required this.strMealThumb,
      required this.icon,
      required this.onTap
      // required this.image,
      })
      : super(key: key);

  final IconButton icon;
  final String strMeal;
  final String strMealThumb;
  final Function onTap;
  // final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 10,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      
      // color: ColorConstants.blue,
      child: Center(
        child: ListTile(
          onTap: () => onTap(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: 6,
            ),
            child: Text(
              strMeal,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: Colors.black26,
            backgroundImage: NetworkImage(strMealThumb, scale: 4.0),
            radius: 35,
          ),
          trailing: icon,
        ),
      ),
    );
  }
}
