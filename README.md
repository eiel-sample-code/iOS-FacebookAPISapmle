# FacebookSample

iOSでFacebookにフィード投稿するサンプルです。
事前にFacebookでアプリケーションの登録が必要で、登録後に発行される `App ID` が必要になります。

https://developers.facebook.com/apps/

## 使い方

* CocoaPodsを利用しています。あらかじめ[CocoaPods](http://ios.eiel.info/CocoaPods)のインストールを行ってください。

```bash
gem install cocoapods
pod setup
```

* 本プロジェクトをclone後にプロジェクトディレクトリで以下を実行してください。

```bash
pod install
```

* 実行後は FacebookSample.xcworkspaceを開いてください。
* ALAppDelegate.h 9行目を取得した APP_ID に書き換えてください。
* FacebookSample-Info.plistの URL types > Item 0 > URL Schemes > Item 0 に 先頭に `fb` をつけた `APP_ID` を設定してください。

# リンク

* https://developers.facebook.com/docs/mobile/ios/build/
* http://ios.eiel.info/Facebook
