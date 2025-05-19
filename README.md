
# 👚 recloset
![AI Service](./github_images/An%20AI%20service%20that%20helps%20recycle%20or%20donate%20clothes.jpg)


## 💡 Overview - What is Recloset?

Hello everyone, we are **Team Recloset** from GDG on Campus Sookmyung in Korea.

The fashion industry is rapidly expanding both in Korea and worldwide.  
With ever-changing global trends, fast fashion has become a popular way for people to keep up.

However, fast fashion comes with significant drawbacks.  
For example, producing a single cotton T-shirt requires about **2,700 liters of water**.  
Beyond water consumption, fast fashion also contributes to environmental pollution, overconsumption, and growing textile waste.

To address these issues, we propose **Recloset**—an AI-powered service that helps people recycle or donate clothes in a more sustainable and accessible way.

## 💡 Our Solution

Recloset offers a smart and sustainable approach to tackle fast fashion challenges by providing:

1. **AI-powered detection of clothes contamination level**  
   Users can easily analyze the condition of their clothes using AI technology.

2. **Personalized recycling or donation suggestions**  
   Based on the analysis, the service recommends the most suitable action—recycle or donate.

3. **Eco-friendly action tips**  
   Users receive actionable tips to promote sustainable fashion practices and reduce textile waste.

4. **Location-based service for nearby recycling and donation centers**  
   Easily discover nearby recycling or donation centers using integrated map services.

5. **Donation certification and reward system**  
   Users can certify their donations through the platform, earn rewards, and redeem them for various rewards.



## How to Run
> Camera preview works only on Android devices.


APK Download: [Download Here](https://drive.google.com/drive/folders/1RKDA-U6j8zne0D03vt6sYnwWeh4Q79F4)

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management & Utilities**: Provider (planned), Dio, Shared Preferences, Flutter Dotenv
- **Location & Maps**: Google Maps Flutter, Location, Flutter Polyline Points
- **Authentication**: Google Sign-In, Flutter Web Auth 2
- **UI Libraries**: Google Fonts, Cupertino Icons, Dropdown Button 2, Flutter Inset Box Shadow, Syncfusion Flutter Gauges, Dotted Border, Flutter Toast, WebView Flutter, Flutter Flip Card, Image Picker, Camera
- **Permissions & Others**: Permission Handler, Http

## Dependencies

| Package                   | Version    | Description                              |
|---------------------------|------------|-------------------------------------------|
| flutter_flip_card          | ^0.0.4     | Flip card UI                              |
| url_launcher               | ^6.3.1     | Open URLs in the browser or app           |
| google_fonts               | ^6.1.0     | Google Fonts integration                  |
| dio                        | ^5.4.0     | HTTP client                               |
| flutter_polyline_points    | ^2.0.0     | Draw polylines on maps                    |
| google_maps_flutter        | ^2.6.0     | Google Maps SDK                           |
| flutter_dotenv             | ^5.1.0     | Load .env config                          |
| location                   | ^5.0.0     | Device location services                  |
| permission_handler         | ^11.0.0    | Handle permissions                        |
| cupertino_icons            | ^1.0.8     | iOS-style icons                           |
| dropdown_button2           | ^2.3.9     | Advanced dropdown                          |
| image_picker               | ^1.1.2     | Pick images from gallery or camera        |
| dotted_border              | ^2.1.0     | Create dotted borders                     |
| fluttertoast               | ^8.2.12    | Toast messages                            |
| http                       | ^1.4.0     | HTTP requests                             |
| camera                     | ^0.10.6    | Camera integration                        |
| flutter_inset_box_shadow   | ^1.0.8     | Inset shadows                             |
| syncfusion_flutter_gauges  | ^29.1.40   | Radial gauges                             |
| google_sign_in             | ^6.3.0     | Google authentication                     |
| webview_flutter            | ^4.11.0    | Webview integration                       |
| flutter_web_auth_2         | ^4.1.0     | Web authentication flow                   |
| shared_preferences         | ^2.5.3     | Local key-value storage                   |



## Project Structure

```
lib
├── custom_icon_icons.dart
├── data
│   ├── donationsite.dart
│   └── markerdata.dart
├── main.dart
├── models
│   └── reward.dart
├── screens
│   ├── ai_result.dart
│   ├── camera.dart
│   ├── forgotPassword.dart
│   ├── home.dart
│   ├── intro.dart
│   ├── login.dart
│   ├── offlineLocation.dart
│   ├── reward_detail.dart
│   ├── rewardscreen.dart
│   └── uploadReward.dart
└── widgets
    ├── basic_lg_button.dart
    ├── bottom_navigation.dart
    ├── buildphoto.dart
    ├── donationTile.dart
    ├── online_donation_card.dart
    ├── radial_gauge.dart
    ├── reward_card.dart
    ├── sign_up_button.dart
    └── status_badge.dart
```