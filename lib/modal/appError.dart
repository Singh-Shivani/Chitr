class ApiError {
  ApiError({
    this.errors,
  });

  List<String> errors;

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        errors: json["errors"] == null
            ? null
            : List<String>.from(json["errors"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errors":
            errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
      };
}
