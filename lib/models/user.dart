class User {
  User({
    this.page,
    this.perPage,
    this.totalrecord,
    this.totalPages,
    this.data,
  });
  int? page;
  int? perPage;
  int? totalrecord;
  int? totalPages;
  List<Data>? data;

  User.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    totalrecord = json['totalrecord'];
    totalPages = json['total_pages'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['per_page'] = perPage;
    _data['totalrecord'] = totalrecord;
    _data['total_pages'] = totalPages;
    _data['data'] = data!.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.email,
    this.profilepicture,
    this.location,
    this.createdat,
  });
  int? id;
  String? name;
  String? email;
  String? profilepicture;
  String? location;
  String? createdat;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profilepicture = json['profilepicture'];
    location = json['location'];
    createdat = json['createdat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['profilepicture'] = profilepicture;
    _data['location'] = location;
    _data['createdat'] = createdat;
    return _data;
  }
}
