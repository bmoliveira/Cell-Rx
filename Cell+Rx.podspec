Pod::Spec.new do |s|
  s.name         = "Cell+Rx"
  s.version      = "1.2.4"
  s.summary      = "Handy RxSwift extensions on UITableViewCell and UICollectionViewCell."
  s.description  = <<-DESC
    Right now, we just have a `rx_reusableDisposeBag` property, but we're open to PRs!
                   DESC
  s.homepage     = "https://github.com/ivanbruel/Cell-Rx"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ivan Bruel" => "ivan.bruel@gmail.com" }
  s.social_media_url   = "http://twitter.com/ivanbruel"

  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/ivanbruel/Cell-Rx.git", :tag => s.version }
  s.source_files  = "Pod/Classes/*.swift"
  s.frameworks  = "UIKit"
  s.dependency "RxSwift", '~> 4.0'
end
