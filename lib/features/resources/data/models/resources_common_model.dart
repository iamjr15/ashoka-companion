class ResourcesCommonModel {
  final String url;

  const ResourcesCommonModel({
    required this.url,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ResourcesCommonModel &&
          runtimeType == other.runtimeType &&
          url == other.url);

  @override
  int get hashCode => url.hashCode;

  @override
  String toString() {
    return 'ResourcesCommonModel{' + ' url: $url,' + '}';
  }

  ResourcesCommonModel copyWith({
    String? url,
  }) {
    return ResourcesCommonModel(
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
    };
  }

  factory ResourcesCommonModel.fromMap(Map<String, dynamic> map) {
    return ResourcesCommonModel(
      url: map['url'] as String,
    );
  }

//</editor-fold>
}
