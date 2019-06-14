#
# Be sure to run `pod lib lint JZFMDB.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JZFMDB'
  s.version          = '0.1.3'
  # 这里加上你的工程简介
  s.summary          = '这是fmdb封装的demo JZFMDB.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
这是我的一个测试工程，用来演示怎样创建一个源码不公开的静态库
                       DESC
  #项目主页，这里可以放上你的静态库的介绍网页
  s.homepage         = 'https://github.com/Jason8Zhang/JZFMDB'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jason8zhang' => 'zhangzx_326@yeah.net' }
  s.source           = { :git => 'https://github.com/jason8zhang/JZFMDB.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
 #最低iOS系统要求
  s.ios.deployment_target = '9.0'
  # 是否需要项目支持ARC
  s.requires_arc = true
  # 这里声明的存放源文件的地址，就是我们实际写的代码
  s.source_files = 'JZFMDB/Classes/**/*'
  #  资源文件的路径
  # s.resource_bundles = {
  #   'JZFMDB' => ['JZFMDB/Assets/*.png']
  # }
  # 这里声明你需要公开的文件
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # 这个地方注意下，你在工程中要用到的framework,都需要在这里声明
  s.frameworks = 'CoreData'
  # 在项目中我们还会用到一些library，也需要在这里声明，比如sqllite等tbd结尾的
  # s.libraries = 'resolv'
  # 这里可以声明你的静态库依赖的其他静态库
  s.dependency 'BGFMDB'
end
