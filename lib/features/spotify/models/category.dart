class Category {
  String? id;
  String? href;
  List<CategoryIcons>? icons;
  String? name;
  String? type;

  Category({this.id, this.href, this.icons, this.name, this.type});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    href = json['href'];
    if (json['icons'] != null) {
      icons = <CategoryIcons>[];
      json['icons'].forEach((v) {
        icons!.add(new CategoryIcons.fromJson(v));
      });
    }
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['href'] = this.href;
    if (this.icons != null) {
      data['icons'] = this.icons!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class CategoryIcons {
  Null? height;
  String? url;
  Null? width;

  CategoryIcons({this.height, this.url, this.width});

  CategoryIcons.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}
