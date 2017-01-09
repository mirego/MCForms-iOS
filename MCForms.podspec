Pod::Spec.new do |s|
  s.name        = "MCForms"
  s.version     = "1.0.0"
  s.summary     = "MCForms is a lightweight form UI fields helper"
  s.homepage    = "https://github.com/mirego/MCForms-iOS"
  s.license     = { :type => "MIT" }
  s.authors     = { "gmoledina" => "gulam.moledina@gmail.com" }

  s.requires_arc = true
  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target = "9.0"
  s.source   = { :git => "https://github.com/mirego/MCForms-iOS.git", :tag => s.version }
  s.source_files = "MCForms/**/*.swift"
  s.pod_target_xcconfig =  {
        'SWIFT_VERSION' => '3.0',
  }
end
