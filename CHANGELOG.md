# Changelog

## [1.1.0] - 2024-05-07

### Added
- Integrated health data tracking using HealthKit (iOS) and Health Connect (Android)
- Added HealthService to interact with device health data
- Implemented steps counting, water intake tracking, heart rate monitoring, and workout time tracking
- Configured app for required health data permissions
- Updated Android to use FlutterFragmentActivity for Health Connect compatibility

### Changed
- Modified DashboardRepository to use real health data when available
- Updated iOS minimum deployment target to 14.0 for HealthKit compatibility
- Health stats now show real data when permissions are granted, with fallback to mock data

## [1.0.0] - 2024-05-07

### Added
- Initial app release with clean architecture implementation
- Dashboard with health stats, mood tracking, and activity monitoring
- Task management with completion functionality
- Theme system with light/dark modes
- Error handling with Failure classes
- Dependency injection setup with GetIt and Injectable
- Calendar feature with monthly view and upcoming events 