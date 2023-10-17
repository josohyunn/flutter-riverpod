import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

// 구독할 페이지에서 extends CousumerWidget + build에 매개변수로 WidgetRef 추가하기
class PostPage extends ConsumerWidget {
  PostPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("나 빌드됨");

    // 구독
    PostModel? model = ref.watch(postProvider);
    if (model == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.network(
                "https://picsum.photos/id/${model.id}/200/200",
                fit: BoxFit.cover,
              ),
            ),
            Text(
                "id : ${model.id}, userId : ${model.userId}, title : ${model.title}"),
            ElevatedButton(
              onPressed: () {
                ref.read(postProvider.notifier).change();
              },
              child: Text("값변경"),
            ),
            ElevatedButton(
              onPressed: () {
                SessionUser sessionUser = ref.read(sessionProvider);
                sessionUser.isLogin = true;
              },
              child: Text("로그인"),
            ),
          ],
        ),
      );
    }
  }
}
