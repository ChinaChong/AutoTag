Pod::Spec.new do |s|
s.name = 'AutoTag'
s.version = '1.0'
s.license = 'MIT'
s.summary = 'An atuo fit size tagView on iOS.'
s.homepage = 'https://github.com/ChinaChong/AutoTag'
s.authors = { '高崇' => 'chinachong1943@yahoo.com' }
s.source = { :git => 'https://github.com/ChinaChong/AutoTag.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = 'AutoTag/*.{h,m}'
s.resources = ['AutoTag/Sample/AutoTag/Assets.xcassets]
end