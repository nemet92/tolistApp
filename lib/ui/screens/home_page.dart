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

class _HomepageState extends ProjectLoading<Homepage> with AppText, AppIcon {
  List<GetRequestModel>? items;
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
        backgroundColor: Colors.grey[300],
        drawer: const Drawer(),
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: taskListCard,
          key: _refreshIndicator,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              children: [
                const searcBox(),
                sizedBox(),
                Expanded(
                  flex: 1,
                  child: Container(
                      width: double.infinity,
                      color: Colors.black12,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("Sizin qeydlerinizin sayi"),
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
                          itemCount: items?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  leading: const Icon(Icons.check_box),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {},
                                  ),
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

class searcBox extends StatelessWidget {
  const searcBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white70,
      ),
      child: const TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 24),
            border: InputBorder.none,
            hintText: "Search"),
      ),
    );
  }
}

abstract class ProjectLoading<T extends StatefulWidget> extends State<T> {
  bool isWait = false;
  void changeWaitValue() {
    setState(() {
      isWait = !isWait;
    });
  }

  SizedBox sizedBox() {
    return const SizedBox(
      height: 20,
    );
  }
}
