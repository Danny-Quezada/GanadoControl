import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';


class DateTimePicker extends StatelessWidget {

  Size size;
  double radius;
  Color color;
  String text;
  IconData? icon;
  DateTime date;
  DateTimePicker ({this.radius=31,this.icon=Icons.calendar_month_outlined,required this.color,required this.text,required this.size,required this.date});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ()=>_selectDate(context),
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border:Border.all(color: color!, width: 2)
        ),
        child: Row(
          children: [
            const SizedBox(width: 20,),
            Icon(icon,color: color!,),
            const SizedBox(width: 20,),
            Text(text,style: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),)
          ],
        ),
      ),
    );
  }
   Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        onDatePickerModeChange: (DatePickerEntryMode value){
          
        },
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
        
    if (picked != null && picked != date) {
      date = picked;
    }
  }
}