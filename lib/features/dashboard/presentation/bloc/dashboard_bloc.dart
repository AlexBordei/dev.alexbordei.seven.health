import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sevenhealth/features/dashboard/domain/entities/task.dart';
import 'package:sevenhealth/features/dashboard/domain/usecases/get_dashboard_data_use_case.dart';
import 'package:sevenhealth/features/dashboard/domain/usecases/update_task_use_case.dart';
import 'package:sevenhealth/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:sevenhealth/features/dashboard/presentation/bloc/dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase _getDashboardDataUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  DashboardBloc(
    this._getDashboardDataUseCase,
    this._updateTaskUseCase,
  ) : super(const DashboardState()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
    on<RefreshDashboardEvent>(_onRefreshDashboard);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<AddTaskEvent>(_onAddTask);
  }

  Future<void> _onLoadDashboard(
    LoadDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (state.isLoaded) return; // Already loaded

    emit(state.loading());

    final result = await _getDashboardDataUseCase();

    result.fold(
      (failure) => emit(state.error(failure.toString())),
      (data) => emit(DashboardState.fromDashboardData(data)),
    );
  }

  Future<void> _onRefreshDashboard(
    RefreshDashboardEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.loading());

    final result = await _getDashboardDataUseCase();

    result.fold(
      (failure) => emit(state.error(failure.toString())),
      (data) => emit(DashboardState.fromDashboardData(data)),
    );
  }

  Future<void> _onUpdateTask(
    UpdateTaskEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final params = UpdateTaskParams(
      task: event.task,
      isCompleted: event.isCompleted,
    );

    final result = await _updateTaskUseCase(params);

    result.fold(
      (failure) => emit(state.error(failure.toString())),
      (updatedTask) => emit(state.updateTask(updatedTask)),
    );
  }

  Future<void> _onAddTask(
    AddTaskEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // Create a new task with the given details
    final newTask = Task(
      id: DateTime.now()
          .millisecondsSinceEpoch
          .toString(), // Generate a unique ID
      title: event.title,
      isCompleted: false,
      dueDate: DateTime.now(),
      category: event.category,
      priority: event.priority,
    );

    // For now, we'll just update the state without making a server call
    // In a real implementation, you'd call a use case to add the task to the backend
    emit(state.addTask(newTask));
  }
}
