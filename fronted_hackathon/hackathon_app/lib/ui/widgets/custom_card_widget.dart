import 'package:flutter/material.dart';


class CustomCardWdiget extends StatelessWidget {

  String urlImage;
  String title;
  String description;
  List<String>? labelChip;
  VoidCallback function;
  double radius;
   CustomCardWdiget(this.labelChip,{required this.function,required this.urlImage,required this.title, required this.description,required this.radius});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
    
          width: size.width,
          height: size.height*.159,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: Colors.grey.shade300,width: 2)
          ),
          alignment: Alignment.center,
          child: Row(
           
            children: [
              const SizedBox(width: 8,),
              Container(
                padding:const  EdgeInsets.all(10),
                height: size.height*.12,
                width: size.width*.2,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.all(Radius.circular(radius-6))
              ),
              ),
              SizedBox(width: size.width*.03,),
              Container(
                padding: const EdgeInsets.only(top: 10,),
               
                 height: size.height*.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style:const TextStyle(fontWeight: FontWeight.bold)),
                    Text(description,style: const TextStyle(fontSize: 12)),
                    chips()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget chips(){
    List<Color> colors=[Colors.pink.shade200,Colors.blueGrey.shade300];

    if(labelChip==null){
      return Container();
    }
    List<Widget> chips=[];
    for(int i=0; i<labelChip!.length;i++){
      chips.add(Padding(padding: const EdgeInsets.all(1),child: Chip(label: Text(labelChip![i],style:const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),backgroundColor: colors[i],)));
    }
    return Row(
      children: chips,
    );
  }
}