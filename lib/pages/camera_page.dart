import 'package:ecosort/provider/add_waste_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import "package:ecosort/provider/login_provider.dart";
import 'dart:io';

import 'package:provider/provider.dart';

class MyCamera extends StatefulWidget {
  const MyCamera({Key? key}) : super(key: key);

  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  String descriptionError = "";
  String wasteNameError = "";
  // Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Show options to get image from camera or gallery
  Future showOptions() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final add_waste_provider = Provider.of<AddWasteProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    if(_image != null)
      add_waste_provider.saveTheImageLocal(_image!);

    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          TextButton(
            onPressed: showOptions,
            child: const Text('Select Image'),
          ),
          Center(
            child: _image == null
                && add_waste_provider.savedImage == null ? const Text('No Image selected')
                : Column(children: [

                  Image.file(_image != null ? _image! : add_waste_provider.savedImage!),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Waste Name',
                  labelText: 'Name *',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },
              ),
             const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'About Waste',
                  labelText: 'Description *',
                ),
                onSaved: (String? value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                },
                validator: (String? value) {
                  return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
                  ElevatedButton(onPressed: (){
                    int? id = loginProvider.userId;
                    if(nameController.text != "" && descController.text != ""){
                      add_waste_provider.addWastes(nameController.text, descController.text, _image != null ? _image! : add_waste_provider.savedImage!, id!, loginProvider.username!);
                    }
                    else{
                      descriptionError = "The description field is empty";
                      wasteNameError = "The waste name field is empty";
                      setState(){

                      }
                    }
                  },
                      child: const Text("Dispose")
                  )
            ]),
          ),
        ],
      ),
    );
  }
}
