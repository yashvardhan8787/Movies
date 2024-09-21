import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListviewShimmer extends StatelessWidget {
  const ListviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6, // Number of shimmer cards
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white70,
            child: Container(
              width: 150, // Width of each shimmer card
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}

