class FilterTaskRequest {
  bool? onlyMyTasks;
  String? status;
  String? priority;
  String? deadline;

  FilterTaskRequest(this.onlyMyTasks, this.status, this.priority, this.deadline);

  Map<String, dynamic> toJson() {
    return {
      'onlyMyTasks': onlyMyTasks,
      'status': status,
      'priority': priority,
      'deadline': deadline,
    };
  }

  FilterTaskRequest copyWith({
    bool? onlyMyTasks,
    String? status,
    String? priority,
    String? deadline,
  }) {
    return FilterTaskRequest(
      onlyMyTasks ?? this.onlyMyTasks,
      status ?? this.status,
      priority ?? this.priority,
      deadline ?? this.deadline,
    );
  }
}