import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorageService with ChangeNotifier {
  // firebase storage
  final firebaseStorage = FirebaseStorage.instance;

  // images stored in dataabase as download urls
  List<String> _imageUrls = [];

  // loading status
  bool _isLoading = false;

  // uploading status
  bool _isUploading = false;

  // getters
  List<String> get imageUrls => _imageUrls;
  bool get isLoading => _isLoading;
  bool get isUploading => _isUploading;

  // read images
  Future<void> fetchImages() async {
    // start loading
    _isLoading = true;

    // get list under uploaded_images/ directory
    final ListResult result =
        await firebaseStorage.ref("uploaded_images/").listAll();

    final urls =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));

    // update urls
    _imageUrls = urls;

    // loading finished
    _isLoading = false;

    // update UI
    notifyListeners();
  }

  // images are stored as download urls
  // e.g  https://firebasestrorage.googleapis.com/v0/b/fir-masterclass.../uploaded_images/image_name.png
  // to delete, we only need the path of this image stored in firebase
  // i.e uploaded_images/image_name.png

  // delete photo
  Future<void> deleteImage(String imageUrl) async {
    try {
      // remove from the local list
      _imageUrls.remove(imageUrl);

      // get path name and remove from firebase
      final String path = extractPathFromUrl(imageUrl);
      // delete image
      await firebaseStorage.ref(path).delete();
    }
    // handle errors
    catch (e) {
      print("Error deleting message: $e");
    }
    // update ui
    notifyListeners();
  }

// extract path from a given url
  String extractPathFromUrl(String url) {
    Uri uri = Uri.parse(url);

    // extract path of url we need
    String encodedPath = uri.pathSegments.last;

    // url decoding the path
    return Uri.decodeComponent(encodedPath);
  }

  // upload
  Future<void> uploadImage() async {
    // start upload
    _isUploading = true;
    notifyListeners();

    final ImagePicker imagePicker = ImagePicker();

    // image from gallery
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    notifyListeners();

    if (image == null) {
      _isUploading = false;
      notifyListeners();
      return; // user cancelled the picker
    }

    File file = File(image.path);

    try {
      // define path in storage
      String filePath = "uploaded_images/${DateTime.now()}.png";

      // upload the file to firebase storage
      await firebaseStorage.ref(filePath).putFile(file);

      // fetch download url after uploading...
      String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();

      // update imageUrls
      _imageUrls.add(downloadUrl);
      notifyListeners();
    } catch (e) {
      print("Error uploading message: $e");
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
