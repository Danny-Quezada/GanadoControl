import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:intl/intl.dart';


class DateTimePicker extends StatefulWidget {
 TextEditingController dateTimeController;
  Size size;
  double radius;
  Color color;
  String? text;
  IconData? icon;

  DateTimePicker ({this.radius=31,this.icon=Icons.calendar_month_outlined,required this.color,this.text,required this.size,required this.dateTimeController});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ()=>_selectDate(context),
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          border:Border.all(color: widget.color!, width: 2)
        ),
        child: Row(
          children: [
            const SizedBox(width: 20,),
            Icon(widget.icon,color: widget.color!,),
            const SizedBox(width: 20,),
            Text(widget.text ?? DateFormat('EEE, M/d/y').format(date),style: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),)
          ],
        ),
      ),
    );
  }
DateTime date=DateTime.now();
   Future<void> _selectDate(BuildContext context) async {
    
    final DateTime? picked = await showDatePicker(
        context: context,

         
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
        
    if (picked != null && picked !=date) {
     
      setState(() {
         date = picked;
         widget.dateTimeController.text=date.toString();
      });
    }
  }
}