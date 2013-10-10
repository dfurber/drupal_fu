files = File.join File.dirname(__FILE__), 'drupal', '*'
Dir.glob(files, &method(:require))
