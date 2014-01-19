Pod::Spec.new do |s|
  s.name     = 'FileMD5Hash'
  s.version  = '1.0.0'
  s.license  = 'Apache'
  s.summary  = 'Library for computing MD5 hashes of files with small memory usage.'
  s.homepage = 'http://www.joel.lopes-da-silva.com/2010/09/07/compute-md5-or-sha-hash-of-large-file-efficiently-on-ios-and-mac-os-x/'
  s.author   = { 'Joel Lopes Da Silva' => 'joel@lopes-da-silva.com' }
  s.source   = { :git => 'https://github.com/JoeKun/FileMD5Hash.git', :tag => '1.0.0' }

  s.prefix_header_file = 'Common/FileMD5Hash_Prefix.pch'
  s.source_files = 'Common/*.{h,c}'

end
