class Plan {
  int planIdx; // 플랜 번호
  String planTitle; // 플랜 제목
  String planDate; // 플랜 지정 날짜
  String planWriteDate; // 플랜 작성 날짜
  int planUserIdx; // 플랜 작성 유저 번호
  List<dynamic> planedArray; // 플랜 항목 배열
  int planState; // 플랜 상태

  Plan({
    required this.planIdx,
    required this.planTitle,
    required this.planDate,
    required this.planWriteDate,
    required this.planUserIdx,
    required this.planedArray,
    required this.planState,
  });

  factory Plan.fromData(Map<String, dynamic> data) {
    return Plan(
      planIdx: data['plan_idx'],
      planTitle: data['plan_title'],
      planDate: data['plan_date'],
      planWriteDate: data['plan_write_date'],
      planUserIdx: data['plan_user_idx'],
      planedArray: data['planed_array'] as List<dynamic>,
      planState: data['plan_state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'plan_idx': planIdx,
      'plan_title': planTitle,
      'plan_date': planDate,
      'plan_write_date': planWriteDate,
      'plan_user_idx': planUserIdx,
      'planed_array': planedArray,
      'plan_state': planState,
    };
  }

  @override
  String toString() {
    return 'Plan{\nplanIdx: $planIdx,\n'
        'planTitle: $planTitle,\n'
        'planDate: $planDate,\n'
        'planWriteDate: $planWriteDate\n'
        'planUserIdx: $planUserIdx\n'
        'planedArray: $planedArray\n'
        'planState: $planState\n}';
  }
}
