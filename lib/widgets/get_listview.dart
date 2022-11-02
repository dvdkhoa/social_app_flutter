import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ltp/models/post.dart';
import 'package:ltp/widgets/custom_post-widget.dart';

class GetListView extends StatefulWidget{

  List<PostModel> posts;

  GetListView({required this.posts});

  @override
  State<StatefulWidget> createState() =>_GetListViewState();

}

class _GetListViewState extends State<GetListView> with AutomaticKeepAliveClientMixin<GetListView>{

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) {
        int actualindex = widget.posts.length - index - 1;
        return index % 2 == 0
            ? ElasticInLeft(
            duration: const Duration(milliseconds: 600),
            from: 400,
            child: CustomPostWidget(
              post: widget.posts[actualindex],
              index: actualindex,
            ))
            : ElasticInRight(
            duration: const Duration(milliseconds: 600),
            from: 400,
            child: CustomPostWidget(
              post: widget.posts[actualindex],
              index: actualindex,
            ));
      }),
      itemCount: widget.posts.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}