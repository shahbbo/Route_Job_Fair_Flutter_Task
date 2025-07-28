# Photo Gallery Flutter App

A modern Flutter application that displays a beautiful photo gallery with staggered grid layout, infinite scroll pagination, and dynamic theme switching. Built with clean architecture and offline support.

## Features

- 🖼️ **Staggered Grid View**: Beautiful masonry-style photo layout
- 🔄 **Infinite Scroll**: Smooth pagination with automatic loading
- 🌓 **Animated Theme Toggle**: Switch between light/dark themes with smooth animations
- 📱 **Responsive Design**: Adapts to different screen sizes
- 🔌 **Offline Support**: Cached photos available when offline
- 🌐 **Network Awareness**: Visual indicator for connection status
- 🎨 **Modern UI**: Clean design with proper Material Design 3 theming

## Screenshots

![Photo List Screen (Online - Light Mode)](Photo%20List%20Screen%20(Online%20-%20Light%20Mode).png)
![Photo List Screen (Online - Dark Mode)](Photo%20List%20Screen%20(Online%20-%20Dark%20Mode).png)
![Photo List Screen (Offline - Light Mode)](Photo%20List%20Screen%20(Offline%20-%20Light%20Mode).png)
![Photo List Screen (Offline - Dark Mode)](Photo%20List%20Screen%20(Offline%20-%20Dark%20Mode).png)
![Loading State](Loading%20State.png)
![Error State](Error%20State.png)

## Architecture

This app follows **Clean Architecture** principles with clear separation of concerns:

```
├── Domain Layer (Business Logic)
│   ├── Entities & Models
│   ├── Repositories (Interfaces)
│   └── Use Cases
├── Data Layer (Data Sources)
│   ├── Models
│   ├── Datasources
│   │  ├── Remote Data Source (API)
│   │  └── Local Data Source (Cache)
│   └── Repository Implementations
└── Presentation Layer (UI)
    ├── Pages
    ├── Widgets
    └── Cubits (Cubit/Bloc)
```

## Key Technical Implementations

### Grid View with Infinite Scroll
- Uses `PagedMasonryGridView` from `flutter_staggered_grid_view`
- Implements `infinite_scroll_pagination` for smooth pagination
- Implements `flutter_staggered_grid_view` for beautiful layouts
- 2-column responsive grid with proper spacing

### Theme System
- **Light Theme**: White scaffold background
- **Dark Theme**: Black scaffold background
- Animated theme switch button with sun/moon icons

### State Management
- **PhotosCubit**: Manages photo loading and pagination
- **ThemeCubit**: Handles theme switching and persistence
- **ConnectivityCubit**: Monitors network status

### Caching & Offline Support
- Photos cached using Hive database
- Automatic fallback to cached data when offline
- Network status indicator in UI

## Dependencies

### Core Dependencies
```yaml
flutter_bloc: ^8.1.3          # State management
cached_network_image: ^3.3.0  # Image caching
hive: ^2.2.3                  # Local database
connectivity_plus: ^5.0.1     # Network status
flutter_staggered_grid_view: ^0.7.0  # Grid layouts
infinite_scroll_pagination: ^4.0.0   # Pagination
dartz: ^0.10.1                       # Functional programming
```

## File Changes Made

### Renamed Files (As Required)
- `photos_api_service.dart` → `photos_remote_data_source.dart`
- Updated all imports and references accordingly

### New Widgets Created
- `PhotoGridItem`: Grid item with 10px border radius
- `AnimatedThemeButton`: Theme toggle with smooth animations
- `AppLogo`: Logo widget (placeholder for future logo image)

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/shahbbo/route_task.git
   cd route_task
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Add your Pexels API key**
    - Edit `lib/core/constants/app_constants.dart`
    - Replace `YOUR_PEXELS_API_KEY` with your actual API key

5. **Run the app**
   ```bash
   flutter run
   ```

## API Configuration

This app uses the Pexels API to fetch photos. To set up:

1. Visit [Pexels API](https://www.pexels.com/api/)
2. Create a free account and get your API key
3. Update the API key in `app_constants.dart`

## Project Structure

```
lib/
├── core/
│   ├── constants/         # App constants and strings
│   ├── di/               # Dependency injection
│   ├── error/            # Error handling
│   └── theme/            # Theme configuration
├── data/
│   ├── datasources/      # Remote & local data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
├── domain/
│   ├── entities/         # Business entities
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business logic
└── presentation/
    ├── pages/            # App screens
    ├── widgets/          # Reusable widgets
    └── cubits/           # State management
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request


## Acknowledgments

- Photos provided by [Pexels](https://www.pexels.com/)
- Built with [Flutter](https://flutter.dev/)
- State management with [Bloc/Cubit](https://bloclibrary.dev/)
