class Topics {
  Topics({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.publishedAt,
    this.updatedAt,
    this.startsAt,
    this.endsAt,
    this.featured,
    this.totalPhotos,
    this.currentUserContributions,
    this.totalCurrentUserSubmissions,
    this.links,
    this.status,
    this.owners,
    this.coverPhoto,
    this.previewPhotos,
  });

  String id;
  String slug;
  String title;
  String description;
  DateTime publishedAt;
  DateTime updatedAt;
  DateTime startsAt;
  dynamic endsAt;
  bool featured;
  int totalPhotos;
  List<dynamic> currentUserContributions;
  TotalCurrentUserSubmissions totalCurrentUserSubmissions;
  TopicLinks links;
  String status;
  List<Owner> owners;
  CoverPhoto coverPhoto;
  List<PreviewPhoto> previewPhotos;

  factory Topics.fromJson(Map<String, dynamic> json) => Topics(
        id: json["id"] == null ? null : json["id"],
        slug: json["slug"] == null ? null : json["slug"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        startsAt: json["starts_at"] == null
            ? null
            : DateTime.parse(json["starts_at"]),
        endsAt: json["ends_at"],
        featured: json["featured"] == null ? null : json["featured"],
        totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
        currentUserContributions: json["current_user_contributions"] == null
            ? null
            : List<dynamic>.from(
                json["current_user_contributions"].map((x) => x)),
        totalCurrentUserSubmissions:
            json["total_current_user_submissions"] == null
                ? null
                : TotalCurrentUserSubmissions.fromJson(
                    json["total_current_user_submissions"]),
        links:
            json["links"] == null ? null : TopicLinks.fromJson(json["links"]),
        status: json["status"] == null ? null : json["status"],
        owners: json["owners"] == null
            ? null
            : List<Owner>.from(json["owners"].map((x) => Owner.fromJson(x))),
        coverPhoto: json["cover_photo"] == null
            ? null
            : CoverPhoto.fromJson(json["cover_photo"]),
        previewPhotos: json["preview_photos"] == null
            ? null
            : List<PreviewPhoto>.from(
                json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "slug": slug == null ? null : slug,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "published_at":
            publishedAt == null ? null : publishedAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "starts_at": startsAt == null ? null : startsAt.toIso8601String(),
        "ends_at": endsAt,
        "featured": featured == null ? null : featured,
        "total_photos": totalPhotos == null ? null : totalPhotos,
        "current_user_contributions": currentUserContributions == null
            ? null
            : List<dynamic>.from(currentUserContributions.map((x) => x)),
        "total_current_user_submissions": totalCurrentUserSubmissions == null
            ? null
            : totalCurrentUserSubmissions.toJson(),
        "links": links == null ? null : links.toJson(),
        "status": status == null ? null : status,
        "owners": owners == null
            ? null
            : List<dynamic>.from(owners.map((x) => x.toJson())),
        "cover_photo": coverPhoto == null ? null : coverPhoto.toJson(),
        "preview_photos": previewPhotos == null
            ? null
            : List<dynamic>.from(previewPhotos.map((x) => x.toJson())),
      };
}

class CoverPhoto {
  CoverPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.urls,
    this.links,
    this.categories,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.user,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime promotedAt;
  int width;
  int height;
  String color;
  String blurHash;
  dynamic description;
  String altDescription;
  Urls urls;
  CoverPhotoLinks links;
  List<dynamic> categories;
  int likes;
  bool likedByUser;
  List<dynamic> currentUserCollections;
  dynamic sponsorship;
  Owner user;

  factory CoverPhoto.fromJson(Map<String, dynamic> json) => CoverPhoto(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"] == null ? null : json["width"],
        height: json["height"] == null ? null : json["height"],
        color: json["color"] == null ? null : json["color"],
        blurHash: json["blur_hash"] == null ? null : json["blur_hash"],
        description: json["description"],
        altDescription:
            json["alt_description"] == null ? null : json["alt_description"],
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : CoverPhotoLinks.fromJson(json["links"]),
        categories: json["categories"] == null
            ? null
            : List<dynamic>.from(json["categories"].map((x) => x)),
        likes: json["likes"] == null ? null : json["likes"],
        likedByUser:
            json["liked_by_user"] == null ? null : json["liked_by_user"],
        currentUserCollections: json["current_user_collections"] == null
            ? null
            : List<dynamic>.from(
                json["current_user_collections"].map((x) => x)),
        sponsorship: json["sponsorship"],
        user: json["user"] == null ? null : Owner.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "promoted_at": promotedAt == null ? null : promotedAt.toIso8601String(),
        "width": width == null ? null : width,
        "height": height == null ? null : height,
        "color": color == null ? null : color,
        "blur_hash": blurHash == null ? null : blurHash,
        "description": description,
        "alt_description": altDescription == null ? null : altDescription,
        "urls": urls == null ? null : urls.toJson(),
        "links": links == null ? null : links.toJson(),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x)),
        "likes": likes == null ? null : likes,
        "liked_by_user": likedByUser == null ? null : likedByUser,
        "current_user_collections": currentUserCollections == null
            ? null
            : List<dynamic>.from(currentUserCollections.map((x) => x)),
        "sponsorship": sponsorship,
        "user": user == null ? null : user.toJson(),
      };
}

class CoverPhotoLinks {
  CoverPhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  String self;
  String html;
  String download;
  String downloadLocation;

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) =>
      CoverPhotoLinks(
        self: json["self"] == null ? null : json["self"],
        html: json["html"] == null ? null : json["html"],
        download: json["download"] == null ? null : json["download"],
        downloadLocation: json["download_location"] == null
            ? null
            : json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "download": download == null ? null : download,
        "download_location": downloadLocation == null ? null : downloadLocation,
      };
}

class Urls {
  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"] == null ? null : json["raw"],
        full: json["full"] == null ? null : json["full"],
        regular: json["regular"] == null ? null : json["regular"],
        small: json["small"] == null ? null : json["small"],
        thumb: json["thumb"] == null ? null : json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw == null ? null : raw,
        "full": full == null ? null : full,
        "regular": regular == null ? null : regular,
        "small": small == null ? null : small,
        "thumb": thumb == null ? null : thumb,
      };
}

class Owner {
  Owner({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.acceptedTos,
  });

  String id;
  DateTime updatedAt;
  String username;
  String name;
  String firstName;
  String lastName;
  String twitterUsername;
  String portfolioUrl;
  String bio;
  String location;
  OwnerLinks links;
  ProfileImage profileImage;
  String instagramUsername;
  int totalCollections;
  int totalLikes;
  int totalPhotos;
  bool acceptedTos;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"] == null ? null : json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        username: json["username"] == null ? null : json["username"],
        name: json["name"] == null ? null : json["name"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        twitterUsername:
            json["twitter_username"] == null ? null : json["twitter_username"],
        portfolioUrl:
            json["portfolio_url"] == null ? null : json["portfolio_url"],
        bio: json["bio"] == null ? null : json["bio"],
        location: json["location"] == null ? null : json["location"],
        links:
            json["links"] == null ? null : OwnerLinks.fromJson(json["links"]),
        profileImage: json["profile_image"] == null
            ? null
            : ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"] == null
            ? null
            : json["instagram_username"],
        totalCollections: json["total_collections"] == null
            ? null
            : json["total_collections"],
        totalLikes: json["total_likes"] == null ? null : json["total_likes"],
        totalPhotos: json["total_photos"] == null ? null : json["total_photos"],
        acceptedTos: json["accepted_tos"] == null ? null : json["accepted_tos"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "username": username == null ? null : username,
        "name": name == null ? null : name,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "twitter_username": twitterUsername == null ? null : twitterUsername,
        "portfolio_url": portfolioUrl == null ? null : portfolioUrl,
        "bio": bio == null ? null : bio,
        "location": location == null ? null : location,
        "links": links == null ? null : links.toJson(),
        "profile_image": profileImage == null ? null : profileImage.toJson(),
        "instagram_username":
            instagramUsername == null ? null : instagramUsername,
        "total_collections": totalCollections == null ? null : totalCollections,
        "total_likes": totalLikes == null ? null : totalLikes,
        "total_photos": totalPhotos == null ? null : totalPhotos,
        "accepted_tos": acceptedTos == null ? null : acceptedTos,
      };
}

class OwnerLinks {
  OwnerLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  String self;
  String html;
  String photos;
  String likes;
  String portfolio;
  String following;
  String followers;

  factory OwnerLinks.fromJson(Map<String, dynamic> json) => OwnerLinks(
        self: json["self"] == null ? null : json["self"],
        html: json["html"] == null ? null : json["html"],
        photos: json["photos"] == null ? null : json["photos"],
        likes: json["likes"] == null ? null : json["likes"],
        portfolio: json["portfolio"] == null ? null : json["portfolio"],
        following: json["following"] == null ? null : json["following"],
        followers: json["followers"] == null ? null : json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "photos": photos == null ? null : photos,
        "likes": likes == null ? null : likes,
        "portfolio": portfolio == null ? null : portfolio,
        "following": following == null ? null : following,
        "followers": followers == null ? null : followers,
      };
}

class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  String small;
  String medium;
  String large;

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"] == null ? null : json["small"],
        medium: json["medium"] == null ? null : json["medium"],
        large: json["large"] == null ? null : json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small == null ? null : small,
        "medium": medium == null ? null : medium,
        "large": large == null ? null : large,
      };
}

class TopicLinks {
  TopicLinks({
    this.self,
    this.html,
    this.photos,
  });

  String self;
  String html;
  String photos;

  factory TopicLinks.fromJson(Map<String, dynamic> json) => TopicLinks(
        self: json["self"] == null ? null : json["self"],
        html: json["html"] == null ? null : json["html"],
        photos: json["photos"] == null ? null : json["photos"],
      );

  Map<String, dynamic> toJson() => {
        "self": self == null ? null : self,
        "html": html == null ? null : html,
        "photos": photos == null ? null : photos,
      };
}

class PreviewPhoto {
  PreviewPhoto({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.urls,
  });

  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String blurHash;
  Urls urls;

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        blurHash: json["blur_hash"] == null ? null : json["blur_hash"],
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "blur_hash": blurHash == null ? null : blurHash,
        "urls": urls == null ? null : urls.toJson(),
      };
}

class TotalCurrentUserSubmissions {
  TotalCurrentUserSubmissions();

  factory TotalCurrentUserSubmissions.fromJson(Map<String, dynamic> json) =>
      TotalCurrentUserSubmissions();

  Map<String, dynamic> toJson() => {};
}
