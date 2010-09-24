#----------------------------------------------------------------------------
# Git Setup
#----------------------------------------------------------------------------
file '.gitignore', <<-FILE
.DS_Store
**/.DS_Store
log/*
tmp/*
tmp/**/*
config/database.yml
coverage/*
coverage/**/*
.bundle/**
.bundle/*
webrat.log
*.orig
public/system**/*
sunspot-solr.pid
db/*.sqlite3
FILE

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"