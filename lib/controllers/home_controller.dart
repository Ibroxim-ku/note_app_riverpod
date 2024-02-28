import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_mockapi/models/note_model.dart';
import 'package:riverpod_mockapi/services/network.dart';

final homeNotifierProvider =
    ChangeNotifierProvider.autoDispose((ref) => HomeNotifier());

class HomeNotifier extends ChangeNotifier {
  bool isLoading = false;

  late List<Note> noteList;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Future<void> getAllData() async {
    isLoading = false;
    String result = await NetworkService.GET(NetworkService.apiGetAllProducts);
    debugPrint(result);

    //map=> Object
    noteList = noteFromJson(result);

    debugPrint("$noteList");

    isLoading = true;

    notifyListeners();
  }

  Future<void> deleteData(int id, BuildContext context) async {
    var result =
        await NetworkService.DELETE(NetworkService.apiDeleteProduct, id);

    if (result == "200" || result == "201") {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${id.toString()} Successfully deleted")));
    }
    await getAllData(); 
    notifyListeners();
  }

  Future<void> createNote(Note note) async {
    await NetworkService.POST(NetworkService.apiGetAllProducts, note.toJson());
    getAllData();
    notifyListeners();
  }

  Future<void> updateData(Note note, int id) async {
    await NetworkService.PUT(
        NetworkService.apiUpdateProduct, note.toJson(), id);
    getAllData();
    notifyListeners();
  }
}
