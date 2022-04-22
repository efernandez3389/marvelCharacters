# README #

We have decided to build the app under a clean+MVVM architecture. This way, we have separated the code into three different layers: 
* Domain (business logic)
* Data (data repository)
* Presentation (UI layer using MVVM)

We've also used different frameworks to help us during the development: 
* Alamofire (http requests)
* RxSwift (binding between view controllers and view models)
* SDWebImage (manage and downloads images)
* SwiftLint (code style)


### TO DO / IMPROVEMENTS ###
* Add UI Tests
* Add Snapshot testing

* Add character search
* Add character ordering
* Add comic, events, series and/or character stories

### REQUIREMENTS ###
* XCode 12+
* iOS 14.0+
* Swift 5

### SETUP ###
* Clone repository: 
git clone https://github.com/efernandez3389/marvelCharacters.git
* Install dependencies: 
Execute pod install inside project directory
* Open workspace file: 
MarvelApp.xcworkspace
* Have fun!

