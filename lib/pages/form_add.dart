import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gt_mapbox/pages/location_add.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../models/map_marker_model.dart';
import '../validator/validator.dart';
import '../widgets/textfield.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({Key? key}) : super(key: key);

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController ownerController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  LatLng? location;
  File? imagePicked;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 26.0),
                  const Text(
                    'Tambah Sumur Resapan',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  KTextField(
                    isDense: true,
                    maxLines: 1,
                    borderRadius: 8.0,
                    controller: titleController,
                    borderColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    placeholder: 'Nama Sumur',
                    placeholderStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    validator: Validator.requiredValidator,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Masukan nama sumur',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  KTextField(
                    isDense: true,
                    maxLines: 1,
                    borderRadius: 8.0,
                    controller: ownerController,
                    borderColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    placeholder: 'Nama Owner',
                    placeholderStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    validator: Validator.requiredValidator,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Masukan nama owner',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  KTextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LocationAdd(
                            locationData: location,
                          ),
                        ),
                      ).then((value) {
                        location = value;
                        locationController.text = value.toString();
                      });
                    },
                    isOption: true,
                    isDense: true,
                    maxLines: 1,
                    borderRadius: 8.0,
                    controller: locationController,
                    borderColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    placeholder: 'Lokasi',
                    placeholderStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    validator: Validator.requiredValidator,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Masukan lokasi',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  KTextField(
                    isDense: true,
                    maxLines: null,
                    minLines: 6,
                    borderRadius: 8.0,
                    controller: addressController,
                    borderColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    backgroundColor: Colors.white.withOpacity(0.8),
                    placeholder: 'Alamat',
                    placeholderStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    validator: Validator.requiredValidator,
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Masukan alamat',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  imagePicked != null
                      ? SizedBox(
                          width: double.infinity,
                          height: 110.0,
                          child: Image.file(
                            imagePicked!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            onImageButtonPressed();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  ClipOval(
                                    child: Container(
                                      color: Colors.black,
                                      child: const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  const Text(
                                    'Lampirkan Foto',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: const [
                      Icon(
                        Icons.info_outline,
                        color: Colors.black,
                        size: 16.0,
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Ambil gambar langsung dari kamera',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 36,
                        width: 165,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Kembali',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 36,
                        width: 165,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.currentState!.validate()) {
                              addData();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Tambah',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onImageButtonPressed() async {
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
      final File toFile = File(pickedFile?.path ?? '');
      if (pickedFile != null) {
        setState(() {
          imagePicked = toFile;
        });
      }
      imageCache.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal')),
      );
    }
  }

  void addData() async {
    final int random = Random().nextInt(4) + 1;
    var data = MapMarker(
      title: titleController.text,
      address: addressController.text,
      image: 'assets/images/restaurant_$random.jpg',
      owner: ownerController.text,
      location: location,
    );
    Navigator.pop(context, data);
  }
}
