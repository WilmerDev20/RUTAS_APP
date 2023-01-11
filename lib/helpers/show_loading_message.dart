

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoadingMessage(BuildContext context){

 (Platform.isAndroid)



  ?showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text('Espere porfavor'),
      content: Container(
        margin: EdgeInsets.only(top: 10),
        width: 100,
        height: 100,
        child: Column(
          children: const [
            Text('Calculando Ruta'),
            SizedBox(height: 15,),
            CircularProgressIndicator(strokeWidth: 3, color: Colors.black,)
          ],
        ),
      ),
    ),)
    : showCupertinoDialog(
      context: context, 
      barrierDismissible: false,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Espere Por Favor'),
        content: CupertinoActivityIndicator(),
      ),);
}