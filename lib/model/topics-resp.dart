import 'dart:convert' show json;

import 'package:v2ex/model/base-resp.dart';
import 'package:v2ex/model/member-resp.dart';

class TopicsResp extends BaseResp {
  List<Topic> list;

  TopicsResp.fromParams({this.list}) : super.fromParams();

  factory TopicsResp(jsonStr) => jsonStr is String
      ? TopicsResp.fromJson(json.decode(jsonStr))
      : TopicsResp.fromJson(jsonStr);

  TopicsResp.fromJson(jsonRes) : super.fromJson(jsonRes) {
    list = [];

    for (var listItem in jsonRes) {
      list.add(new Topic.fromJson(listItem));
    }
  }

  @override
  String toString() {
    return '{"jsonList": $list}';
  }
}

class Topic {
  int created;
  int id;
  int lastModified;
  int lastTouched;
  int replies;
  String content;
  String contentRendered;
  String title;
  String url;
  Member member;
  Node node;

  Topic.fromParams({
    this.created,
    this.id,
    this.lastModified,
    this.lastTouched,
    this.replies,
    this.content,
    this.contentRendered,
    this.title,
    this.url,
    this.member,
    this.node,
  });

  Topic.fromJson(jsonRes) {
    created = jsonRes['created'];
    id = jsonRes['id'];
    lastModified = jsonRes['last_modified'];
    lastTouched = jsonRes['last_touched'];
    replies = jsonRes['replies'];
    content = jsonRes['content'];
    contentRendered = jsonRes['content_rendered'];
    title = jsonRes['title'];
    url = jsonRes['url'];
    member = new Member.fromJson(jsonRes['member']);
    node = new Node.fromJson(jsonRes['node']);
  }

  @override
  String toString() {
    return '{"created": $created,"id": $id,"lastModified": $lastModified,"lastTouched": $lastTouched,"replies": $replies,"content": ${content != null ? '${json.encode(content)}' : 'null'},"contentRendered": ${contentRendered != null ? '${json.encode(contentRendered)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'},"member": $member,"node": $node}';
  }
}

class Node {
  int id;
  int topics;
  String avatarLarge;
  String avatarMini;
  String avatarNormal;
  String name;
  String title;
  String titleAlternative;
  String url;

  Node.fromParams({
    this.id,
    this.topics,
    this.avatarLarge,
    this.avatarMini,
    this.avatarNormal,
    this.name,
    this.title,
    this.titleAlternative,
    this.url,
  });

  Node.fromJson(jsonRes) {
    id = jsonRes['id'];
    topics = jsonRes['topics'];
    avatarLarge = jsonRes['avatar_large'];
    avatarMini = jsonRes['avatar_mini'];
    avatarNormal = jsonRes['avatar_normal'];
    name = jsonRes['name'];
    title = jsonRes['title'];
    titleAlternative = jsonRes['title_alternative'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"id": $id,"topics": $topics,"avatarLarge": ${avatarLarge != null ? '${json.encode(avatarLarge)}' : 'null'},"avatarMini": ${avatarMini != null ? '${json.encode(avatarMini)}' : 'null'},"avatarNormal": ${avatarNormal != null ? '${json.encode(avatarNormal)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'},"titleAlternative": ${titleAlternative != null ? '${json.encode(titleAlternative)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}
