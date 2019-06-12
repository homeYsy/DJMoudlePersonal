#
# Be sure to run `pod lib lint DJMoudlePersonal.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DJMoudlePersonal'
  s.version          = '0.0.1'
  s.summary          = 'DJMoudlePersonal'
  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC
  s.homepage         = 'https://github.com/yangshiyu666/DJMoudlePersonal'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '864745256@qq.com' => '864745256@qq.com' }
  s.source           = { :git => 'https://github.com/yangshiyu666/DJMoudlePersonal.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Example/DJMoudlePersonal/DJPersonalMoudle/**/*'
  s.resource_bundles = {
    'DJMoudlePersonal' => 'Example/DJMoudlePersonal/DJPersonalMoudle/Assets/*.jpg'
  }
  s.dependency 'DJBase','1.0.1'
end
