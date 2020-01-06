class Cast {
  List<Actor> actors = new List();

  Cast.jsonList(List<dynamic> json) {
    if (json == null) return;
    json.forEach((item) {
      final actor = Actor.fromJson(item);
      actors.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Actor.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getProfilePhoto() {
    if (profilePath == null) {
      return 'https://techtour-prod-public.s3-eu-west-1.amazonaws.com/3004010?AWSAccessKeyId=AKIAIQY2UYNCMITUGSSA&Expires=1578933152&Signature=X6GVXY4Eml%2BZHV07KUnDj%2FN44OY%3D';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
