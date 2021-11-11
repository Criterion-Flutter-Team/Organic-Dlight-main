


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Common{



  shimmerEffect({
    required bool shimmer,
    required Widget child,
  }){
    return (shimmer)? Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: child
    ):child;
  }



}