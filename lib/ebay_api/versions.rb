#
# Adds a constant for every version from config/versions.yml
#
class EbayAPI
  YAML.load_file("config/versions.yml").each do |group, list|
    list.each do |name, number|
      const_set "#{group.upcase}_#{name.upcase}_VERSION", number
    end
  end
end
