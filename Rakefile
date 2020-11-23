
desc 'open Xcode Workspace'
task :xc do
  sh 'open ios/Runner.xcworkspace'
end

desc 'コード生成'
task :gen do
  puts '[Task gen]'
  sh 'flutter pub run build_runner build --delete-conflicting-outputs'
end

desc 'コード生成(watch)'
task :watch do
  puts '[Task watch]'
  sh 'flutter pub run build_runner watch --delete-conflicting-outputs'
end

desc 'i10n生成'
task :i10n do
  puts '[Task i10n]'
  sh 'sh scripts/i10n.sh'
end

desc 'スプラッシュ画像更新'
task :splash do
  puts '[Task splash]'
  sh 'flutter pub run flutter_native_splash:create'
end

desc 'アイコン更新'
task :icon do
  puts '[Task icon]'
  sh 'flutter pub run flutter_launcher_icons:main'
end

desc 'テスト'
task :test do
  puts '[Task test]'
  # flutter unit test
  sh 'flutter test --coverage'
end