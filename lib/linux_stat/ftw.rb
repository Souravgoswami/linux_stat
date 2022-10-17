module LinuxStat
	# Walks through directory and lists files, directories, symbolic links with their sizes.
	# Can also count children (files + directories), files, and directories

	module FTW
		class << self
			##
			# Show info about all directories and files in a given path and under its subdirectories.
			# It accepts two arguments:
			# 	* path: Path is the expanded path that you want to walk through.
			# 	* flags: Flags will give you the ability to tune the output as you desire.
			#          Each flag value can be obtained through LinuxStat::NFTW.constants().
			#          Or you can use LinuxStat::NFTW::FLAGS for readable flags in hash format.
			#          You can do Or-ing to add multiple flags. More info here:
			#          https://man7.org/linux/man-pages/man3/ftw.3.html
			#          If no flags or nil were given as the second argument,
			#          it will use LS::NFTW::FTW_DEPTH | LS::NFTW::FTW_CONTINUE by default.
			#
			# The return value contains a Hash.
			# The hash contains two keys: `error` and a `value`.
			#    * error: If there were any exceptions, the key will be set to true, otherwise false.
			#           Having an error means not all values are listed in the `value` array.
			#    * value: Is an array, it can or cannot be empty regardless of errors.
			#      The `value` key contains an array of Hashes. Each hash contains the following information about a file:
			#          1. type_flag: Type of file.
			#          2. level: Depth of file.
			#          3. st_size: Size of the file in bytes.
			#          4. file_path: Full path of the file.
			#          5. basename:  Offset of the filename (basename component).
			#          6. base:  basename of file.
			#
			# Usage Example:
			#  	 LinuxStat::FTW.stat_all(File.expand_path '~/.rvm/lib/')
			#    => [{:type_flag=>:FTW_F, :level=>1, :st_size=>278, :file_path=>"/home/sourav/.rvm/lib/rvm.rb", :basename=>22, :base=>"rvm.rb"}, {:type_flag=>:FTW_F, :level=>2, :st_size=>286, :file_path=>"/home/sourav/.rvm/lib/rvm/capistrano.rb", :basename=>26, :base=>"capistrano.rb"}, {:type_flag=>:FTW_DP, :level=>1, :st_size=>27, :file_path=>"/home/sourav/.rvm/lib/rvm", :basename=>22, :base=>"rvm"}, {:type_flag=>:FTW_DP, :level=>0, :st_size=>31, :file_path=>"/home/sourav/.rvm/lib", :basename=>18, :base=>"lib"}]
			#
			# Internally calls LinuxStat::NFTW.stat(path, flag).
			def stat_all(path = __dir__, flags = nil)
				LS::NFTW.stat(
					path,
					flags ? flags : LS::NFTW::FTW_DEPTH | LS::NFTW::FTW_CONTINUE
				)
			end

			##
			# Show info about all files in a given path and under its subdirectories.
			# It accepts one argument:
			# 	* path: Path is the expanded path that you want to walk through.
			#
			# The return value contains a Hash.
			# The hash contains two keys: `error` and a `value`.
			#    * error: If there were any exceptions, the key will be set to true, otherwise false.
			#           Having an error means not all values are listed in the `value` array.
			#    * value: Is an array, it can or cannot be empty regardless of errors.
			#      The `value` key contains an array of Hashes. Each hash contains the following information about a file:
			#          1. type_flag: Type of file.
			#          2. level: Depth of file.
			#          3. st_size: Size of the file in bytes.
			#          4. file_path: Full path of the file.
			#          5. basename:  Offset of the filename (basename component).
			#          6. base:  basename of file.
			#
			# Usage Example:
			#  	 LinuxStat::FTW.stat_all(File.expand_path '~/.rvm/lib/')
			#    {:value=>[{:type_flag=>:FTW_F, :level=>1, :st_size=>278, :file_path=>"/home/sourav/.rvm/lib/rvm.rb", :basename=>22, :base=>"rvm.rb"}, {:type_flag=>:FTW_F, :level=>2, :st_size=>286, :file_path=>"/home/sourav/.rvm/lib/rvm/capistrano.rb", :basename=>26, :base=>"capistrano.rb"}], :error=>false}
			#
			# Internally calls LinuxStat::NFTW.stat_files(path).
			def stat_files(path = __dir__)
				LS::NFTW.stat_files(path)
			end

			##
			# Count only files in a given path and under its subdirectories.
			# It accepts one argument:
			# 	* path: Path is the expanded path that you want to walk through.
			#
			# The return value is an Integer.
			# Usage Example:
			#    LinuxStat::FTW.count_files(File.expand_path '~/.rvm/lib')
			#  	 => 2
			#
			# Internally calls LinuxStat::NFTW.count_files(path).
			def count_files(path = __dir__)
				LS::NFTW.count_files(path)
			end

			##
			# Count only directories in a given path and under its subdirectories.
			# It accepts one argument:
			# 	* path: Path is the expanded path that you want to walk through.
			#
			# The return value is an Integer.
			# Usage Example:
			#    LinuxStat::FTW.count_directories(File.expand_path '~/.rvm/lib')
			#  	 => 1
			#
			# Internally calls LinuxStat::NFTW.count_directories(path).
			def count_directories(path = __dir__)
				LS::NFTW.count_directories(path)
			end
		end
	end
end
