# recloset

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Project Structure

```
lib
├── data
│   ├── donationsite.dart
│   └── markerdata.dart
├── main.dart
├── models
│   └── reward.dart
├── screens
│   ├── Camera.dart
│   ├── forgotPassword.dart
│   ├── home.dart
│   ├── intro.dart
│   ├── login.dart
│   ├── offlineLocation.dart
│   ├── reward.dart
│   ├── reward_detail.dart
│   └── uploadReward.dart
└── widgets
    ├── basic_lg_button.dart
    ├── bottom_navigation.dart
    ├── online_donation_card.dart
    ├── reward_card.dart
    ├── sign_up_button.dart
    └── status_badge.dart
```
## Flow

### Onboarding Flow
<details>
  <summary><strong>Click to expand/collapse</strong></summary>
  
| Step     | Description                                                             | Image |
|----------|-------------------------------------------------------------------------|--------|
| **Intro** | A brief introduction to the app’s main features.                        | <img src="https://i.imgur.com/deGbBGU.png" height="200"> |
| **Login** | Allows existing users to log in by entering their account information. | <img src="https://i.imgur.com/De1Zep5.png" height="200"> |

</details>

### Home Flow
<details>
  <summary><strong>Click to expand/collapse</strong></summary>
  
| Step                   | Description                                                                 | Image |
|------------------------|-----------------------------------------------------------------------------|--------|
| **Home**               | The main screen where users can access the app’s key features.              | <img src="https://i.imgur.com/f6Vj54B.png" height="200"> |
| **Online Donation Site** | A screen where users can visit an external donation site or view related info. | <img src="https://i.imgur.com/gBF9w7D.mp4" height="200"> |

</details>

### Get Reward Flow
<details>
  <summary><strong>Click to expand/collapse</strong></summary>
  
| Step                  | Description                                                                 | Image |
|-----------------------|-----------------------------------------------------------------------------|--------|
| **Reward List**        | Displays a list of rewards available to the user.                          | <img src="https://i.imgur.com/IdAFtPx.png" height="200"> |
| **Add Donation Receipt** | Allows users to upload a donation receipt to claim a reward.              | <img src="https://i.imgur.com/ilrOR6g.png" height="200"><img src="https://i.imgur.com/SyO8KLt.png" height="200"><img src="https://i.imgur.com/4IfR0YR.png" height="200"> |

</details>

### Map Flow
<details>
  <summary><strong>Click to expand/collapse</strong></summary>
  
| Step                  | Description                                                                    | Image |
|-----------------------|--------------------------------------------------------------------------------|--------|
| **Init View**          | The initial view showing the basic map screen.                                 | <img src="https://i.imgur.com/78Kb6wX.png" height="200"> |
| **Filtering Map Label** | Allows users to filter map labels to view specific types of information.       | <img src="https://i.imgur.com/77WIAHi.png" height="200"><img src="https://i.imgur.com/mOn0pmk.png" height="200"><img src
