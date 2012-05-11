guard :coffeescript, output: 'spec/javascripts', all_on_start: true do
  watch %r(^spec/coffeescripts/(.*)\.coffee)
end

module CopyJS
  def self.copy
    source = Pathname.new 'spec/coffeescripts'
    dest = Pathname.new 'spec/javascripts'

    Dir['spec/coffeescripts/**/*.js'].each do |file|
      source_path = Pathname.new(file)
      dest_path = dest.join source_path.relative_path_from(source)
      dest_path.dirname.mkpath

      FileUtils.cp source_path, dest_path
    end
  end
end

watch %r(^spec/coffeescripts/(.*)\.js) do
  CopyJS.copy
end
CopyJS.copy

