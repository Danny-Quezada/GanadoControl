import 'package:flutter/material.dart';
import 'package:hackathon_app/ui/config/color_palette.dart';
import 'package:intl/intl.dart';


class TimePicker extends StatefulWidget {
 TextEditingController timeController;
  Size size;
  double radius;
  Color color;
  String? text;
  IconData? icon;

  TimePicker ({this.radius=31,this.icon=Icons.timer,required this.color,this.text,required this.size,required this.timeController});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: ()=>_selectTime(context),
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
            Text(widget.text ?? time.format(context),style: TextStyle(color: ColorPalette.colorFontTextFieldPrincipal),)
          ],
        ),
      ),
    );
  }
TimeOfDay time=TimeOfDay.now();
   Future<void> _selectTime(BuildContext context) async {
    
    final TimeOfDay? picked = await showTimePicker(
        context: context,

       initialTime: TimeOfDay.now());
        
    if (picked != null && picked !=time) {
     
      setState(() {
         time= picked;
         widget.timeController.text=time.format(context);
      });
    }
  }
  
}