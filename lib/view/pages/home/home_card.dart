import 'package:flutter/material.dart';

import '../../../const/color_constants.dart';

class HomeCard extends StatelessWidget {
  final Color color;
  final String title;
  final String description;
  final IconData icon;
  final Function() onTap;

  HomeCard({
    required this.color,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 10,
          right: 12,
        ),
        height: 160,
        width: screenWidth * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container (
                      width: MediaQuery.of(context).size.width*0.5,
                      child: new Column (
                        children: <Widget>[
                          Text(
                            "${description}",
                            maxLines: 4,
                            style: TextStyle(
                              color: ColorConstants.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              bottom: 10,
              child: Icon(icon, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
