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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.username;

    data['avatar_url'] = this.avatarUrl;

    data['html_url'] = this.githubUrl;

    return data;
  }
}
