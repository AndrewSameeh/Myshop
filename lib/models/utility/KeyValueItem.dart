class BaseClass {
  BaseClass();
  BaseClass.fromJson(Map<String, dynamic> json);
}

class KeyValueItem extends BaseClass {
  final int key;
  final String value;
  KeyValueItem({this.key, this.value});

  Map<String, dynamic> toJson() => _$KeyValueItemToJson(this);
  Map<String, dynamic> _$KeyValueItemToJson(KeyValueItem instance) =>
      <String, dynamic>{
        'Key': instance.key,
        'Value': instance.value,
      };

  @override
  factory KeyValueItem.fromJson(Map<String, dynamic> json) {
    return KeyValueItem(
      key: json['Key'] as int,
      value: json['Value'] as String,
    );
  }
}
