import 'dart:async';

import 'package:flutter/material.dart';
import 'package:v2ex/model/topics-resp.dart';
import 'package:v2ex/api/api.dart';
import 'package:v2ex/pages/detail.dart';
import 'package:v2ex/utils/time-base.dart';

const Color _textColor = Color(0xFF778087);

class HotPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HotPageViewState();
}

class LatestPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new LatestPageViewState();
}

class HotPageViewState extends BasePageViewState<HotPageView> {
  @override
  Future<TopicsResp> onRefresh() {
    return NetworkApi.getHotTopics();
  }
}

class LatestPageViewState extends BasePageViewState<LatestPageView> {
  @override
  Future<TopicsResp> onRefresh() {
    return NetworkApi.getLatestTopics();
  }
}

abstract class BasePageViewState<View extends StatefulWidget>
    extends State<View> with AutomaticKeepAliveClientMixin {
  Future<TopicsResp> data;

  @override
  bool get wantKeepAlive => true;

  Future<Null> _onRefresh() {
    return new Future(() {
      setState(() {
        data = onRefresh();
      });
    });
  }

  Future<TopicsResp> onRefresh();

  @override
  void initState() {
    super.initState();
    data = onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<TopicsResp>(
      future: data,
      builder: (context, result) {
        if (result.hasData) {
          return new RefreshIndicator(
              child: new ListView(
                children: result.data.list.map((Topic topic) {
                  return new TopicItemView(topic);
                }).toList(),
              ),
              onRefresh: _onRefresh);
        } else if (result.hasError) {
          return new Center(child: new Text("${result.error}"));
        }

        // By default, show a loading spinner
        return new Center(child: new CircularProgressIndicator());
      },
    );
  }
}

class TopicItemView extends StatelessWidget {
  final Topic topic;
  bool notNull(Object o) => o != null;

  TopicItemView(this.topic);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(builder: (context) => new TopicDetail(topic)),
        );
      },
      child: new Container(
        decoration: new BoxDecoration(
          border: new Border(
            bottom: new BorderSide(width: 0.2, color: const Color(0xFFc2c2c2)),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new Text(
                    topic.title,
                    maxLines: 2,
                    style: new TextStyle(
                      height: 0.9,
                      fontSize: 16.0,
                      color: Color(0xFF343434),
                    ),
                  ),
                ),
                new Container(
                  width: 48.0,
                  height: 48.0,
                  margin: new EdgeInsets.only(left: 8.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          new NetworkImage('https:' + topic.member.avatarLarge),
                    ),
                  ),
                ),
              ],
            ),
            new Container(
              margin: new EdgeInsets.only(top: 8.0),
              child: new Row(
                children: <Widget>[
                  new Text(
                    topic.member.username,
                    style: new TextStyle(fontSize: 12.0, color: _textColor),
                  ),
                  new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 4.0,
                    ),
                    child: new Text(
                      '·',
                      style: new TextStyle(fontSize: 12.0, color: _textColor),
                    ),
                  ),
                  new Text(
                    new TimeBase(topic.lastModified).getShowTime(),
                    style: new TextStyle(fontSize: 12.0, color: _textColor),
                  ),
                  topic.replies > 0
                      ? new Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 4.0),
                          child: new Text(
                            '·',
                            style: new TextStyle(
                                fontSize: 12.0, color: _textColor),
                          ),
                        )
                      : null,
                  topic.replies > 0
                      ? new Container(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: new Icon(Icons.comment,
                              size: 12.0, color: _textColor),
                        )
                      : null,
                  topic.replies > 0
                      ? new Text(
                          topic.replies.toString(),
                          style:
                              new TextStyle(fontSize: 12.0, color: _textColor),
                        )
                      : null,
                  new Expanded(
                    child: new Text(
                      topic.node.title,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                ].where(notNull).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
