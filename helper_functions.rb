# Shamelessly taken from kristianmandrup / rails3-templates at http://github.com/kristianmandrup/rails3-templates/blob/master/helper_functions.rb

def unzip_it(http_location, zipfile, folder = nil)
  run "curl -O #{http_location}/#{zipfile}"
  
  if folder 
    run "unzip #{zipfile} -d #{folder}" 
  else 
    run "unzip #{zipfile}"    
  end
    
  run "rm #{zipfile}"
end  

def download_file(http_location, file)
  run "curl -L #{http_location}/#{file} > #{file}"
end
