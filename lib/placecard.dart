import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gradient_status_card.dart';
import 'models/place.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key? key,
    required this.place,
    required this.onPressed,
  }) : super(key: key);

  final TravelPlace place;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final statusTag = place.statusTag;
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: NetworkImage(place.imagesUrl.first),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black26, BlendMode.darken))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(place.user.urlPhoto),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.user.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'yesterday at 9:10 p.m.',
                      style: TextStyle(color: Colors.white70),
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ))
              ],
            ),
            Spacer(),
            Text(
              place.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GradientStatusTag(statusTag: statusTag),
            Spacer(),
            Row(
              children: [
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: StadiumBorder(),
                    ),
                    icon: Icon(CupertinoIcons.heart),
                    label: Text(place.likes.toString())),
                TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      shape: StadiumBorder(),
                    ),
                    icon: Icon(CupertinoIcons.reply),
                    label: Text(place.shared.toString()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
