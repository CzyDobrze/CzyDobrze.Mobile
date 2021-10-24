import 'package:czydobrze/comment/comment.dart';
import 'package:czydobrze/excersise/excersise.dart';
import 'package:czydobrze/section/section.dart';
import 'package:czydobrze/textbook/textbook.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final apiServiceProvider = Provider((ref) {
  return ApiService();
});

class ApiService {
  static const String prefix = 'https://czydobrze.bazik.xyz/api';

  final Dio _dio = Dio();

  Future<List<Textbook>> getTextbooks({String searchTerm = '', int page = 0}) async {
    Response r = await _dio.get('$prefix/textbook?page=$page&amount=50');
    List<Textbook> data = r.data.map((e) => Textbook.fromJson(e)).toList();
    return data.where((textbook) => textbook.searchTerm.contains(searchTerm)).toList();
  }

  Future<List<Section>> getSections(Textbook textbook, [int page = 0]) async {
    Response r = await _dio.get('$prefix/textbook/${textbook.id}/sections?page=$page&amount=50');
    List<Section> data = r.data.map((e) => Section.fromJson(e)).toList();
    return data;
  }

  Future<List<Excersise>> getExcersises(Section section, [int page = 0]) async {
    Response r = await _dio.get('$prefix/section/${section.id}/excersises?page=$page&amount=50');
    List<Excersise> data = r.data.map((e) => Excersise.fromJson(e)).toList();
    return data;
  }

  Future<List<Comment>> getComments(Excersise excersise) async {
    Response r = await _dio.get('$prefix/excersise/${excersise.id}/answers?&amount=100');
    List<Comment> data = r.data.map((e) => Comment.fromJson(e)).toList();
    return data;
  }
}