import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_flutter/utils/utils.dart';
import 'package:firebase_flutter/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postsController = TextEditingController();
  bool isLoading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              controller: postsController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind..?",
                border: OutlineInputBorder()
              ),
              
            ),
            SizedBox(height: 30,),
            RoundButton(
                loading: isLoading,
                title: "Add", onTap: (){
              setState(() {
                isLoading = true;
              });
              String id = DateTime.now().millisecondsSinceEpoch.toString();
              databaseRef.child(id).set({
                'title' : postsController.text.toString(),
                'id' : id,
              }).then((value) {
                Utils().toastMessage("Post Added");
                setState(() {
                  isLoading = false;
                });
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  isLoading = false;
                });
              });
            })
          ],
        ),
      ),
    );
  }
}
