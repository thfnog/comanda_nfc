abstract class Register {

  final String uid;
  final String title;
  final String name;
  final String document;
  final Map<String, String> additionalInfo;

  Register(this.uid, this.additionalInfo, {
    required this.title,
    required this.name,
    required this.document
  });

}
