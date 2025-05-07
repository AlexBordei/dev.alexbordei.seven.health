# Seven Health App

A Flutter mobile application for health tracking and monitoring built with clean architecture principles.

## Features

- Clean Architecture design pattern
- Dependency Injection using GetIt and Injectable
- State Management with BLoC pattern
- Comprehensive theming system
- RESTful API client
- Error handling with Failure classes
- Unit testing support
- Health data integration using HealthKit (iOS) and Health Connect (Android)
- Real-time health stats including steps, water intake, heart rate, and workouts

## Health Data Integration

The app integrates with the device's health services:

### iOS (HealthKit)
- Requires iOS 14.0+
- Uses `health` package to connect with Apple HealthKit
- Permissions configured in Info.plist and app capabilities

### Android (Health Connect)
- Integration with Google's Health Connect API
- Requires Android devices with Health Connect app installed
- Permissions declared in AndroidManifest.xml
- Uses FlutterFragmentActivity for Android 14 compatibility

Health data permissions include:
- Step counting
- Water intake tracking
- Heart rate monitoring
- Workout time tracking
- Sleep analysis
- Various body measurements

## Architecture

The project follows Clean Architecture principles with the following layers:

### Core
- `core/di`: Dependency injection setup
- `core/error`: Error handling with Failure classes
- `core/network`: Network client for API communication
- `core/theme`: App theme and styling definitions
- `core/util`: Utility functions and extensions

### Features
Each feature follows the same structure:

#### Domain Layer
- `entities`: Business models for the app
- `repositories`: Repository interfaces (contracts)
- `usecases`: Business logic units

#### Data Layer
- `models`: Data models that extend domain entities
- `repositories`: Implementations of domain repositories
- `datasources`: Data sources (remote, local)

#### Presentation Layer
- `bloc`: State management with BLoC pattern
- `pages`: UI screens
- `widgets`: Reusable UI components

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- Android Studio or VS Code with Flutter extensions

### Installation

1. Clone the repository
   ```
   git clone https://github.com/AlexBordei/dev.alexbordei.seven.health.git
   ```

2. Install dependencies
   ```
   flutter pub get
   ```

3. Generate dependency injection code
   ```
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Run the app
   ```
   flutter run
   ```

## Testing

To run tests:
```
flutter test
```

## Built With

- [Flutter](https://flutter.dev/) - UI framework
- [BLoC](https://bloclibrary.dev/) - State management
- [GetIt](https://pub.dev/packages/get_it) - Dependency injection
- [Injectable](https://pub.dev/packages/injectable) - Code generation for dependency injection
- [Equatable](https://pub.dev/packages/equatable) - Value equality
- [Dartz](https://pub.dev/packages/dartz) - Functional programming features
- [HTTP](https://pub.dev/packages/http) - Network requests

## Project Structure

```
lib/
├── core/
│   ├── di/                   # Dependency injection
│   ├── error/                # Error handling
│   ├── network/              # API client
│   ├── theme/                # App theme
│   └── util/                 # Utilities
├── features/
│   ├── feature1/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   └── feature2/
│       └── ...
└── main.dart
```

## Contributing

Contributions are welcome!

## License

This project is licensed under the MIT License
