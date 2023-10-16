// 1. 창고 데이터 (model)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

// 2. 창고 (view model) - 비지니스로직은 여기서 짠다.
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  Ref ref;

  // 상태 초기화 (필수)
  void init() async {
    PostModel postModel = await PostRepository().fetchPost(40);
    state = postModel;
  }

  // 상태 변경(로그인 했을때? 안했을때?)
  void change() async {
    SessionUser sessionUser = ref.read(sessionProvider);

    if (sessionUser.isLogin) {
      PostModel postModel = await PostRepository().fetchPost(50);
      state = postModel;
    }
  }
}

// 3. 창고 관리자 (provider)
// autoDispose는 메모리 관리를 자동으로해줌
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>((ref) {
  return PostViewModel(null, ref)..init();
});
