require 'yaml'
 
# ERB.new allows us to use ERB tags in the YAML
yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'foursquare.yml'))).result)
 
# Merge the "default" section with the section for this environment
config = yaml_data["foursquare"]
FOURSQUARE = config
