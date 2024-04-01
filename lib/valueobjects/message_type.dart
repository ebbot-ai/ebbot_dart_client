// ignore_for_file: constant_identifier_names

// MessageType enum is used to define the type of message
// For now, this isn't used, as non-existent types will cause a runtime error
enum MessageType {
  gpt,
  typing,
  image,
  text,
  rating_request,
  file,
  text_info,
  url_click,
  scenario
}
