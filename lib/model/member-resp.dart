import 'dart:convert';

class Member {
  int id;
  String avatarLarge;
  String avatarMini;
  String avatarNormal;
  String tagline;
  String username;

  Member.fromParams(
      {this.id,
      this.avatarLarge,
      this.avatarMini,
      this.avatarNormal,
      this.tagline,
      this.username});

  Member.fromJson(jsonRes) {
    id = jsonRes['id'];
    avatarLarge = jsonRes['avatar_large'];
    if (avatarLarge.contains('cdn.v2ex.com/gravatar')) {
      avatarLarge = avatarLarge.replaceAll(new RegExp(r"s=\d+"), 's=76');
    } else if (avatarLarge.contains('_mini')) {
      avatarLarge = avatarLarge.replaceAll(new RegExp(r"_mini"), '_large');
    }
    avatarMini = jsonRes['avatar_mini'];
    avatarNormal = jsonRes['avatar_normal'];
    tagline = jsonRes['tagline'];
    username = jsonRes['username'];
  }

  @override
  String toString() {
    return '{"id": $id,"avatarLarge": ${avatarLarge != null ? '${json.encode(avatarLarge)}' : 'null'},"avatarMini": ${avatarMini != null ? '${json.encode(avatarMini)}' : 'null'},"avatarNormal": ${avatarNormal != null ? '${json.encode(avatarNormal)}' : 'null'},"tagline": ${tagline != null ? '${json.encode(tagline)}' : 'null'},"username": ${username != null ? '${json.encode(username)}' : 'null'}}';
  }
}
