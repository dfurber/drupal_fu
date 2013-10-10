%w{base helper authmap serialize
   session user variable}.each do |file|
  require "drupal/#{file}"
end
