# Clean file map

- `lib/main.dart` — fresh UI and screen flow (fingerprint, landing, login, intro, dashboard)
- `lib/services/auth_api.dart` — dedicated API client
- `assets/images/pinzx_logo.png` — PINZX logo asset
- `assets/videos/pinzx_intro.mp4` — intro video asset
- `api/server.js` — independent authentication API
- `api/.env.example` — deployment configuration template

The app modules and Android package files are newly generated rather than renamed/copied from the previous app. `flutter create --platforms=android .` creates the platform scaffold locally.
