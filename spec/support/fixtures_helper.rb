def fixture_file_path(filename)
  File.expand_path "spec/fixtures/#{filename}"
end

def open_fixture_file(filename)
  File.open fixture_file_path(filename)
end

def read_fixture_file(filename)
  File.read fixture_file_path(filename)
end

def yaml_fixture_file(filename)
  YAML.load_file(fixture_file_path(filename))
end

def json_fixture_file(filename)
  JSON.parse(read_fixture_file(filename))
end

def uploaded_fixture_file(filename)
  Rack::Test::UploadedFile.new fixture_file_path(filename)
end
