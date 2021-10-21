import 'package:czydobrze/comment/comment.dart';
import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/section/section.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:riverpod/riverpod.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService();
});

class ApiService {
  Future<List<Textbook>> getTextbooks({String searchTerm = '', int page = 0}) async {
    return List.generate(20, (index) => Textbook('$searchTerm ${page*20+index}', 'Math', 'Operon', 6));   // TODO: implement
  }

  Future<List<Section>> getSections(Textbook textbook, [int page = 0]) async {
    return [];  // TODO: implement
  }

  Future<List<Excersise>> getExcersises(Section section, [int page = 0]) async {
    return [];  // TODO: implement
  }

  Future<List<Comment>> getComments(Excersise excersise) async {
    return [];
  }
}