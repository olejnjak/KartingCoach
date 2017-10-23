use_frameworks!
inhibit_all_warnings!

target 'KartingCoach' do
    # Model
    pod 'SwiftGen', '~> 5.1'

    # 3rd parties
    pod 'Firebase', '~> 4.0'
    pod 'TesseractOCRiOS', '~> 4.0'

    target 'KartingCoachTests' do
        inherit! :search_paths
        # Pods for testing
    end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
