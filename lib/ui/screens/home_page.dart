import 'package:flutter/material.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/model/get_Model.dart';
import 'package:tolesson/ui/model/post_modal.dart';
import 'package:tolesson/ui/service/service.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  String text;

  Homepage({super.key, required this.text});

  @override
  State<Homepage> createState() => _HomepageState();
}

TextEditingController _taskEditingController = TextEditingController();

class _HomepageState extends ProjectLoading<Homepage> with AppText {
  List<GetModel>? items;
  // List<GetModel>? itens;
  late final ProjectService projectService;
  @override
  void initState() {
    super.initState();
    projectService = GeneralService();
    taskListCard();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicator.currentState?.show());
    super.initState();
  }

  Future<void> taskListCard() async {
    changeWaitValue();
    // itens = await projectService.taskListCard();
    items = await projectService.taskListCard();
    changeWaitValue();
  }

//post metodu aidir
  Future<void> sendItemsToWebservice(Posts toDoPostModel) async {
    projectService.taskPost(toDoPostModel);
    return;
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.text),
        ),
        body: RefreshIndicator(
          onRefresh: taskListCard,
          key: _refreshIndicator,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                    width: double.infinity,
                    color: Colors.black12,
                    child: Center(
                      child: Text(
                        items?.length.toString() ?? "0",
                        style: const TextStyle(color: Colors.red, fontSize: 20),
                      ),
                    )),
              ),
              Expanded(
                flex: 2,
                child: isWait
                    ? Container(
                        decoration: const BoxDecoration(),
                      )
                    : ListView.builder(
                        itemCount: items?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(
                              items?[index].tasks ?? "Error",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ));
                        }),
              ),
            ],
          ),
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
            title: Center(child: Text(alertDialogText)),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  value = value;
                });
              },
              controller: _taskEditingController,
              decoration: InputDecoration(hintText: alertTextFiled),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    final toDoPostModel =
                        Posts(tasks: _taskEditingController.text);
                    Navigator.of(context).pop();
                    sendItemsToWebservice(toDoPostModel);
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }
}

abstract class ProjectLoading<T extends StatefulWidget> extends State<T> {
  bool isWait = false;
  void changeWaitValue() {
    setState(() {
      isWait = !isWait;
    });
  }
}
