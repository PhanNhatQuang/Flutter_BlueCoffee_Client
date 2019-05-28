import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/services.dart' show rootBundle;

import 'Model/MenuModel.dart';
import 'package:simple_permissions/simple_permissions.dart';

class FileHelper{
  static final String m_AppDataDir = '/storage/emulated/0/Android/data/com.BIP.BlueCoffee.Client';
  static MenuModel s_Menu;
  static bool allowWriteFile = false;   
  static bool allowReadFile = false;

  static Future get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final applicationDirectory = await path_provider.getApplicationDocumentsDirectory();
 
    // External storage directory: /storage/emulated/0
    final externalDirectory = await path_provider.getExternalStorageDirectory();
 
    // Application temporary directory: /data/user/0/{package_name}/cache
    final tempDirectory = await path_provider.getTemporaryDirectory();
 
    return applicationDirectory.path;
  }
static createDir() async {
  var dir = Directory(m_AppDataDir);
  bool dirExists = await dir.exists();
  if(!dirExists){
     dir.create(/*recursive=true*/); //pass recursive as true if directory is recursive
  }
  //Now you can use this directory for saving file, etc.
  //In case you are using external storage, make sure you have storage permissions.
}

static Future loadMenu() async {
  String jsonString = await _loadMenuFromFile();
  final jsonResponse = json.decode(jsonString);
  s_Menu = new MenuModel.fromJson(jsonResponse);
  print(s_Menu.toJson());
}


static Future<String> _loadMenuFromFile() async {
    return await rootBundle.loadString(m_AppDataDir + '/Menu.json');
}
static void createFile(Map<String, String> content) {
    print("Creating file!");
      File  jsonFile = new File(m_AppDataDir + "/" + "Menu.json");    
       jsonFile.createSync();
    jsonFile.writeAsStringSync(json.encode(content)); 
    print("Creating file done!");
  }

static requestWritePermission() async {
    PermissionStatus permissionwriteStatus = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    PermissionStatus permissionreadStatus = await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
 
    if (permissionwriteStatus == PermissionStatus.authorized) {
      allowWriteFile = true;
    }
    if (permissionreadStatus == PermissionStatus.authorized) {
      allowReadFile = true;
    }

  }


static Future get _localFile async {
      return File('$m_AppDataDir/Menu.json');
    }
static Future writeToFile(String text) async {
     
      final file = await _localFile;
  
      // Write the file
      File result = await file.writeAsString('$text');
  
      if (result == null ) {
        print("Writing to file failed");
      } else {
        print("Successfully writing to file");
 
        print("Reading the content of file");
        String readResult = await readFile();
        print("readResult: " + readResult.toString());
      }
    }

static Future readFile() async {
  try {
        final file = await _localFile;
        // Read the file
        return await file.readAsString();
      } catch (e) {
        // Return null if we encounter an error
        return null;
      }
    }

    static Future addFakeMenu() async {
      final _menu = '''
        [
          {
            "drinkID": 1,
            "drinkName": "Cà phê",
            "drinkImage": "caphe.jpg",
            "drinkPrice": 12222
          },
          {
            "drinkID": 2,
            "drinkName": "Nước cam",
            "drinkImage": "nuoccam.jpg",
            "drinkPrice": 17000
          },
          {
            "drinkID": 3,
            "drinkName": "Sinh tố bơ",
            "drinkImage": "stbo.jpg",
            "drinkPrice": 17000
          },
          {
            "drinkID": 4,
            "drinkName": "Kem",
            "drinkImage": "Kem.jpg",
            "drinkPrice": 17000
          },
          {
            "drinkID": 5,
            "drinkName": "Soda Blue",
            "drinkImage": "sodablue.jpg",
            "drinkPrice": 15000
          },
          {
            "drinkID": 6,
            "drinkName": "Sting",
            "drinkImage": "sting.jpg",
            "drinkPrice": 12000
          },
          {
            "drinkID": 7,
            "drinkName": "Bò húc",
            "drinkImage": "bohuc.jpg",
            "drinkPrice": 15000
          },
          {
            "drinkID": 8,
            "drinkName": "Nutri",
            "drinkImage": "nutri.jpg",
            "drinkPrice": 14000
          },
          {
            "drinkID": 9,
            "drinkName": "Sinh tố dâu",
            "drinkImage": "stdau.jpg",
            "drinkPrice": 14000
          }

        ]
        ''';
        await writeToFile(_menu);
    }
} 