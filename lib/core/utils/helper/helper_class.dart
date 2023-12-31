import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/action_sheet.dart';
import 'loading_helper.dart';

class HelperClass {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> _pickImage(ImageSource source) async {
    try {
      LoadingHelper.showLoading();
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      LoadingHelper.hideLoading();
      return pickedFile;
    } catch (e) {
      LoadingHelper.hideLoading();
      return null;
    }
  }

  Future<XFile?> bottomSheetImagePicker(BuildContext context) async {
    XFile? file;
    await showAdaptiveActionSheet(
      context: context,
      title: const Text('Profile photo'),
      androidBorderRadius: 30,
      actions: [
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: () async {
              file = await _pickImage(ImageSource.gallery);
              Get.back();
            }),
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: () async {
              file = await _pickImage(ImageSource.camera);
              Get.back();
            }),
      ],
      cancelAction: CancelAction(title: const Text('Cancel')),
    );
    return file;
  }
}
