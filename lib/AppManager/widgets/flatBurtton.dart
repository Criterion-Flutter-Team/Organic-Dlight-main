
import 'package:flutter/material.dart';
import 'package:organic_delight/AppManager/appUtils.dart';

import '../appColors.dart';


class FlatBtn extends StatefulWidget {

  final String title;
  final double? height;
  final double? width;
  final Function onPress;
  final Color? color;

  const FlatBtn({Key? key, required this.title, required this.onPress,
    this.color,
  this.height,
  this.width}) : super(key: key);
  

  @override
  _FlatBtnState createState() => _FlatBtnState();
}

class _FlatBtnState extends State<FlatBtn> {

  App app=App();



  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width!=null ? widget.width: null,
      height: widget.height!=null? widget.height:40.0,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          backgroundColor: widget.color??AppColor.lightThemeColor,
        ),
          onPressed: (){
            widget.onPress();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),),
            ],
          )
      ),
    );
  }
}


