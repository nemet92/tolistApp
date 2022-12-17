import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/model/get_Model.dart';
import 'package:tolesson/ui/model/post_modal.dart';
import 'package:tolesson/ui/screens/homePage/searcbox.dart';
import 'package:tolesson/ui/service/service.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  String text;

  Homepage({super.key, required this.text});

  @override
  State<Homepage> createState() => _HomepageState();
}

TextEditingController _taskEditingController = TextEditingController();

class _HomepageState extends ProjectLoading<Homepage>
    with AppText, AppIcon, AppSize {
  List<GetRequestModel>? items;
  late final ProjectService projectService;
  @override
  void initState() {
    super.initState();
    projectService = GeneralService();
    taskListCard();
    loadSwitchValue();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicator.currentState?.show());
    super.initState();
  }

  Future<void> taskListCard() async {
    changeWaitValue();
    items = await projectService.taskListCard();
    changeWaitValue();
  }

//post method
  Future<void> sendItemsToWebService(Posts toDoPostModel) async {
    projectService.taskPost(toDoPostModel);
    return;
  }

//delete
  Future<void> deleteItemFromApi(String key) async {
    projectService.removeItemFromLocalHost(key);
  }

  loadSwitchValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _checkboxValue = (prefs.getBool("isTrue")) ?? false;
  }

  bool _checkboxValue = false;

  saveswitchValue(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isTrue", _checkboxValue);
  }

  void changeValue(bool value) {
    setState(() {
      _checkboxValue = value;
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        drawer: const Drawer(),
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: taskListCard,
          key: _refreshIndicator,
          child: Padding(
            padding: columnPadding,
            child: Column(
              children: [
                const SearchBox(),
                sizedBox,
                Expanded(
                  flex: 1,
                  child: Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(taskNumber),
                          Text(
                            items?.length.toString() ?? "0",
                            style: const TextStyle(
                                color: Colors.red, fontSize: 20),
                          ),
                        ],
                      )),
                ),
                Expanded(
                  flex: 2,
                  child: isWait
                      ? Container(
                          decoration: const BoxDecoration(),
                        )
                      : ListView.builder(
                          // physics: const BouncingScrollPhysics(),
                          itemCount: items?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Dismissible(
                                    onDismissed: (direction) {
                                      deleteItemFromApi(
                                          items?[index].key ?? " ");
                                    },
                                    key: Key(items.toString()),
                                    child: ListTile(
                                      leading:
                                          //  Checkbox(
                                          //     value: items?[index].isDone,
                                          //     onChanged: (value) {
                                          //       debugPrint(value.toString());

                                          //       setState(() {
                                          //         items?[index].isDone = value;
                                          //       });
                                          //     }),
                                          Checkbox(
                                              value: _checkboxValue,
                                              onChanged: (value) {
                                                changeValue(value ?? false);

                                                // setState(() {
                                                //   _checkboxValue = value;

                                                //   saveswitchValue(
                                                //       items?[index].key ?? " ");
                                                // });
                                              }),
                                      trailing: IconButton(
                                        icon: deleteIcon,
                                        onPressed: () {
                                          setState(() {
                                            deleteItemFromApi(
                                                items?[index].key ?? "");
                                          });
                                        },
                                      ),
                                      title: Text(
                                        items?[index].tasks ?? "Error",
                                        style: TextStyle(
                                          color: Colors.black,
                                          decoration: (_checkboxValue
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none),
                                        ),
                                      ),
                                    )));
                          }),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _displayTextInputDialog(context);
          },
          child: const Icon(Icons.add),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Welcome"),
          const Text(" "),
          Text(widget.text),
        ],
      ),
    );
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
                    final toDoPostModel = Posts(
                      tasks: _taskEditingController.text,
                      // isDone: false
                    );
                    sendItemsToWebService(toDoPostModel);

                    Navigator.of(context).pop();
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
