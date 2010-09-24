run 'rm public/javascripts/jquery.watermark.js'
file "public/javascripts/jquery.watermark.js", File.open("#{@@base_path}resources/jquery.watermark.js", "rb"){|file| file.read}

run 'rm public/stylesheets/chaione.css'
file "public/stylesheets/chaione.css", File.open("#{@@base_path}resources/chaione.css", "rb"){|file| file.read}


if @blueprint
  run 'git clone git://github.com/joshuaclayton/blueprint-css.git'
  run 'mv blueprint-css/blueprint/ public/stylesheets/blueprint'
  run 'rm -rf blueprint-css/'
end

if @nine_sixty
  run 'git clone git://github.com/nathansmith/960-Grid-System.git'
  run 'mv 960-Grid-System/code/css public/stylesheets'
  run 'rm -rf 960-Grid-System'
end