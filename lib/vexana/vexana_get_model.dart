import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tolesson/const/general_path.dart';
import 'package:tolesson/ui/model/get_Model.dart';
import 'package:tolesson/ui/model/post_modal.dart';
import 'package:tolesson/ui/screens/homePage/searcbox.dart';
import 'package:tolesson/ui/service/service.dart';
import 'package:tolesson/vexana/vexana_%20model.dart';
import 'package:vexana/vexana.dart';

// ignore: must_be_immutable
class HomepageVexana extends StatefulWidget {
  const HomepageVexana({
    super.key,
  });

  @override
  State<HomepageVexana> createState() => _HomepageVexanaState();
}

TextEditingController _taskEditingController = TextEditingController();
TextEditingController _taskEditingController22 = TextEditingController();

bool _checkboxValue = false;
bool isData = false;
List<bool> chekList = [];
var secilenList = <bool>[];

class _HomepageVexanaState extends ProjectLoading<HomepageVexana>
    with AppText, AppIcon, AppSize, AppColor {
//vexana
  List<VexanaModel>? itemss;
  late final INetworkManager networkManager;

  Future<void> getUserInfo() async {
    final response = await networkManager
        .send<VexanaModel, Map<dynamic, dynamic>>('vexena.json',
            parseModel: VexanaModel(), method: RequestType.GET);
  }

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

  saveswitchValue(String number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("isTrue", _checkboxValue);
  }

  Future<void> changeColorValue() async {
    final prefs = await SharedPreferences.getInstance();
    changeColor(prefs.getBool("isTrue") ?? false);
  }

  void changeValue(bool value) {
    setState(() {
      _checkboxValue = value;
    });
  }

  void changeColor(bool isRed) {
    setState(() {
      isData = isRed;
    });
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicator =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        // drawer: const Drawer(
        //   child: ListTile(leading: Text(networkManager.),),
        // ),
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
                    child: (items?.isNotEmpty ?? false)
                        ? isWait
                            ? Container(
                                decoration: const BoxDecoration(),
                              )
                            : ListView.builder(
                                // physics: const BouncingScrollPhysics(),
                                itemCount: items?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Dismissible(
                                          onDismissed: (direction) {
                                            deleteItemFromApi(
                                                items?[index].key ?? " ");
                                          },
                                          background: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
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
                                                        changeValue(
                                                            value ?? false);

                                                        // setState(() {
                                                        //   _checkboxValue = value;

                                                        //   saveswitchValue(
                                                        //       items?[index].key ?? " ");
                                                        // });
                                                      }),
                                              // trailing: _checkboxValue
                                              //     ? const TextField(
                                              //         decoration:
                                              //             InputDecoration(),
                                              //       )
                                              //     : IconButton(
                                              //         icon: deleteIcon,
                                              //         onPressed: () {
                                              //           setState(() {});
                                              //         },
                                              //       ),
                                              title: _checkboxValue
                                                  ? Text(
                                                      items?[index].tasks ??
                                                          "Error",
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        decoration:
                                                            (TextDecoration
                                                                .lineThrough),
                                                      ),
                                                    )
                                                  : TextField(
                                                      controller:
                                                          _taskEditingController22,
                                                      onSubmitted: ((value) {
                                                        final toDoPostModel =
                                                            Posts(
                                                          tasks:
                                                              _taskEditingController22
                                                                  .text = value,
                                                        );
                                                        sendItemsToWebService(
                                                            toDoPostModel);
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      decoration:
                                                          const InputDecoration()))));
                                })
                        : const Center(
                            child: Text("Tapsiriq yoxdur!!"),
                          )),
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
      actions: [
        IconButton(
            onPressed: () async {
              setState(() {
                isData = !isData;
              });
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool("isTrue", isData);
            },
            icon: isData == true ? sunny : dark)
      ],
      backgroundColor: isData == true ? sunnyColor : darkColor,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text("Welcome"),
          Text(" "),
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
