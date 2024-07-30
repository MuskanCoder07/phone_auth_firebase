import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin class FireSarviceClass{
  viewTextField(TextEditingController controller,String hintTexts,Icon prefixIcon, String lableTexts){
    return Padding(padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            hintText: hintTexts,
            prefixIcon: prefixIcon,
            labelText: lableTexts
        ),
      ),
    );
  }
}