import 'package:ecosort/after_login.dart';
import 'package:ecosort/home_screen.dart';
import 'package:ecosort/pages/blog_list.dart';
import 'package:ecosort/pages/feedback_page.dart';
import 'package:ecosort/pages/home_page.dart';
import 'package:ecosort/provider/add_waste_provider.dart';
import 'package:ecosort/provider/signup_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import "package:ecosort/provider/login_provider.dart";
import 'dart:io';

import 'package:provider/provider.dart';

import '../provider/check_waste_provider.dart';
import '../provider/wastes_provider.dart';

class MyCamera extends StatefulWidget {
  final VoidCallback voidCallback;
  const MyCamera({Key? key, required this.voidCallback }) : super(key: key);

  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  bool loaded = false;
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
    final waste_provider = Provider.of<WastesProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    if(_image != null){
      add_waste_provider.saveTheImageLocal(_image!);
    }


    return ChangeNotifierProvider<CheckWasteProvider>(
    create: (_) => CheckWasteProvider(),
      builder: (context, _) {
        final check_waste_provider = Provider.of<CheckWasteProvider>(context);
        if(check_waste_provider.loading == false && check_waste_provider.catName != null){
          final cat = check_waste_provider.catName;
          // print(cat);
          final loginProvider = Provider.of<LoginProvider>(context);
          final signProvider = Provider.of<SignupProvider>(context);
          int id = loginProvider.userId != null ? loginProvider.userId! : signProvider.userId!;

            return Center(
              child: Container(
                height: 400,
                color: const Color.fromRGBO(107,125,92, 1.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,

                    children: <Widget>[

                      Text("Category is $cat!", style: const TextStyle(fontSize: 25, color: Colors.white),),
                      const SizedBox(
                        height: 80,
                      ),
                       Text('You have likelihood to get ${check_waste_provider.points} points', style: const TextStyle(fontSize: 18, color: Colors.white),),
                      const SizedBox(
                        height: 80,
                      ),
                      // ChangeNotifierProvider<AddWasteProvider>(
                      //   create: (_) => AddWasteProvider(),
                      //   builder: (context, _){
                      //     final add_waste_provider = Provider.of<AddWasteProvider>(context);
                           ElevatedButton(
                            child: add_waste_provider.loading == true ? const CircularProgressIndicator(): const Text("Dispose and Get Feedback", style: TextStyle(
                                color: Colors.black,
                                fontSize: 18
                            ),
                            ),
                            onPressed: () {

                              add_waste_provider.addWastes(nameController.text, descController.text, _image != null ? _image! : add_waste_provider.savedImage!, id, loginProvider.username ?? signProvider.username!);
                              waste_provider.getAllWastes();
                              if(check_waste_provider.loading == false && check_waste_provider.catName != null){
                                // widget.voidCallback();
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> BlogList()));
                              }
                            }

                              // print(add_waste_provider.loading);



                          )



                    ],
                  ),
                ),
              ),
            );
        }

        else {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  TextButton(
                    onPressed: showOptions,
                    child: Text(
                        _image == null ? 'Select Image' : "Select New Image"),
                  ),
                  Center(
                    child: _image == null
                        && add_waste_provider.savedImage == null ? const Text(
                        'No Image selected')
                        : Column(children: [

                      Image.file(_image != null ? _image! : add_waste_provider
                          .savedImage!),
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
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
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
                          return (value != null && value.contains('@'))
                              ? 'Do not use the @ char.'
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(onPressed: () {
                        int? id = loginProvider.userId;
                        if (nameController.text != "" &&
                            descController.text != "") {
                          check_waste_provider.checkWaste(
                              _image != null ? _image! : add_waste_provider
                                  .savedImage!);
                          //add_waste_provider.addWastes(nameController.text, descController.text, _image != null ? _image! : add_waste_provider.savedImage!, id!, loginProvider.username!);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (_) => const AfterLogin()),
                          // );
                          bool? done = check_waste_provider.loading;
                          // print(done);
                          // if(done == true){
                          //   // setState(() {
                          //   //   loaded = false;
                          //   // });
                          //   String? cat = check_waste_provider.catName;
                          //   print(check_waste_provider.loading);
                          //   // showModalBottomSheet<void>(
                          //   //   context: context,
                          //   //   builder: (BuildContext context) {
                          //   //     // return
                          //   //   },
                          //   // );
                          // }


                        }
                        else {
                          descriptionError = "The description field is empty";
                          wasteNameError = "The waste name field is empty";
                          setState() {

                          }
                        }
                      },
                        child: check_waste_provider.loading == true
                            ? const CircularProgressIndicator()
                            : const Text("Check The Waste", style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18
                        ),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
