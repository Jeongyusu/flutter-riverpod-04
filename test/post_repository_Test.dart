import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';

void main() async {
  await fetchPost_test();
}

Future<void> fetchPost_test() async {
  PostModel postModel = await PostRepository().fetchPost(40);
  print(postModel.title);
}
