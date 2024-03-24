import 'package:json_annotation/json_annotation.dart';

enum MessageType {
  gpt,
  typing,
  image,
  text, 
  @JsonValue('rating_request')
  ratingRequest,
  file
}