import 'package:flutter/material.dart';
import 'package:pet_perfect_app/utils/border_radius_helpers.dart';
import 'package:pet_perfect_app/utils/color_helpers.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    Key key,
    this.hintText,
    this.labelText,
    this.isEditable,
    this.textEditingController,
    this.onChanged,
    this.suffixIcon,
  }) : super(key: key);
  final String hintText, labelText;
  final TextEditingController textEditingController;
  final bool isEditable;
  final Function onChanged;
  final Widget suffixIcon;

  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10),
      child: Column(
        children: [
          Container(
            decoration: kBoxDecoration(color: kTextFieldColor),
            child: TextField(
                enabled: isEditable,
                enableInteractiveSelection: true,
                autofocus: false,
                controller: textEditingController,
                // onSubmitted: onChanged,
                onChanged: onChanged,
                decoration: InputDecoration(
                  focusColor: primaryTextColor,
                  labelText: labelText,
                  hintText: hintText,
                  suffixIcon: suffixIcon ?? null,
                  labelStyle: TextStyle(height: -1),
                  border: InputBorder.none,
                )),
          ),
          
        Divider(color: Colors.black12,)
        ],
      ),
    );
  }
}
