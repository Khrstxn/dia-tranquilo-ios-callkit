Pod::Spec.new do |s|
  s.name             = 'dia_tranquilo_ios_callkit'
  s.version          = '0.0.1'
  s.summary          = 'Native iOS CallKit integration for Dia Tranquilo.'
  s.description      = <<-DESC
Native iOS integration used by Dia Tranquilo to communicate with
CallKit and the Dia Tranquilo Call Directory Extension.
                       DESC

  s.homepage         = 'https://github.com/Khrstxn/dia-tranquilo-ios-callkit'
  s.license          = { :type => 'Proprietary', :text => 'Copyright Khrstxn. All rights reserved.' }
  s.author           = { 'Khrstxn' => 'diatranquilo.app@gmail.com' }

  s.source           = {
    :git => 'https://github.com/Khrstxn/dia-tranquilo-ios-callkit.git',
    :tag => s.version.to_s
  }

  s.source_files     = 'Classes/**/*'
  s.dependency       'Flutter'
  s.platform         = :ios, '13.4'
  s.swift_version    = '5.0'
  s.frameworks       = 'CallKit'

  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES'
  }
end
