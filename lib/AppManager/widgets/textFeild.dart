
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organic_delight/AppManager/appColors.dart';
import 'package:organic_delight/AppManager/appUtils.dart';



class TextFieldClass extends StatefulWidget {

  final String? hintText;
  final Widget? suffixIcon;
  final Icon? prefixIcon;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final int? maxLine;
  final int? maxLength;
  final bool? isPasswordField;
  final bool? enabled;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final InputDecoration? decoration;
  final ValueChanged? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;


  const TextFieldClass({Key? key, this.hintText, this.controller,
    this.isPasswordField,
  this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLength,
    this.enabled,
    this.textAlign,
    this.keyboardType,
    this.decoration,
    this.onChanged,
  this.maxLine,
    this.labelText,
    this.inputFormatters, this.textInputAction
  }) : super(key: key);
  
  @override
  _TextFieldClassState createState() => _TextFieldClassState();
}

class _TextFieldClassState extends State<TextFieldClass> {

  bool obscure=false;

  App app=App();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isPasswordField??false){
      obscure=widget.isPasswordField!;
      setState(() {

      });
    }
  }





  Widget build(BuildContext context) {
    return  TextFormField(
        textInputAction: TextInputAction.next,

        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled??true,
      controller: widget.controller,
      minLines: 1,
      maxLines: widget.maxLine?? 1,
      obscureText: widget.isPasswordField==null? false:obscure,
      maxLength: widget.maxLength??null,
      textAlign: widget.textAlign?? TextAlign.start,
      keyboardType: widget.keyboardType?? null,
        onChanged: widget.onChanged==null? null:(val){
          widget.onChanged!(val);
        },
      style: TextStyle(
        fontSize: 15,
      ),
      decoration: widget.decoration??InputDecoration(
        // counter: Container(),
        counterText: '',
        //contentPadding: widget.isPasswordField==null? EdgeInsets.all(5):widget.isPasswordField? EdgeInsets.fromLTRB(5,5,5,5):EdgeInsets.all(5),
        contentPadding: EdgeInsets.all(5),
        hintText: widget.hintText??null,
        hintStyle: TextStyle(
          fontSize: 15,
        ),


        labelText: widget.labelText??null,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey
        ),
        errorStyle: TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon:  (widget.isPasswordField==null || widget.isPasswordField==false)? widget.suffixIcon??null:IconButton(
          splashRadius: 5,
          icon: obscure? Icon(Icons.visibility_off,
        color: AppColor.lightThemeColor,)
                : Icon(Icons.visibility,
        color: Colors.grey.shade200,),
        onPressed: (){
          setState(() {
            obscure=!obscure;
          });

        },),

        fillColor: Colors.transparent,
        // focusedBorder: UnderlineInputBorder(
        //   borderSide: BorderSide(
        //     color: AppColor.lightThemeColor,
        //     width: 2
        //   )
        // ),
        // border: UnderlineInputBorder(
        //     borderSide: BorderSide(
        //         color: AppColor.customBlack,
        //         width: 2
        //     )
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
              color: Colors.red,
              width: 1
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 1
          ),
        ),
      ),
      validator: widget.validator
    );
  }
}


