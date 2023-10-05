import 'package:flutter/material.dart';
import 'package:frontend_app/constants/colors.dart';
import 'package:frontend_app/constants/extension.dart';

class BreakingNewsCard extends StatelessWidget {
  const BreakingNewsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: ENColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(3.0.wp),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Breaking News".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0.sp,
                        color: Colors.white,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 1.0.hp),
                    const Text(
                      "Data breakdown: How to Ride Dips sdasdasdasdasdasdasdasdasdasdasdasdasdasdsadadasdadadasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdsadadasdadadasdasda",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 3.0.wp),
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
            ],
          ),
        ),
      ),
    );
  }
}
