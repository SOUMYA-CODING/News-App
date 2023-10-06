import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:frontend_app/constants/extension.dart';

class SmallNewsCard extends StatelessWidget {
  const SmallNewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 2.0.hp),
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "https://akm-img-a-in.tosshub.com/aajtak/images/story/202310/untitled_design_98-sixteen_nine.png?size=948:533",
                  fit: BoxFit.cover,
                  height: 100,
                ),
              ),
            ),
            SizedBox(width: 2.0.wp),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Entertainment".toUpperCase(), maxLines: 1),
                  SizedBox(height: 2.0.hp),
                  Text(
                    "Data breakdown: How to Ride Dips sdasdasdasdasdasdasdasdasdasdasdasda",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 12.0.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.hp),
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
            ),
          ],
        ),
      ),
    );
  }
}
