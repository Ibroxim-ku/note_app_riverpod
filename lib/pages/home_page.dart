import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mockapi/controllers/home_controller.dart';
import 'package:riverpod_mockapi/pages/create_detail.dart';
import 'package:riverpod_mockapi/pages/detail.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(homeNotifierProvider).getAllData().then((value) {
      ref.read(homeNotifierProvider).isLoading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(homeNotifierProvider);
    var con = ref.read(homeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFe5e1ee),
        title: const Text("HOME"),
        centerTitle: true,
      ),
      body: con.isLoading
          ? ListView.builder(
              padding: const EdgeInsets.all(14),
              itemCount: con.noteList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: const Color(0xFFdffdff),
                  child: ListTile(
                    leading: Text(
                      con.noteList[index].id.toString(),
                    ),
                    title: Text(
                      con.noteList[index].title.toString(),
                    ),
                    subtitle: Text(
                      con.noteList[index].description.toString(),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => WCreateDetail(
                                int.parse(
                                  con.noteList[index].id.toString(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        IconButton(
                          onPressed: () async {
                            await con.deleteData(
                                int.parse(
                                  con.noteList[index].id.toString(),
                                ),
                                context);
                            con.titleController.clear();
                            con.descController.clear();
                          },
                          icon: const Icon(
                            CupertinoIcons.delete,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => WDetail(
              titleController: con.titleController,
              descController: con.descController,
            ),
          );
        },
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
