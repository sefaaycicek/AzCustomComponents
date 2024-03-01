# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'AzCustomComponents' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for AzCustomComponents
  

end


post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
      config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
    end
  installer.generated_projects.each do |project|
         project.targets.each do |target|
             target.build_configurations.each do |config|
                 config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
             end
         end
     end
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
      end
  end
  installer.pods_project.targets.each do |target|
    if target.name == 'RxSwift'
      target.build_configurations.each do |config|
        if config.name == 'Staging'
          config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES', '$(inherited)', '-Onone']
          config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
        end
      end
    end
  end
end
