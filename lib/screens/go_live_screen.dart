import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitch_clone_final/Utills/utills.dart';
import 'package:flutter_twitch_clone_final/resources/firestore_methods.dart';
import 'package:flutter_twitch_clone_final/responsive/responsive.dart';
import 'package:flutter_twitch_clone_final/screens/broadcast%20screen.dart';
import 'package:flutter_twitch_clone_final/widgets/custom_button.dart';
import 'package:flutter_twitch_clone_final/widgets/customtextfield.dart';

import '../Utills/colors.dart';


class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {

  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;

  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream()async{
String channelId = await FirestoreMethods().startLiveStream(context, _titleController.text, image);
if(channelId.isNotEmpty){
 showSnackBar(context, "LiveStream Has Started Succesfully");
 Navigator.of(context).push(MaterialPageRoute(builder: (context) => BroadCastScreen(
   isBroadcaster: true,
   channelId: channelId,
 )));
}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Responsive(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(
              children: [
                GestureDetector(
                  onTap:()async{
                    Uint8List? pickedImage = await pickImage();
                    if(pickedImage  != null)
                      {
                        setState(() {
                          image = pickedImage;
                        });
                      }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical: 20.0),
                    child: image!=null?SizedBox(height: 300,child: Image.memory(image!)):DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const[10,4],
                        strokeCap: StrokeCap.round,
                        color: buttonColor,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                            color: buttonColor.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.folder_open,color: buttonColor,size: 40,),
                              const SizedBox(height: 15,),
                              Text("Select Your Thumbnail",style: TextStyle(fontSize: 15,color: Colors.grey.shade400),)
                            ],
                          ),

                        )),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Title",style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.00),
                      child: CustomTextField(controller: _titleController,),
                    )
                  ],
                )
              ],
            ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CustomButton(
                  text: "GO Live!",
                  onTap: goLiveStream,
                ),
              )

          ],
          ),
        ),
      ),
    )
    );
  }
}
