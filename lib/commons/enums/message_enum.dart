enum MessageEnum{
  text('text');


  const MessageEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertMessage on String{
  MessageEnum toEnum(){
    switch(this){
      case 'text':
        return MessageEnum.text;
      default:
        return MessageEnum.text;
    }
  }
}