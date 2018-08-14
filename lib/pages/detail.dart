import 'package:flutter/material.dart';
import 'package:v2ex/model/replies-resp.dart';
import 'package:v2ex/model/topics-resp.dart';
import 'package:v2ex/api/api.dart';
import 'package:v2ex/utils/time-base.dart';

const Color _themeColor = Color(0xFF004586);

class TopicDetail extends StatelessWidget {
  final Topic topic;

  TopicDetail(this.topic);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '文章详情',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new Scaffold(
        backgroundColor: const Color(0xFFf2f2f2),
        appBar: new AppBar(
          elevation: 0.0,
          bottom: new PreferredSize(
            child: new Container(
              decoration: new BoxDecoration(
                border: new Border(
                  bottom: new BorderSide(
                    width: 0.2,
                    color: const Color(0xFFE4E4E4),
                  ),
                ),
              ),
            ),
            preferredSize: const Size.fromHeight(0.0),
          ),
          backgroundColor: Color(0xFFfafafa),
          leading: new GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Icon(Icons.close),
          ),
        ),
        body: new ListView(
          children: <Widget>[
            new TopicBodyView(topic),
            new RepliesView(topic.id),
          ],
        ),
      ),
    );
  }
}

class RepliesView extends StatelessWidget {
  final int topicId;

  RepliesView(this.topicId);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: new Column(
        children: <Widget>[
          new FutureBuilder<RepliesResp>(
            future: NetworkApi.getReplies(topicId),
            builder: (context, result) {
              if (result.hasData) {
                if (result.data.list.length != 0) {
                  return new Column(
                    children: result.data.list.map((Reply reply) {
                      return new Container(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 0.0, bottom: 14.0),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              width: 34.0,
                              height: 34.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                    'https:' + reply.member.avatarLarge,
                                  ),
                                ),
                              ),
                            ),
                            new Expanded(
                              child: new Column(
                                children: <Widget>[
                                  new Container(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Padding(
                                          padding:
                                              new EdgeInsets.only(right: 4.0),
                                          child: new Text(
                                            reply.member.username,
                                            textAlign: TextAlign.left,
                                            style: new TextStyle(
                                              fontSize: 13.0,
                                              color: _themeColor,
                                            ),
                                          ),
                                        ),
                                        new Text(
                                          new TimeBase(reply.lastModified)
                                              .getShowTime(),
                                          style: new TextStyle(
                                            fontSize: 13.0,
                                            color: Color(0xFFb3b3b3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Expanded(
                                          child: new Text(
                                            reply.content.toString(),
                                            style:
                                                new TextStyle(fontSize: 13.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return new Container(
                    margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new Text('暂无回贴',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Color(0xFFb3b3b3),
                        )),
                  );
                }
              } else if (result.hasError) {
                return new Center(child: new Text("${result.error}"));
              }

              return new Container(
                padding: const EdgeInsets.all(10.0),
                child: new Center(child: new CircularProgressIndicator()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class TopicBodyView extends StatelessWidget {
  final Topic topic;
  bool notNull(Object o) => o != null;

  TopicBodyView(this.topic);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 18.0,
            bottom: 16.0,
            right: 16.0,
          ),
          width: 500.0,
          child: new Text(
            topic.title,
            softWrap: true,
            style: new TextStyle(
              color: Color(0xFF333333),
              fontSize: 20.0,
              height: 0.8,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        new Container(
          decoration: new BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(left: 16.0),
          child: new Row(
            children: <Widget>[
              new Text(
                topic.member.username,
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontSize: 12.0,
                  color: _themeColor,
                ),
              ),
              new Padding(
                padding: new EdgeInsets.only(right: 4.0, left: 4.0),
                child: new Text(
                  new TimeBase(topic.lastModified).getShowTime(),
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: new TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFFb3b3b3),
                  ),
                ),
              ),
              topic.replies > 0
                  ? new Text(
                      '回贴' + topic.replies.toString(),
                      style: new TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFb3b3b3),
                      ),
                    )
                  : null,
            ].where(notNull).toList(),
          ),
        ),
        new Container(
          alignment: Alignment.centerLeft,
          decoration: new BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 24.0,
            bottom: 24.0,
            right: 16.0,
          ),
          child: new Text(
            topic.content,
            softWrap: true,
            style: new TextStyle(color: Color(0xFF333333), fontSize: 14.0),
          ),
        ),
      ],
    );
  }
}
