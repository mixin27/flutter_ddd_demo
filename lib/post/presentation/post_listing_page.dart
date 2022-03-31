import 'package:demo/post/application/post_notifier.dart';
import 'package:demo/post/core/shared/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostListingPage extends ConsumerStatefulWidget {
  const PostListingPage({Key? key}) : super(key: key);

  @override
  _PostListingPageState createState() => _PostListingPageState();
}

class _PostListingPageState extends ConsumerState<PostListingPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(postNotifierProvider.notifier).getAllPosts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Listing'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          ref.listen<PostState>(postNotifierProvider, (previous, state) {
            state.maybeWhen(
                orElse: () {},
                loadFailure: (f) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${f.errorCode}')),
                  );
                });
          });

          final state = ref.watch(postNotifierProvider);

          return state.maybeWhen(
            orElse: () => Container(),
            loadInProgress: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loadSucces: (posts) => Container(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Center(child: Text('${post.id}')),
                      ),
                      title: Text(post.title),
                      subtitle: Text(
                        post.body,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  );
                },
                itemCount: posts.length,
              ),
            ),
          );
        },
      ),
    );
  }
}
