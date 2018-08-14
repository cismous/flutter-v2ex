import 'dart:async';
import 'dart:convert';

import 'package:v2ex/model/replies-resp.dart';
import 'package:v2ex/model/site-info-resp.dart';
import 'package:v2ex/model/topics-resp.dart';
import 'package:v2ex/api/Constants.dart' as httpConstants;
import 'package:http/http.dart' as http;
import 'package:kernel/log.dart';

final Logger log1 = new Logger("dart-kernel");

class NetworkApi {
  static Future _read(String url) {
    return http.read(url);
  }

  static dynamic _get(String url) async {
    String response = await _read(url);
    // print('----------------------------------------');
    // print('$url =>\n $response');
    return json.decode(response.replaceAll('\r\n', '').replaceAll('\n', ''));
  }

  static Future<SiteInfoResp> getSiteInfo() async {
    return SiteInfoResp.fromJson(await _get(httpConstants.API_SITE_INFO));
  }

  static Future<TopicsResp> getLatestTopics() async {
    return TopicsResp.fromJson(await _get(httpConstants.API_TOPICS_LATEST));
  }

  static Future<TopicsResp> getHotTopics() async {
    return TopicsResp.fromJson(await _get(httpConstants.API_TOPICS_HOT));
  }

  static Future<TopicsResp> getTopicDetails(int id) async {
    return TopicsResp.fromJson(
        await _get(httpConstants.API_TOPIC_DETAILS + '?id=' + id.toString()));
  }

  static Future<RepliesResp> getReplies(int topicId) async {
    return RepliesResp.fromJson(await _get(
        httpConstants.API_TOPIC_REPLY + '?topic_id=' + topicId.toString()));
  }
}
