Pod::Spec.new do |s|
  s.name     = 'AutoTag'
  s.version  = '1.2'
  s.license  = 'MIT'
  s.summary  = 'An atuo fit size tagView on iOS.'
  s.homepage = 'https://github.com/ChinaChong/AutoTag'
  s.authors  = { '高崇' => 'chinachong1943@yahoo.com' }
  s.source   = { :git => 'https://github.com/ChinaChong/AutoTag.git', :tag => s.version }
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
  s.source_files = 'AutoTag/*.{h,m}'
end
