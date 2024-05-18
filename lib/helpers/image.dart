import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication/models/user_model.dart';
import '../core/globals.dart' as globals;

Future<String> picImage() async{
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);

  return image != null ? image.path : '';
}

Future<bool> saveImage(String path, String name) async {
  try {
    var multipartFile = await MultipartFile.fromFile(path);

    var json = FormData.fromMap({
      'file': multipartFile,
    });


    await Dio().post(
        'http://${globals.ip}/images?name=${name}',
        data: json
    );

    return true;
  }
  catch (e){
    return false;
  }
}