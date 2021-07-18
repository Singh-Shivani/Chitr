class Loading {
  Loading({
    this.loading,
  });

  List<LoadingElement> loading;

  factory Loading.fromJson(Map<String, dynamic> json) => Loading(
        loading: json["loading"] == null
            ? null
            : List<LoadingElement>.from(
                json["loading"].map((x) => LoadingElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loading": loading == null
            ? null
            : List<dynamic>.from(loading.map((x) => x.toJson())),
      };
}

class LoadingElement {
  LoadingElement({
    this.height,
    this.width,
  });

  int height;
  int width;

  factory LoadingElement.fromJson(Map<String, dynamic> json) => LoadingElement(
        height: json["height"] == null ? null : json["height"],
        width: json["width"] == null ? null : json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "width": width == null ? null : width,
      };
}
