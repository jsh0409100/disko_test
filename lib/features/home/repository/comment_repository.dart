import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:disko_001/features/write_post/repository/write_post_repository.dart';
import 'package:disko_001/features/write_post/screens/write_post_page.dart';
import 'package:disko_001/models/post_card_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../common/utils/utils.dart';
import '../../../models/comment_model.dart';
import '../../../models/user_model.dart';

final commentRepositoryProvider = Provider(
  (ref) => CommentRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class CommentRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  CommentRepository({
    required this.firestore,
    required this.auth,
  });

  Stream<List<CommentModel>> getCommentStream(String postId) {
    final String collectionPath = 'posts/$postId/comment';

    return firestore
        .collection(collectionPath)
        .orderBy('time')
        .snapshots()
        .map((event) {
      List<CommentModel> comment = [];
      for (var document in event.docs) {
        comment.add(CommentModel.fromJson(document.data()));
      }
      return comment;
    });
  }

  void _saveComment({
    required String userName,
    required String text,
    required Timestamp time,
    required String uid,
    required List<String> likes,
    required String commentId,
    required String postId,
  }) async {
    final comment = CommentModel(
      userName: userName,
      text: text,
      time: time,
      uid: uid,
      likes: likes,
    );
    return firestore
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(commentId)
        .set(
      comment.toJson(),
    );
  }

  void _saveCommentCount({
    required String text,
    required Timestamp time,
    required String postId,
    required String username,
    required String postCategory,
    required String postTitle,
    required List<String> imagesUrl,
    required List<String> likes,
  }) async {
    final comment = PostCardModel(
      time: time,
      userName: username,
      postCategory: postCategory,
      postTitle: postTitle,
      postText: text,
      uid: auth.currentUser!.uid,
      likes: [],
      imagesUrl: [],
      postId: '',
      comment_count: 0,
    );

    final currentComment = firestore.collection('posts').doc(postId);
    final doc = await currentComment.get();

    if (doc.exists) {
      final data = doc.get('postId');
      (data == postId)
          ? currentComment.update({
        'comment_count': FieldValue.increment(1),
      })
          : currentComment.set(comment.toJson());
    } else {
      currentComment.set(comment.toJson());
    }
  }

  void uploadComment({
    required BuildContext context,
    required String text,
    required UserModel senderUser,
    required String postId,
    required String postCategory,
    required String postTitle,
    required List<String> imagesUrl,
    required List<String> likes,
  }) async {
    try {
      var time = Timestamp.now();
      var commentId = const Uuid().v1();

      _saveComment(
        userName: senderUser.displayName,
        text: text,
        commentId: commentId,
        time: time,
        uid: auth.currentUser!.uid,
        likes: [],
        postId: postId,
      );

      _saveCommentCount(
        text: text,
        time: time,
        postId: postId,
        username: senderUser.displayName,
        postCategory: postCategory,
        postTitle: postTitle,
        imagesUrl: imagesUrl,
        likes: likes,
      );
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}


