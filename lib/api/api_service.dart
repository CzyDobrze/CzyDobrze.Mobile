import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/section/section.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:riverpod/riverpod.dart';

final ApiServiceProvider = Provider((ref) {
  return ApiService();
});

class ApiService {
  Future<List<Textbook>> getTextbooks([int page = 0]) async {
    return List.generate(20, (index) => Textbook('Title ${page*20+index}', 'Math', 'Operon', 6));   // TODO: implement
  }

  Future<List<Section>> getSections(Textbook textbook, [int page = 0]) async {
    return [];  // TODO: implement
  }

  Future<List<Excersise>> getExcersises(Section section, [int page = 0]) async {
    return [];  // TODO: implement
  }
}