import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_padeel/constants/app_colors.dart';
import 'package:i_padeel/utils/show_dialog.dart';
import 'package:i_padeel/widgets/custom_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Function(File) pickedImage;
  final File? oldPickedImage;
  const CustomImagePicker(
      {Key? key, this.oldPickedImage, required this.pickedImage})
      : super(key: key);

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _pickedImage;

  @override
  void initState() {
    _pickedImage = widget.oldPickedImage;
    super.initState();
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
      );
      setState(() {
        if (pickedFile == null) return;
        _pickedImage = File(pickedFile.path);
        widget.pickedImage(_pickedImage!);
      });
    } catch (e) {
      setState(() {
        ShowDialogHelper.showDialogPopup(
          'Wrong',
          'Something went wrong while picking the image',
          context,
          () => Navigator.of(context).pop(),
        );
      });
    }
  }

  Widget _displayModalBottomSheetItems() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: const Text(
            'Select Source',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Ubuntu',
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.camera),
                SizedBox(width: 8),
                Text(
                  'Camera',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              _onImageButtonPressed(ImageSource.camera);
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image),
                SizedBox(width: 8),
                Text(
                  'Gallery',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Ubuntu',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              _onImageButtonPressed(ImageSource.gallery);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          CustomBottomSheet.displayModalBottomSheet(
            context: context,
            items: [_displayModalBottomSheetItems()],
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
                radius: deviceWidth / 8,
                backgroundColor: AppColors.secondaryColor,
                foregroundImage: _pickedImage == null
                    ? null
                    : Image.file(
                        File(_pickedImage!.path),
                        fit: BoxFit.cover,
                      ).image,
                child: Icon(
                  Icons.camera_enhance,
                  color: Colors.black,
                  size: deviceWidth / 10,
                )),
            _pickedImage == null
                ? Container()
                : Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _pickedImage = null;
                          });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                  ),
          ],
        ),
      ),
    );
  }
}
