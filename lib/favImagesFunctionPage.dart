class FavImages {
  static List _favImages = [];

  void addFavImages(List imgData) {
    _favImages.add(imgData);
  }

  List getFavImages() {
    return _favImages;
  }

  void removeFavImages(List imgData) {
    _favImages.remove(imgData);
  }
}
