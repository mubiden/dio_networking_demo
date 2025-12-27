# Dio Networking Demo

A Flutter application demonstrating a robust networking layer built with Dio, featuring authentication, user management, and clean architecture principles.

## Features

- **Authentication System**: Secure login/signup with token management
- **User Management**: Browse and manage users
- **Network Layer**: Robust HTTP client with retry logic and authentication interceptors
- **Error Handling**: Comprehensive error mapping and failure handling
- **Secure Storage**: Token persistence using Flutter Secure Storage
- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers

## Project Structure
```
lib/
├── core/
│   ├── error/              # Error handling and failures
│   ├── network/            # Dio client and interceptors
│   └── storage/            # Token management
├── features/
│   ├── auth/               # Authentication feature
│   │   ├── data/           # Data sources, models, repositories
│   │   └── presentation/   # UI components
│   ├── home/               # Home screen feature
│   │   └── presentation/   # Home UI
│   └── users/              # Users feature
│       └── data/           # User models and repositories
└── main.dart               # App entry point
```

## Architecture

This project follows **Clean Architecture** principles:

- **Data Layer**: Remote data sources, models, and repository implementations
- **Domain Layer**: Business logic and use cases (to be implemented)
- **Presentation Layer**: UI components and state management

### Core Components

**Network Layer**
- `DioClient`: HTTP client wrapper
- `AuthInterceptor`: Automatic token injection
- `RetryInterceptor`: Automatic request retry on failure
- `Result`: Type-safe API response handling

**Error Handling**
- `Failures`: Domain-level error representation
- `ErrorMapper`: Exception to failure conversion

**Storage**
- `AuthTokenManager`: Secure token persistence

## Getting Started

### Prerequisites

- Flutter SDK: `>=3.0.0`
- Dart SDK: `>=3.0.0`

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.9.0                       # HTTP client
  flutter_secure_storage: ^10.0.0   # Secure token storage
```

### Authentication

The app uses token-based authentication. Tokens are automatically:
- Stored securely after login
- Injected into API requests via `AuthInterceptor`
- Cleared on logout

## Features in Detail

### Authentication
- Login and signup functionality
- Automatic token management
- Persistent authentication state

### Users
- Fetch user lists
- User data models with type-safe parsing

### Home
- Dashboard with status cards
- Quick access to main features

