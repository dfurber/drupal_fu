%w{base helper authmap menu_link menu_router profile_field serialize 
   session session_store url_alias user variable}.each do |file|
  require "drupal/#{file}"
end
