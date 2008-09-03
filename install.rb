# Install hook code here
unless File.directory?("vendor/plugins/active_scaffold")
  print "\n\nInstall Required ActiveScaffold Plugin\n\n"
  system("script/plugin", "install",
    'git://github.com/activescaffold/active_scaffold.git')
end
