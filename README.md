

# SOSFinder – Emergency Contact App

## 📌 **Project Overview**

**SOSFinder** is an iOS application developed to provide instant access to local emergency numbers (Police, Ambulance, Fire Brigade) based on the user's location. Designed with international travelers and expatriates in mind, the app addresses a critical problem: during an emergency, not knowing which number to dial can cost precious seconds. SOSFinder solves this by combining real-time location data with a clean, intuitive interface for fast, stress-free access to help.

## 🚀 **Key Features**

- **Automatic Location Detection**: Instantly detects the user’s current country using GPS.
- **Localized Emergency Numbers**: Retrieves up-to-date emergency numbers based on location via [EmergencyNumberAPI](https://emergencynumberapi.com/).
- **One-Tap Emergency Calling**: Initiate a call to the Police, Ambulance, or Fire Brigade with a single tap.
- **Map Integration**: Displays the user’s real-time location using MapKit with customizable map styles (Standard, Satellite, Hybrid).
- **Haptic Feedback**: Confirms when an emergency call is initiated.
- **Disabled Buttons**: Clearly indicates which emergency services are unavailable in certain regions.
- **Accessible Design**: Interface optimized for use under stress, with large tap areas and intuitive icons.

## 🛠️ **Technologies Used**

- **SwiftUI**: Modern UI framework used to create responsive, adaptive layouts.
- **UIKit**: Used via `UIApplication` for call handling and `UIImpactFeedbackGenerator` for haptic feedback.
- **CoreLocation**: Determines the user’s geographic position to fetch relevant emergency numbers.
- **MapKit**: Displays the user’s current location and surroundings in real-time.
- **EmergencyNumberAPI**: External service providing country-specific emergency contacts dynamically.

## 🎯 **Target Users**

- International travelers and tourists  
- Expats living in foreign countries  
- People who often move between countries  
- Anyone who may face emergencies in unfamiliar locations  

## 🌐 **Why SOSFinder?**

- **Speed**: Direct access to help with just two taps
- **Simplicity**: Clean UI and icon-based navigation reduce confusion in emergencies
- **Reliability**: Always provides the correct emergency number for the country you're in
- **Scalability**: Designed with modular components to allow for future features like offline support or alerting trusted contacts

## 🌱 **Future Improvements**

- **Offline Mode**: Access previously fetched emergency numbers without an internet connection
- **Multilingual Interface**: Support for multiple languages for broader accessibility
- **SOS Alerts**: Ability to send location-based alerts to predefined contacts
- **Voice Assistance**: Hands-free mode for added accessibility

## 🤝 **Contributions**

Contributions, bug reports, and feature suggestions are welcome. Feel free to open an issue or submit a pull request — every improvement can help save lives.

## 📄 **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

🛟 **SOSFinder** — Because in an emergency, knowing who to call should never be a barrier.  
Your location. Your safety. One tap away.
