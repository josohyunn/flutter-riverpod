import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

// 1. 창고 데이터 (model)
class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  // 생성자인데 {}를 하면 생성자가 초기화되는 데 타이밍이 맞지않아서 initialized(:) 키워드를 사용해야 한다.
  PostModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["userId"],
        title = json["title"];
}

// 2. 창고 (view model)
// 비즈니스 로직은 창고에서 짜야한다.
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달해줌
  PostViewModel(super.state, this.ref);

  // 창고에서 ref쓸 수 있음
  Ref ref;

  // 상태 초기화(필수)
  void init() async {
    // 통신 코드
    PostModel postModel = await PostRepository().fetchPost(40);
    state = postModel;
  }

  // 상태 변경(로그인 했을때? 안했을때?)
  void change() async {
    // 통신 코드
    SessionUser sessionUser = ref.read(sessionProvider);

    if (sessionUser.isLogin) {
      PostModel postModel = await PostRepository().fetchPost(50);
      state = postModel;
    }
  }
}

// 3. 창고 관리자 (provider)
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>((ref) {
  return PostViewModel(null, ref)..init();
});
