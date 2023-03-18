// ignore_for_file: non_constant_identifier_names
import "json_dart.dart";
// import "dart:convert";

import "dependencies_extra.dart";


class Dependencies extends JsonDart {

  
  Dependencies(super.rawData);
   
  static Map get defaultData {
    return {"@type":"dependencies","flutter":{"@type":"dependencies_extra","sdk":"flutter"},"cupertino_icons":"^1.0.2","bitsdojo_window":"^0.1.5"};
  }

  
  String? get special_type {
    try {
      if (rawData["@type"] is String == false){
        return null;
      }
      return rawData["@type"] as String;
    } catch (e) {
      return null;
    }
  }


  
  DependenciesExtra get flutter {
    try {
      if (rawData["flutter"] is Map == false){
        return DependenciesExtra({}); 
      }
      return DependenciesExtra(rawData["flutter"] as Map);
    } catch (e) {  
      return DependenciesExtra({}); 
    }
  }


  
  String? get cupertino_icons {
    try {
      if (rawData["cupertino_icons"] is String == false){
        return null;
      }
      return rawData["cupertino_icons"] as String;
    } catch (e) {
      return null;
    }
  }


  
  String? get bitsdojo_window {
    try {
      if (rawData["bitsdojo_window"] is String == false){
        return null;
      }
      return rawData["bitsdojo_window"] as String;
    } catch (e) {
      return null;
    }
  }


  
  static Dependencies create({

    String? special_type,
      DependenciesExtra? flutter,
    String? cupertino_icons,
    String? bitsdojo_window,
})  {
    Dependencies dependencies = Dependencies({
  
      "@type": special_type,
      "flutter": (flutter != null)?flutter.toJson(): null,
      "cupertino_icons": cupertino_icons,
      "bitsdojo_window": bitsdojo_window,


  });


return dependencies;

      }
}