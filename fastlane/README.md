fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios sync_codesign_debug
```
fastlane ios sync_codesign_debug
```

### ios sync_codesign_alpha
```
fastlane ios sync_codesign_alpha
```

### ios sync_codesign_release
```
fastlane ios sync_codesign_release
```

### ios renew_debug_codesign
```
fastlane ios renew_debug_codesign
```

### ios renew_alpha_codesign
```
fastlane ios renew_alpha_codesign
```

### ios renew_release_codesign
```
fastlane ios renew_release_codesign
```

### ios common_build
```
fastlane ios common_build
```
common build
### ios debug_test
```
fastlane ios debug_test
```
build debug
### ios alpha
```
fastlane ios alpha
```
build alpha
### ios release
```
fastlane ios release
```
build release
### ios build_number_bump
```
fastlane ios build_number_bump
```

### ios upload_to_firebase
```
fastlane ios upload_to_firebase
```

### ios alpha_upload_to_firebase
```
fastlane ios alpha_upload_to_firebase
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
