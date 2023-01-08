
import 'package:flutter/material.dart';


class CustomSnackBar extends SnackBar{
 
 CustomSnackBar(
  {Key? key, 
  String btnLabel='Ok',
  VoidCallback? onOk,
  required String message, 
  Duration duration= const Duration(seconds: 2)})

  : super(
    key: key,
     content: Text(message), 
     duration:duration,
     action: SnackBarAction(
            label: btnLabel, 
            onPressed: (){ 
              if(onOk != null){
                onOk();
              }
             }) 
            
    );


 



}