#
# Adds a constant for every version from config/versions.yml
#
class EbayAPI
  versions_file = File.join(GEM_ROOT, *%w[config versions.yml])
  YAML.load_file(versions_file).each do |group, list|
    list.each do |name, number|
      const_set "#{group.upcase}_#{name.upcase}_VERSION", number
    end
  end
end
