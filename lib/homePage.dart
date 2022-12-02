import 'package:flutter/material.dart';
import 'package:tolesson/modelPost.dart';
import 'package:tolesson/network.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  String text;

  Homepage({super.key, required this.text});

  @override
  State<Homepage> createState() => _HomepageState();
}

TextEditingController _nameTextEditingController = TextEditingController();

class _HomepageState extends State<Homepage> {
  ProjectService projectService = GeneralService();

  Future<void> sendItemsToWebservice(Posts toDoPostModel) async {
    projectService.taskPost(toDoPostModel);
    return;
  }

  List<Posts>? items;
  @override
  void initState() {
    super.initState();
    projectService = GeneralService();
    fetchItemFromMyApi();
  }

  Future<void> fetchItemFromMyApi() async {
    // changeWaitValue();
    // items = await projectService.fetchFromApiWithData();
    // changeWaitValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.text),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayTextInputDialog(context);
          },
          child: const Icon(Icons.add),
        ));
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Task add'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  value = value;
                });
              },
              controller: _nameTextEditingController,
              decoration: const InputDecoration(
                  hintText: "Task Flutter update version"),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();

                    final toDoPostModel =
                        Posts(tasks: _nameTextEditingController.text);
                    sendItemsToWebservice(toDoPostModel);
                  },
                  child: const Text("Ok"))
            ],
          );
        });
  }
}
