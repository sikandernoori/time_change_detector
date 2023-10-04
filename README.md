# Time change detector.

## About
A flutter plugin to detect change in device time, date and timezone for Android and IOS.

## Settings

### Android
- minSdkVersion: 21

- targetSdkVersion: 31

Your AndroidManifest.xml file should look like this:

```
  <application
	           ...
                <receiver
                  android:name="com.randomforest.time_change_detector.TimeChangeDetectorPlugin"
                  android:exported="true">
                  <intent-filter>
                      <action android:name="android.intent.action.TIME_SET" />
                      <action android:name="android.intent.action.TIMEZONE_CHANGED" />
                      <action android:name="android.intent.action.DATE_CHANGED"/>
                  </intent-filter>
              </receiver>
        <activity
		         ...

```

### IOS

- In XCode change swift version to 5
- Update Podfile change IOS target to 10.0

## TODO

- [ ] Run time detector even app is completely closed.
- [ ] Update Readme.md


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://github.com/sikandernoori/time_change_detector/blob/master/LICENSE)
