Pod::Spec.new do |s|

s.name         = "RJKit-Lite"
s.version      = "0.0.0.1"
s.summary      = "RJKit-Lite"
s.homepage     = "https://github.com/shenguanjiejie/RJKit-Lite"
s.license = { :type => 'MIT'}
s.author             = { "shenguanjiejie" => "835166018@qq.com" }
s.social_media_url   = "https://github.com/shenguanjiejie"
s.platform     = :ios, "10.0"
s.source       = { :git => "https://github.com/shenguanjiejie/RJKit-Lite.git", :tag => s.version.to_s }
s.source_files  = "*.*"
s.requires_arc = true
s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }

#s.dependency 'UITextView+Placeholder'
#s.dependency 'SDWebImage'
#s.dependency 'RJVFL'
#s.dependency 'YYText'
#s.dependency 'TYCyclePagerView'
#s.dependency 'DZNEmptyDataSet'
#s.dependency 'YBImageBrowser'
#s.dependency 'IQKeyboardManager'
#s.dependency 'MBProgressHUD'
s.dependency 'RJTableViewAgent'
s.dependency 'TZImagePickerController'
s.dependency 'RSKImageCropper'
s.dependency 'QMUIKit'

#s.subspec 'Catagories' do |ss|
#ss.requires_arc = false
#ss.source_files  = "RJTableViewAgent/RJTableViewAgent/Resource/*.png"
#ss.resources = "RJKit.bundle"

s.subspec 'Fundation' do |ss|
ss.requires_arc = true
ss.source_files  = "Catagories/Fundation/*.{h,m,swift}"
end

s.subspec 'UIKit' do |ss|
ss.requires_arc = true
ss.source_files  = "Catagories/UIKit/*.{h,m}"
s.dependency 'RJKit-Lite/Tools'
end

#end

s.subspec 'Controller' do |ss|
ss.requires_arc = true
ss.source_files  = "Controller/*.{h,m}"
ss.dependency 'RJKit-Lite/Fundation'
ss.dependency 'RJKit-Lite/UIKit'
ss.dependency 'RJKit-Lite/Model'
ss.dependency 'RJKit-Lite/Tools'
end

s.subspec 'Model' do |ss|
ss.requires_arc = true
ss.source_files  = "Model/*.{h,m}"
ss.dependency 'RJKit-Lite/Fundation'
ss.dependency 'RJKit-Lite/Tools'
end

s.subspec 'RJImageController' do |ss|
ss.requires_arc = true
ss.source_files  = "Package/RJImageController/*.{h,m}"
ss.dependency 'RJKit-Lite/Fundation'
ss.dependency 'RJKit-Lite/UIKit'
ss.dependency 'RJKit-Lite/Model'
ss.dependency 'RJKit-Lite/Tools'
ss.dependency 'RJKit-Lite/View'
end

s.subspec 'Tools' do |ss|
ss.requires_arc = true
ss.source_files  = "Tools/*.{h,m}"
ss.dependency 'RJKit-Lite/Fundation'
ss.dependency 'RJKit-Lite/UIKit'
ss.dependency 'RJKit-Lite/Model'
ss.dependency 'RJKit-Lite/View'
end

s.subspec 'View' do |ss|
ss.requires_arc = false
#ss.source_files  = "View/*.{h,m}"
ss.dependency 'RJTableViewAgent/Utils'

ss.subspec 'CollectionCells' do |sss|
sss.requires_arc = true
sss.source_files  = "RJKit-Lite/View/CollectionCells/*.{h,m}"
sss.dependency 'RJKit-Lite/Fundation'
sss.dependency 'RJKit-Lite/UIKit'
sss.dependency 'RJKit-Lite/Tools'
end

ss.subspec 'RJNavigationView' do |sss|
sss.requires_arc = true
sss.source_files  = "RJKit-Lite/View/RJNavigationView/*.{h,m}"
sss.dependency 'RJKit-Lite/Fundation'
sss.dependency 'RJKit-Lite/UIKit'
sss.dependency 'RJKit-Lite/Tools'
end

ss.subspec 'TableViewCells' do |sss|
sss.requires_arc = true
sss.source_files  = "RJKit-Lite/View/RJNavigationView/*.{h,m}"
sss.dependency 'RJKit-Lite/Fundation'
sss.dependency 'RJKit-Lite/UIKit'
sss.dependency 'RJKit-Lite/Tools'
end


end


end
