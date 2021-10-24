import 'package:czydobrze/comment/comment.dart';
import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/section/section.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:czydobrze/user/user.dart';
import 'package:riverpod/riverpod.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService();
});

class ApiService {
  Future<List<Textbook>> getTextbooks({String searchTerm = '', int page = 0}) async {
    return List.generate(20, (index) => Textbook('$searchTerm ${page*20+index}', 'Math', 'Operon', 6));   // TODO: implement
  }

  Future<List<Section>> getSections(Textbook textbook, [int page = 0]) async {
    return List.generate(20, (index) => Section('${textbook.subject} ${page*20+index}', 'Some interesting section'));  // TODO: implement
  }

  Future<List<Excersise>> getExcersises(Section section, [int page = 0]) async {
    return List.generate(20, (index) => Excersise('Some excersise ${page*20+index}', "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."));  // TODO: implement
  }

  Future<List<Comment>> getComments(Excersise excersise) async {
    return List.generate(20, (index) => Comment('This post nr $index is awesome!', User('Funny Man', 420)));  // TODO: implement
  }

  Future<void> addComment(Excersise excersise, String content) async {
    // TODO: implement
  }
}