import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';

class BigNewsCard extends StatelessWidget {
  const BigNewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 3.0.wp),
        padding: EdgeInsets.all(3.0.wp),
        width: 250,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://akm-img-a-in.tosshub.com/aajtak/images/story/202310/untitled_design_98-sixteen_nine.png?size=948:533",
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 2.0.hp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Entertainment".toUpperCase(), maxLines: 1),
                const Row(
                  children: [
                    Icon(
                      FluentSystemIcons.ic_fluent_clock_regular,
                      color: Colors.grey,
                      size: 14,
                    ),
                    Text("1hr argo"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.0.hp),
            Text(
              "Data breakdown: How to Ride Dips sdasdasdasdasdasdasdasdasdasdasdasdasdasdsadadasdadadasdasdasdasdasdasdasdasdasdasdasdasdas",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 12.0.sp,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
