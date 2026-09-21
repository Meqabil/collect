import 'package:collect/view/widgets/onboarding/dot.dart';
import 'package:flutter/material.dart';

class OnBoardingDots extends StatelessWidget {
  const OnBoardingDots({super.key,required this.pageNum});
  final int pageNum;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dot(width: 12, pageNum: pageNum,idx: 0,),
          Dot(width: 12, pageNum: pageNum,idx: 1,),
          Dot(width: 12, pageNum: pageNum,idx: 2,),
        ],
      ),
    );
  }
}
