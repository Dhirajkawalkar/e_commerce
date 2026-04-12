# 🚀 PROJECT RULES - ECOMMERCE APP

## 🧱 Architecture
- Feature-first architecture
- BLoC for state management
- Repository pattern mandatory
- Services handle API calls only

## 📂 Folder Rules
- Each feature must have: data, domain, presentation
- No cross-feature direct dependency

## 🧠 BLoC Rules
- One Bloc per feature
- Use Events and States properly
- No business logic in UI

## 🔌 API Rules
- All API calls go through services
- Repository handles transformation
- Always handle error states

## 🎨 UI Rules
- Use consistent padding (8, 16, 24)
- Use reusable widgets
- Avoid hardcoded values

## ⚠️ Error Handling
- Show loading state
- Show error message
- Handle no internet

## 🧪 Code Quality
- Use Equatable in states
- Proper naming conventions
- Keep files small and focused


## 🧾 Model Rules
- All models must have:
  - fromJson()
  - toJson()
- No dynamic types allowed
- Use proper typing (String, int, double, etc.)

## 🔄 Data Flow Rules
- UI → Bloc → Repository → Service → API
- Response must follow same path back
- No shortcut calls allowed

## 📦 Repository Rules
- Repository must return clean models (not raw JSON)
- Handle null safety properly
- Convert API response to models

## 🌐 Service Rules
- Only API call logic
- No business logic
- Must return raw response

## 🎯 Bloc Rules
- Must handle:
  - Loading state
  - Success state
  - Error state
  - No direct API calls in Bloc

## 🧩 UI Rules
- Screen = full page
- Widgets = reusable components
- No logic inside widgets

## 🧼 Clean Code Rules
- Max file size: ~200 lines
- One responsibility per file
- Meaningful naming only

## 🚫 Strict Restrictions
- No hardcoded API data
- No direct HTTP calls in UI
- No business logic in UI
- There should be no flutter warnings for ex, withopacity is deprycated and etc
- while a folder has gitKeep and a new file comes in that folder, remove the gitKeep file then 