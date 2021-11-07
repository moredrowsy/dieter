# dieter

A Diet Manager

## Requirements

- Flutter SDK

## Development

### Watch for json_serializable changes

```bash
flutter pub run build_runner watch
```

## Build for release

Appbundle and apk

```bash
flutter build appbundle
flutter build apk --split-per-abi
```

Install apk to android emulator

```bash
flutter install
```
