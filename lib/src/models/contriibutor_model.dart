class Contributor {
  String? username;
  String? avatarUrl;
  String? githubUrl;

  Contributor({
    this.username,
    this.avatarUrl,
    this.githubUrl,
  });

  Contributor.fromJson(Map<String, dynamic> json) {
    username = json['login'];

    avatarUrl = json['avatar_url'];

    githubUrl = json['html_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['login'] = username;

    data['avatar_url'] = avatarUrl;

    data['html_url'] = githubUrl;

    return data;
  }
}
