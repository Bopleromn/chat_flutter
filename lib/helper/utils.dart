import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async{
final ImagePicker _ImagePicker = ImagePicker();
XFile? file = await _ImagePicker.pickImage(source: source);
if(file != null){
  return file.readAsBytes();
}
}