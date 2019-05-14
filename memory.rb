require 'json'

class Memory
	def initialize(path)
		@path = path
		
		if @path.end_with?("/")
			@path = "#{@path}conf.json"
		end
		checkFile()
		@cfg_cache = JSON.parse(File.read(@path))
	end

	def checkFile
		unless File.file?( @path ) 
			out_file = File.new(@path, "w")
			out_file.puts("{}")
			out_file.close
		end		
	end
	
	def get(key, default = nil)
		return @cfg_cache.fetch(key, default)
	end
	
	def set(key, value)
		@cfg_cache[key] = value
		out_file = File.new(@path, "w")
		out_file.puts("#{@cfg_cache.to_json}")
		out_file.close
	end
end
#end
