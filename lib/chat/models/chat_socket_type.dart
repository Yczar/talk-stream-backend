/// An enum that represents the different types of messages that can be sent
/// over the chat socket.
enum ChatSocketType {
  /// Represents a message that is being sent.
  sendMessage('__send__');

  /// Constructs a constant instance of the enum with the specified value.
  const ChatSocketType(this.value);

  /// The value associated with the enum instance.
  final String value;
}
