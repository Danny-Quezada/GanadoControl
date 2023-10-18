


import 'package:flutter/material.dart';


import 'package:hackathon_app/provider/cattle_provider.dart';
import 'package:hackathon_app/provider/farm_provider.dart';
import 'package:hackathon_app/provider/flock_provider.dart';
import 'package:hackathon_app/provider/igeneric_provider.dart';
import 'package:hackathon_app/provider/meditation_provider.dart';
import 'package:hackathon_app/provider/treatment_provider.dart';
import 'package:hackathon_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ProviderNull{

  static providerNull(BuildContext context){
    Provider.of<UserProvider>(context,listen: false).user=null;
    Provider.of<CattleProvider>(context,listen: false).doNull();
     Provider.of<FarmProvider>(context,listen: false).doNull();
      Provider.of<MeditationProvider>(context,listen: false).doNull();
       Provider.of<TreatmentProvider>(context,listen: false).doNull();
        Provider.of<FlockProvider>(context,listen: false).doNull();
        Provider.of<FarmProvider>(context,listen: false).doNull();
  }
  
  
}