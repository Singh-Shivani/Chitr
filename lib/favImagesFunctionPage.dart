class FavImages {
  static List _favImages = [];
  static List _favImagesId = [];

  bool addFavImages(List imgData) {
    if (_favImagesId.contains(imgData[0]) == true) {
      return true;
    } else {
      _favImages.add(imgData);
      _favImagesId.add(imgData[0]);
      return false;
    }
  }

  List getFavImages() {
    return _favImages;
  }

  void removeFavImages(List imgData) {
    _favImages.remove(imgData);
    _favImagesId.remove(imgData[0]);
  }
}
