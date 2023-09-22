import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageManger {

	static uploadImage() async {
    final firebaseStorage = FirebaseStorage.instance;
    File? image;
		      //Select Image
			final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 100
          );
          if( pickedFile == null ) {
            return null;
          }

  		image = File.fromUri( Uri(path: pickedFile.path));

      // ignore: unnecessary_null_comparison
      if (image.path != null){
        //Upload to Firebase
        var snapshot = await firebaseStorage.ref()
        .child('images/imageName')
        .putFile(image);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        return downloadUrl;

      } else {
				return null;
      }
  }

}

