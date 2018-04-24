Pod::Spec.new do |s|
	s.name = 'VariousViewsEffects'
	s.summary = 'VariousViewsEffects lets user animate theirs views nicely and easily'
	s.version = '1.1.0'
	s.platform = :ios
	s.license = 'MIT'
	s.author = { '[Artur Rymarz]' => '[artur.rymarz@gmail.com]' }
	s.homepage = 'https://github.com/artrmz/VariousViewsEffects'
	s.source = { :git => 'https://github.com/artrmz/VariousViewsEffects.git', :tag => s.version }
	s.swift_version = "4.1"
	s.ios.deployment_target = '9.0'
	s.source_files = 'Source/*.swift','Source/*/*.swift'
	s.resource_bundles = {"VariousViewsEffects" => 'Source/*.xcassets' }
end