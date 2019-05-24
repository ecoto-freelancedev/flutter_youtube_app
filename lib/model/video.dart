class VideoList {
  final List<Video> videos;

  VideoList({
    this.videos,
  });

  factory VideoList.fromJson(List<dynamic> parsedJson) {

    List<Video> photos = new List<Video>();
    photos = parsedJson.map((i)=>Video.fromJson(i)).toList();

    return new VideoList(
        videos: photos
    );
  }
}

class Video {
  String nombre;
  String url;

  Video({
    this.nombre,
    this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => new Video(
    nombre: json["nombre"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "url": url,
  };
}
