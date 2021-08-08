class Picture {
  String preview = "";
  String thumb = "";
  String img = "";

  Picture(this.preview, this.thumb, this.img);

  Picture.fromJson(Map<String, dynamic> json)
      : this(json['preview'], json['thumb'], json['img']);

  Map<String, dynamic> toJson() {
    return {'preview': preview, 'thumb': thumb, 'img': img};
  }
}
