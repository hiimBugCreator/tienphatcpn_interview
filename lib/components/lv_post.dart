import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tienphatcpn_interview/pages/home/model/post.dart';

import 'lv_card.dart';

class LVPost extends StatelessWidget {
  const LVPost({super.key, required Post post}) : _post = post;
  final Post _post;

  @override
  Widget build(BuildContext context) {
    return LVCard(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(_post.title),
            subtitle: Text('Author: ${_post.author}'),
          ),
          Center(
            child: CachedNetworkImage(
              imageUrl: _post.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Liked: ${_post.liked}'),
                Text('Shared: ${_post.shared}'),
                Text('Comments: ${_post.comments}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
