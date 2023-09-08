
import 'dart:io';
import 'package:gojek_university_app/commons/common_imports/common_libs.dart';
import 'package:gojek_university_app/commons/common_widgets/show_toast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickChatImageFromGallery(BuildContext context) async {
  File? image;
  try{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedImage!=null){
      image= File(pickedImage.path);
    }
  }catch(e){
    showSnackBar(context,e.toString());
  }

  return image;
}


Future<File?> pickVideoFromGallery(BuildContext context) async {
  File? video;
  try{
    final pickedVideo = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if(pickedVideo!=null){
      video= File(pickedVideo.path);
    }
  }catch(e){
    showSnackBar( context, e.toString());
  }

  return video;
}
