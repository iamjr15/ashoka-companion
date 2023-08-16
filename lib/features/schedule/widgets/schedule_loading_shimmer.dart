import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';


/// This is the shimmer widget we are using inside the schedule widget,
/// just to depict the skeleton of the Schedules Widget when the page is in loading state.

class ShimmerWidget extends StatelessWidget {
  final Duration duration;
  final Color baseColor;
  final double width;
  final double height;
  final Color highlightColor;

  ShimmerWidget({
    this.duration = const Duration(milliseconds: 1500),
    this.baseColor = Colors.grey,
    this.width = double.infinity,
    this.height = double.infinity,
    this.highlightColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 160.h,),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            period: duration,
            child: Container(
              width: 60.w,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          SizedBox(
            width: 420.w,
            height: 120.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (BuildContext context,  int index) {

                return Container(
                  margin: EdgeInsets.only(right: 20.w),
                  child: Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    period: duration,
                    child: Container(
                      width: 70.w,
                      height: 105.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30.h,),
          SizedBox(
            width: 420.w,
            height: 454.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              itemBuilder: (BuildContext context,  int index) {

                return Container(
                  margin: EdgeInsets.only(right: 30.w),
                  child: Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    period: duration,
                    child: Container(
                      width: 283.w,
                      height: 454.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );




  }
}
