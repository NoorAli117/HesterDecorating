# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'HasterApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'Alamofire'
  pod 'SideMenuSwift'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'DropDown'
  pod "RappleProgressHUD"
  #  pod 'ModernSearchBar', '1.2'
  pod 'DLRadioButton'
  pod 'ActionSheetPicker-3.0'
  pod 'IQKeyboardManagerSwift'
  
  pod 'ModernSearchBar', :inhibit_warnings => true, :git=> 'https://github.com/rivera-ernesto/ModernSearchBar.git'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
