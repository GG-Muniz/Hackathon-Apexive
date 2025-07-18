# Flutter Frontend Service

Flutter web application that provides the user interface for the CRM Social Media Assistant, featuring platform-specific dashboards and real-time social media analysis visualization.

## 🚀 Overview

This Flutter app serves as the frontend interface for monitoring social media mentions, viewing AI-powered analysis, and managing CRM leads. It connects to the Node.js backend service and provides an intuitive dashboard with platform-specific AI persona insights.

## 🛠️ Tech Stack

- **Framework:** Flutter (Web)
- **Language:** Dart
- **UI:** Material Design 3 with custom dark theme
- **Charts:** FL Chart (v0.64.0) for data visualization
- **HTTP Client:** http package
- **Architecture:** StatefulWidget with services layer

## 📁 App Structure

```
lib/
├── main.dart                           # App entry point & MaterialApp setup
├── screens/
│   ├── login_screen.dart              # Authentication interface
│   ├── dashboard_screen.dart          # Main dashboard with platform selection
│   ├── platform_analytics_screen.dart # Platform-specific analytics dashboard
│   └── mention_analytics_screen.dart  # Individual mention analysis
├── services/
│   └── api_service.dart               # Backend API communication
└── widgets/
    └── persona_chat_widget.dart       # AI chat interface
```

## ⚙️ Setup & Installation

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- Chrome or other web browser for development
- Running backend service (see [backend README](../backend_service/README.md))

### Installation

```bash
# Navigate to Flutter app directory
cd crm_social_media_assistant/frontend_service

# Install dependencies
flutter pub get

# Enable Flutter web (if not already enabled)
flutter config --enable-web
```

### Running the Application

```bash
# Run in debug mode
flutter run -d web

# Run in release mode
flutter run -d web --release

# Specify custom port
flutter run -d web --web-port 8080
```

Application will be available at http://localhost:[port] (default varies)

## 🎨 User Interface

### Login Screen
- Clean Material Design 3 interface
- Email and password authentication
- Error handling for connection issues
- Responsive design for web browsers

### Dashboard Screen
- **Platform Selection:** Toggle between Twitter, LinkedIn, Instagram, Facebook
- **AI Persona Integration:** Display platform-specific analysis from backend personas
- **Real-time Data:** Fetch and display social media mentions
- **Analytics Navigation:** Direct access to detailed analytics for each platform and mention
- **Lead Management:** Create CRM leads directly from mentions
- **Dark Theme:** Professional dark theme with warm sand accents (#DAC0A7, #FFF2D7)

### Platform Analytics Screen
- **Comprehensive Metrics:** Total mentions, sentiment analysis, lead generation tracking
- **Interactive Charts:** Line charts for trends, pie charts for sentiment, bar charts for keywords
- **Time Range Selection:** 7-day, 30-day, and 90-day analytics periods
- **AI Insights:** Platform-specific recommendations and strategic analysis
- **Floating Chat:** AI persona consultation widget

### Mention Analytics Screen
- **Individual Analysis:** Detailed breakdown of specific social media mentions
- **Engagement Metrics:** Reach, likes, shares, comments, and interaction tracking
- **Sentiment Classification:** Positive, negative, neutral sentiment with visual indicators
- **Lead Qualification:** AI-powered lead scoring and priority assignment
- **Recommended Actions:** Contextual action suggestions for engagement optimization

### Platform Icons
- Twitter: `@` symbol (`Icons.alternate_email`)
- LinkedIn: Business icon (`Icons.business`)
- Instagram: Camera icon (`Icons.camera_alt`)
- Facebook: Group icon (`Icons.group`)

## 🔗 API Integration

### ApiService Class
Located in `lib/services/api_service.dart`

```dart
class ApiService {
  static const String baseUrl = 'http://localhost:3000';
  
  // Authentication
  Future<Map<String, dynamic>> login(String email, String password)
  
  // Social media analysis
  Future<List<dynamic>> getAnalyzedMentions(String platform)
  
  // CRM integration
  Future<bool> createLead(String contactName, String description)
}
```

### Backend Endpoints Used
- `POST /api/login` - User authentication
- `GET /analyze-mentions-mock` - Development data (recommended)
- `GET /analyze-mentions` - Live social media data
- `POST /create-lead` - CRM lead creation

## 🎯 Features

### Current Features
- ✅ Platform-specific dashboard views
- ✅ Interactive analytics dashboards with charts
- ✅ AI persona chat consultation
- ✅ Backend API integration
- ✅ Dark theme with warm sand color palette
- ✅ Responsive web interface
- ✅ Error handling for API calls
- ✅ Individual mention detailed analysis
- ✅ Time-range analytics filtering
- ✅ Context-aware AI responses

### Recent Updates
- ✨ **Analytics Enhancement** - Comprehensive analytics with FL Chart integration
- ✨ **AI Chat Functionality** - Interactive chat with platform-specific personas
- ✨ **Color Palette Refresh** - Warm sand accents replacing gold theme
- ✨ **UI Improvements** - Fixed text visibility and header prominence issues

## 🔧 Development

### Code Structure

#### main.dart
- App configuration and theming
- Material Design 3 setup
- Navigation to LoginScreen

#### screens/login_screen.dart
- User authentication interface
- Form validation
- API error handling

#### screens/dashboard_screen.dart
- Platform selection interface
- Data visualization
- AI persona insights display
- Lead creation functionality

#### services/api_service.dart
- HTTP client configuration
- Backend API communication
- Error handling and response parsing

### State Management
- Uses StatefulWidget for local state
- ApiService for backend communication
- Future builders for async data loading

### Styling & Theming
- Material Design 3 with custom color scheme
- Consistent theming across all screens
- Responsive design patterns
- Platform-specific iconography

## 🧪 Development Tools

### Flutter Development Tools

```bash
# Hot reload (automatic in debug mode)
# Press 'r' in terminal for manual hot reload
# Press 'R' for hot restart

# Flutter inspector (browser dev tools)
# Open browser dev tools and look for Flutter tab

# Widget inspector
flutter inspector

# Performance analysis
flutter run --profile -d web
```

### Testing

```bash
# Run unit tests
flutter test

# Run integration tests (when available)
flutter drive --target=test_driver/app.dart
```

### Building for Production

```bash
# Build for web deployment
flutter build web

# Output will be in build/web/
# Deploy contents to web server
```

## 🔧 Configuration

### Environment Configuration
Update `ApiService.baseUrl` in `lib/services/api_service.dart`:

```dart
// Development
static const String baseUrl = 'http://localhost:3000';

// Production
static const String baseUrl = 'https://your-api-domain.com';
```

### Web Configuration
Files in `web/` directory:
- `index.html` - Main HTML template
- `manifest.json` - PWA configuration

## 🚀 Deployment

### Web Hosting Options
- **Firebase Hosting:** `firebase deploy`
- **Netlify:** Drag and drop `build/web` folder
- **GitHub Pages:** Upload `build/web` contents
- **Vercel:** Connect GitHub repository

### Pre-deployment Checklist
1. Update API base URL for production
2. Test all features in release mode
3. Verify CORS configuration on backend
4. Test responsive design on multiple screen sizes
5. Validate error handling with offline backend

## 🔍 Troubleshooting

### Common Issues

1. **CORS Errors**
   - Ensure backend service has CORS enabled
   - Check backend is running on http://localhost:3000

2. **Flutter Web Not Working**
   ```bash
   flutter config --enable-web
   flutter create . --platforms web
   ```

3. **Hot Reload Issues**
   - Try hot restart (Ctrl+Shift+F5 or 'R' in terminal)
   - Clear browser cache
   - Restart Flutter development server

4. **API Connection Failed**
   - Verify backend service is running
   - Check network connectivity
   - Inspect browser console for detailed errors

### Debug Information
- Enable Flutter web debugging in browser dev tools
- Check console for API response details
- Use Flutter inspector for widget debugging

## 📱 Responsive Design

The app is designed for web browsers with:
- Minimum width: 320px (mobile)
- Optimal width: 1024px+ (desktop)
- Flexible layouts using Flutter's responsive widgets
- Platform-appropriate interaction patterns

## 🔄 Data Flow

1. **User Interaction** → Flutter UI
2. **API Service** → HTTP requests to backend
3. **Backend Analysis** → AI persona insights
4. **State Update** → Flutter widget rebuilding
5. **UI Refresh** → Updated data display

## 📝 Development Notes

- Use mock endpoints during development to avoid API rate limits
- Platform selection affects which AI persona insights are displayed
- All API calls include error handling with user-friendly messages
- Material Design 3 theming is consistent across the app
- State management is kept simple with StatefulWidget patterns

## 🎨 AI Personas

The application features platform-specific AI personas for consultation:

### Echo (Twitter) ⚡
- **Specialty:** Real-Time Response Specialist
- **Focus:** Trending topics, viral content, rapid engagement
- **Color Scheme:** Twitter blue gradient

### Sterling (LinkedIn) 🧠
- **Specialty:** B2B Lead Intelligence Expert
- **Focus:** Professional networking, lead generation, industry insights
- **Color Scheme:** LinkedIn blue gradient

### Vibe (Instagram) ✨
- **Specialty:** Creative Engagement Guru
- **Focus:** Visual storytelling, hashtag strategies, influencer marketing
- **Color Scheme:** Instagram pink/red gradient

### Harmony (Facebook) 💫
- **Specialty:** Community Growth Specialist
- **Focus:** Community building, local business, audience engagement
- **Color Scheme:** Facebook blue gradient

## 📊 Analytics Features

### Chart Types
- **Line Charts:** Mention volume trends over time periods
- **Pie Charts:** Sentiment distribution visualization
- **Bar Charts:** Top keywords and engagement metrics

### Key Metrics
- **Mention Volume:** Total mentions tracked across platforms
- **Sentiment Score:** Positive sentiment percentage analysis
- **Lead Generation:** Qualified leads identified and created
- **Engagement Rates:** Platform-specific interaction metrics

### AI Insights
- **Peak Engagement:** Optimal posting times and audience activity
- **Content Recommendations:** Performance-based content suggestions
- **Attention Alerts:** Issues requiring immediate action or response

## 👥 Authors

- **Gabriel Garcia Muniz** - [GitHub](https://github.com/GG-Muniz)
- **Fernando Lockwood** - [GitHub](https://github.com/flockwood)