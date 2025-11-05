**📱 News App**

A modern Flutter news application built with Clean Architecture and BLoC pattern. The app features real-time news fetching from NewsAPI, favorite articles management, and seamless navigation with beautiful UI components.

## App Demo

<img src="https://github.com/user-attachments/assets/e7d0cbd6-8dd9-429f-9c55-862786a95499" width="auto" height="500" alt="App Demo">

## 🚀 Features

- **📰 Real-time News**: Fetch latest headlines from NewsAPI with search and category filtering
- **⭐ Favorites Management**: Save and manage favorite articles with persistent local storage
- **🎨 Modern UI**: Beautiful Material Design 3 interface with custom bottom navigation
- **🔍 Smart Search**: Real-time search across news headlines and content
- **🏗️ Clean Architecture**: Feature-first structure with clear separation of concerns
- **🔄 State Management**: Robust BLoC pattern for predictable state management
- **🧭 Smooth Navigation**: GoRouter for declarative routing with bottom navigation

---

## 🛠️ Tech Stack

### **Frontend & Framework**
- **Flutter 3.0+** - Cross-platform framework
- **Dart 3.0+** - Programming language

### **Architecture & State Management**
- **Clean Architecture** - Data/Domain/Presentation layers
- **flutter_bloc** - State management
- **Equatable** - Value equality

### **Navigation & Routing**
- **go_router** - Declarative routing

### **Networking & APIs**
- **http** - HTTP client for API calls
- **NewsAPI** - News data source
- **json_serializable** - JSON serialization

### **Local Storage**
- **shared_preferences** - Favorite articles persistence

### **Dependency Management**
- **get_it** - Dependency injection

### **Development Tools**
- **build_runner** - Code generation
- **flutter_lints** - Code quality

## 🛠️ Installation & Setup

### **Prerequisites**
- Flutter 3.0 or higher
- Dart 3.0 or higher
- iOS Simulator or Android Emulator
- NewsAPI account (free tier available)

### **Quick Start**

1. **Clone and setup**
```bash
git clone https://github.com/your-username/news-app.git
cd news-app
flutter pub get
```

2. **Configure NewsAPI**
   - Get free API key from [newsapi.org](https://newsapi.org)
   - Update `lib/core/di/injection_container.dart`:
   ```dart
   const newsApiKey = 'YOUR_ACTUAL_API_KEY_HERE';
   ```

3. **Run the application**
```bash
flutter run
```

### **Build for Production**
```bash
flutter build apk --release
flutter build ios --release
```

---

## 🎯 How to Use

### **📖 Reading News**
1. **Browse Headlines**: Open the app to see latest news
2. **Filter by Category**: Tap categories (Business, Tech, Sports, etc.)
3. **Search News**: Use search bar to find specific topics
4. **Read Details**: Tap any article to view full content

### **⭐ Managing Favorites**
1. **Add to Favorites**: Tap ♡ icon on any article detail page
2. **View Favorites**: Switch to Favorites tab in bottom navigation
3. **Remove Favorites**: Tap ♡ again to remove from favorites

### **🔧 Advanced Features**
- **Pull to Refresh**: Swipe down to refresh news list
- **Offline Favorites**: Access saved articles without internet


## 🌟 Future Enhancements

- [ ] Dark theme support
- [ ] Push notifications for breaking news
- [ ] Article sharing functionality
- [ ] Multiple news sources integration
- [ ] Reading history
- [ ] Cross-platform desktop support
