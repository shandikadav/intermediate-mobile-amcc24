class Note {
  final String id;
  final String title;
  final String content;
  final String date;
  final String status;
  final bool isTask;
  final List<String>? completedTasks;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.status,
    this.isTask = false,
    this.completedTasks,
  });

  // Factory method untuk membuat instance dari Firestore DocumentSnapshot
  factory Note.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: data['date'] ?? '',
      status: data['status'] ?? '',
      isTask: data['isTask'] ?? false,
      completedTasks: List<String>.from(data['completedTasks'] ?? []),
    );
  }

  // Method untuk mengonversi instance ke format yang sesuai untuk Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'status': status,
      'isTask': isTask,
      'completedTasks': completedTasks ?? [],
    };
  }
}
