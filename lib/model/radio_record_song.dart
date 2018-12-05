class RadioRecordSong {
  String title;
  String artist;
  String image;

  RadioRecordSong();

  RadioRecordSong.fromJson(Map<String, dynamic> json){
    print(json["image600"]);
    title = json["title"];
    artist = json["artist"];
    image = json["image600"] != null
        ? json["image600"]
        : "https://picsum.photos/600/600/?random";
  }
}