# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

# Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

# Pods for Network
$Alamofire = pod 'Alamofire', '~> 5.5'

# Pods for CodeQuality
$SwiftLint = pod 'SwiftLint', '~> 0.46'

# Pods for UI
$MobilliumBuilders = pod 'MobilliumBuilders', '~> 1.4'
$TinyConstraints = pod 'TinyConstraints', '~> 4.0'

# Helper
$SwiftGen = pod 'SwiftGen', '~> 6.5'
$SwiftEntryKit = pod 'SwiftEntryKit', '~> 2.0'
$IQKeyboardManagerSwift = pod 'IQKeyboardManagerSwift', '~> 6.5'
$KeychainSwift = pod 'KeychainSwift', '~> 20.0'
$MobilliumUserDefaults = pod 'MobilliumUserDefaults', '~> 2.0'

workspace 'Fodamy'

target 'Fodamy' do

  project 'Fodamy.xcodeproj'
  
  # Pods for Fodamy
  $SwiftLint
  $MobilliumBuilders
  $TinyConstraints
  $IQKeyboardManagerSwift
  $KeychainSwift
  $SwiftEntryKit
  $MobilliumUserDefaults

  target 'FodamyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FodamyUITests' do
    # Pods for testing
  end

end

target 'DataProvider' do
  
  project 'DataProvider/DataProvider.xcodeproj'
  
  # Pods for DataProvider
  $Alamofire
  
  target 'DataProviderTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Utilities' do
  
  project 'Utilities/Utilities.xcodeproj'
  
  # Pods for Utilities
  
  target 'UtilitiesTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'UIComponents' do
  
  project 'UIComponents/UIComponents.xcodeproj'
  
  # Pods for UIComponents
  $SwiftLint
  $SwiftEntryKit
  $SwiftGen
  $TinyConstraints
  
  target 'UIComponentsTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
