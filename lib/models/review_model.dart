class Review {
  final String reviewerName;
  final String reviewText;
  final DateTime timestamp;

  Review({
    this.reviewerName = '', // Default non-null string value
    this.reviewText = '', // Default non-null string value
    required this.timestamp,
  });

  // Factory method to create a Review from a JSON object
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      reviewerName: json['reviewerName'] ?? '', // Provide default if null
      reviewText: json['reviewText'] ?? '', // Provide default if null
      timestamp: DateTime.parse(json['timestamp']), // Assuming the timestamp is a string in ISO format
    );
  }

  // Method to convert a Review to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'reviewText': reviewText,
      'timestamp': timestamp.toIso8601String(), // Convert DateTime to string
    };
  }
}
