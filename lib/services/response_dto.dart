class ResponseDTO {
  final String status;
  final dynamic data;

  ResponseDTO({
    required this.status,
    required this.data,
  });

  factory ResponseDTO.fromJson(Map<String, dynamic> json) {
    return ResponseDTO(
        status: json['status'],
        data: json['data'],
    );
  }
}
