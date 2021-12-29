import 'package:flutter/material.dart';

import 'models/place.dart';

class PlaceImagesPageView extends StatefulWidget {
  const PlaceImagesPageView({
    Key? key,
    required this.imagesUrl,
    required this.place,
  }) : super(key: key);

  final List<String> imagesUrl;
  final TravelPlace place;

  @override
  _PlaceImagesPageViewState createState() => _PlaceImagesPageViewState();
}

class _PlaceImagesPageViewState extends State<PlaceImagesPageView> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.imagesUrl.length,
            onPageChanged: (value) {
              setState(() => currentIndex = value);
            },
            physics: BouncingScrollPhysics(),
            controller: PageController(viewportFraction: .9),
            
            itemBuilder: (context, index) {
              final imageUrl = widget.place.imagesUrl[index];
              final isSelected = currentIndex == index;
              return AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: isSelected ? 5 : 20,
                  bottom: isSelected ? 5 : 20,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.darken)),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imagesUrl.length,
            (index) {
              final isSelected = currentIndex == index;
              return AnimatedContainer(
                duration: Duration(milliseconds: 800),
                margin: EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black38 : Colors.black12,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: isSelected ? 4 : 3,
                width:  isSelected ? 20 : 10,
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
