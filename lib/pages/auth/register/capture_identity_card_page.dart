import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../components/c_elevated_button.dart';
import '../../../utils/constants.dart';
import '../../../utils/routes.dart';

class CaptureIdentityCardPage extends StatefulWidget {
  const CaptureIdentityCardPage({Key? key}) : super(key: key);

  @override
  State<CaptureIdentityCardPage> createState() => _CaptureIdentityCardPageState();
}

class _CaptureIdentityCardPageState extends State<CaptureIdentityCardPage> {
  File? _capturedImage;
  bool success = false;
  bool failed = false;
  bool _isLoading = false;

  Future<void> _captureImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.getImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _capturedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _upload() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
    );
    if (imageFile == null) {
      return;
    }
    setState(() => _isLoading = true);

    try {
      final bytes = await imageFile.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await Supabase.instance.client.storage.from('nationalidcard').uploadBinary(
        filePath,
        bytes,
        fileOptions: FileOptions(contentType: imageFile.mimeType),
      );
      final imageUrlResponse = await Supabase.instance.client.storage
          .from('nationalidcard')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      _onUpload(imageUrlResponse);
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }

    setState(() => _isLoading = false);
  }

  Future<void> _onUpload(String imageUrl) async {
    // Your logic to handle the uploaded image URL
    // This method is called when the image has been uploaded successfully
    setState(() {
      _capturedImage = File(imageUrl);
    });

    // Navigate to the next page after successful upload
    Navigator.of(context).pushNamed(RouteGenerator.registerFingerprintUnlockPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                  color: primaryColor,
                ),
              ),
              Text(
                'Step 2 of 4',
                style: smallTextStyle,
              ),
            ],
          ),
          SizedBox(height: 136.h),
          Center(
            child: Column(
              children: [
                Text(
                  'Take a Picture of your\nIdentity card',
                  style: largeTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  'Take a full picture of your ID card',
                  style: xSmallTextStyle,
                ),
                SizedBox(height: 52.h),
                SizedBox(
                  height: 206.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      if (_capturedImage != null)
                        Image.file(
                          _capturedImage!,
                          fit: BoxFit.cover,
                        ), // Display captured image
                      SvgPicture.asset('assets/svg/scan_image.svg'), // Placeholder image
                      if (success)
                        SvgPicture.asset('assets/svg/success_icon.svg'),
                      if (failed)
                        SvgPicture.asset('assets/svg/failed_icon.svg'),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                success
                    ? Text(
                  'Registration is successful, you can proceed\nto the next step',
                  style: xSmallTextStyle,
                  textAlign: TextAlign.center,
                )
                    : failed
                    ? Text(
                  'Registration failed, try again or try to clean\nyour finger',
                  style: xSmallTextStyle,
                  textAlign: TextAlign.center,
                )
                    : const Text(''),
                SizedBox(height: 20.h),
                Container(
                  color: Colors.green,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    onPressed: _isLoading
                          ? null
                          : () async {
                        await _upload();
                      },
                      child: _isLoading
                          ? const Text('Uploading...')
                          : success
                          ? const Text('Continue')
                          : failed
                          ? const Text('Retry')
                          : const Text('Take Picture'),
                    ),

                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
