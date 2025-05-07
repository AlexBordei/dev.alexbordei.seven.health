import 'package:dartz/dartz.dart' hide Task;
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/core/error/failures.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/domain/repositories/dashboard_repository.dart';

class UpdateTaskParams extends Equatable {
  final Task task;
  final bool isCompleted;

  const UpdateTaskParams({
    required this.task,
    required this.isCompleted,
  });

  @override
  List<Object?> get props => [task, isCompleted];
}

@injectable
class UpdateTaskUseCase {
  final DashboardRepository _dashboardRepository;

  UpdateTaskUseCase(this._dashboardRepository);

  Future<Either<Failure, Task>> call(UpdateTaskParams params) async {
    final updatedTask = params.isCompleted
        ? params.task.markAsCompleted()
        : params.task.markAsIncomplete();

    return await _dashboardRepository.updateTask(updatedTask);
  }
}
