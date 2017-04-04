
Pod::Spec.new do |s|
  s.name             = 'AMTooltip'
  s.version          = '1.0.3'
  s.summary          = 'Simple library to show tooltip.'
 
  s.description      = <<-DESC
                          simple and easy library to show tooltip.
                       DESC

  s.homepage         = 'https://github.com/amirdew/AMTooltip'
  s.screenshots      = 'https://github.com/amirdew/AMTooltip/screenshots_1.png', 'https://github.com/amirdew/AMTooltip/screenshots_2.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'amir khorsandi' => 'khorsandi@me.com' }
  s.source           = { :git => 'https://github.com/amirdew/AMTooltip.git', :tag => s.version.to_s } 

  s.ios.deployment_target = '8.0'

  s.source_files = 'AMTooltip/Classes/**/*'
  
  s.resource_bundles = {
     'AMTooltip' => ['AMTooltip/Assets/*.xib']
  } 

end
