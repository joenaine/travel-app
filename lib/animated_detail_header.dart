import 'dart:ui';

import 'package:animawidget/gradient_status_card.dart';
import 'package:animawidget/place_images_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/place.dart';

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader({
    Key? key,
    required this.place,
    required this.topPercent,
    required this.bottomPercent,
  }) : super(key: key);

  final TravelPlace place;
  final double topPercent;
  final double bottomPercent;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final imagesUrl = place.imagesUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: place.id,
          child: Material(
            child: ClipRect(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: (20 + topPadding) * (1 - bottomPercent),
                      bottom: 160 * (1 - bottomPercent),
                    ),
                    child: Transform.scale(
                      scale: lerpDouble(1, 1.3, bottomPercent)!,
                      child: PlaceImagesPageView(
                        imagesUrl: imagesUrl,
                        place: place,
                      ),
                    ),
                  ),
                  Positioned(
                      top: topPadding,
                      left: -60 * (1 - bottomPercent),
                      child: BackButton(
                        color: Colors.white,
                      )),
                  Positioned(
                      top: topPadding,
                      right: -60 * (1 - bottomPercent),
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          ))),
                  Positioned(
                    top: lerpDouble(-30, 140, topPercent)!
                        .clamp(topPadding + 10, 140),
                    left: lerpDouble(60, 20, topPercent)!.clamp(20, 50),
                    right: 20,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 800),
                      opacity: bottomPercent < 1 ? 0 : 1,
                      child: Text(
                        place.name,
                        style: TextStyle(
                          fontSize: lerpDouble(20, 40, topPercent),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 20,
                      top: 200,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 800),
                        opacity: bottomPercent < 1 ? 0 : 1,
                        child: Opacity(
                          opacity: topPercent,
                          child: GradientStatusTag(
                            statusTag: place.statusTag,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: null,
          bottom: -140 * (1 - topPercent),
          child: TranslateAnimation(
            child: _LikesAndSharesContainer(place: place),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(color: Colors.white, height: 10),
        ),
        Positioned.fill(
            top: null,
            child: TranslateAnimation(
              child: _UserInfoContainer(place: place),
            ))
      ],
    );
  }
}

class TranslateAnimation extends StatelessWidget {
  const TranslateAnimation({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 100 * value),
          child: child,
        );
      },
      child: child,
    );
  }
}

class _UserInfoContainer extends StatelessWidget {
  const _UserInfoContainer({
    Key? key,
    required this.place,
  }) : super(key: key);

  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(place.user.urlPhoto),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                place.user.name,
                style: TextStyle(color: Colors.black),
              ),
              Text(
                'yesterday at 9:10 p.m.',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Spacer(),
          TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.blue.shade600,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: Text('+Follow')),
        ],
      ),
    );
  }
}

class _LikesAndSharesContainer extends StatelessWidget {
  const _LikesAndSharesContainer({
    Key? key,
    required this.place,
  }) : super(key: key);

  final TravelPlace place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                shape: StadiumBorder(),
              ),
              icon: Icon(CupertinoIcons.heart, size: 26),
              label: Text(place.likes.toString())),
          TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                shape: StadiumBorder(),
              ),
              icon: Icon(CupertinoIcons.reply, size: 26),
              label: Text(place.shared.toString())),
          Spacer(),
          TextButton.icon(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                primary: Colors.blue.shade600,
                textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              icon: Icon(
                Icons.check_circle_outlined,
                size: 26,
              ),
              label: Text('Check in')),
        ],
      ),
    );
  }
}
