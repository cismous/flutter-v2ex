import 'dart:convert' show json;

class BaseResp {
  String message;
  String status;
  RateLimit rateLimit;

  BaseResp.fromParams({this.message, this.status, this.rateLimit});

  factory BaseResp(jsonStr) => jsonStr is String
      ? BaseResp.fromJson(json.decode(jsonStr))
      : BaseResp.fromJson(jsonStr);

  BaseResp.fromJson(jsonRes) {
    try {
      message = jsonRes['message'];
      status = jsonRes['status'];
      rateLimit = new RateLimit.fromJson(jsonRes['rate_limit']);
    } catch (e) {
      e.toString();
    }
  }

  @override
  String toString() {
    return '{"message": ${message != null ? '${json.encode(message)}' : 'null'},"status": ${status != null ? '${json.encode(status)}' : 'null'},"rateLimit": $rateLimit}';
  }
}

class RateLimit {
  int hourlyQuota;
  int hourlyRemaining;
  int used;

  RateLimit.fromParams({this.hourlyQuota, this.hourlyRemaining, this.used});

  RateLimit.fromJson(jsonRes) {
    try {
      hourlyQuota = jsonRes['hourly_quota'];
      hourlyRemaining = jsonRes['hourly_remaining'];
      used = jsonRes['used'];
    } catch (e) {
      e.toString();
    }
  }

  @override
  String toString() {
    return '{"hourlyQuota": $hourlyQuota,"hourlyRemaining": $hourlyRemaining,"used": $used}';
  }
}
