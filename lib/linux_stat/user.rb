module LinuxStat
	# Shows various User related information of the current system.

	module User
		class << self
			##
			# Returns an array of users as string
			#
			# For example:
			#   ["root", "bin", "daemon", "mail", "ftp", "http", "nobody"]
			#
			# But if the status isn't available it will return an empty Array.
			def list
				return [] unless passwd_readable?
				passwd.map { |x| x[/.+?:/][0..-2].freeze }
			end

			##
			# Returns all the Group ids directories as Hash.
			#
			# For example:
			#    {:root=>{:uid=>0, :gid=>0}, :bin=>{:uid=>1, :gid=>1}, :daemon=>{:uid=>2, :gid=>2}, :mail=>{:uid=>8, :gid=>12}, :ftp=>{:uid=>14, :gid=>11}}
			#
			# But if the status isn't available it will return an empty Hash.
			def ids
				return {} unless passwd_readable?
				passwd_splitted.reduce({}) { |h, x|
					h.merge!(x[0].to_sym => {
						uid: x[2].to_i, gid: x[3].to_i
					})
				}
			end

			##
			# Returns all the user IDs as Hash.
			#
			# For example:
			#    LinuxStat::User.uids
			#    => {:root=>0, :bin=>1, :daemon=>2, :mail=>8, :ftp=>14}
			#
			# But if the status isn't available it will return an empty Hash.
			def uids
				return {} unless passwd_readable?
				passwd_splitted.reduce({}) { |h, x|
					h.merge!(x[0].to_sym => x[2].to_i)
				}
			end

			##
			# Returns all the Group identifiers as Hash.
			#
			# For example:
			#    LinuxStat::User.gids
			#
			#    => {:root=>0, :bin=>1, :daemon=>2, :mail=>12, :ftp=>11}
			#
			# But if the status isn't available it will return an empty Hash.
			def gids
				return {} unless passwd_readable?

				passwd_splitted.reduce({}) { |h, x|
					h.merge!(x[0].to_sym => x[3].to_i)
				}
			end

			##
			# Returns all the home directories as Hash.
			#
			# For example:
			#    LinuxStat::User.home_directories
			#
			#    => {:root=>"/root", :bin=>"/", :daemon=>"/", :mail=>"/var/spool/mail", :ftp=>"/srv/ftp", :http=>"/srv/http", :nobody=>"/"}
			#
			# But if the status isn't available it will return an empty Hash.
			def home_directories
				return {} unless passwd_readable?
				passwd.reduce({}) { |h, x|
					splitted = x.split(?:)
					h.merge!(splitted[0].to_sym => splitted[5])
				}
			end

			##
			# Returns the user ID as integer
			#
			# It directly calls LinuxStat::Sysconf.get_uid and LinuxStat::Sysconf.get_gid
			#
			# and then reads /etc/passwd and matches the values with UID and GID.
			#
			# It doesn't get affected with the assignment of USER environment variable
			#
			# If either /etc/passwd is readable or LinuxStat::Sysconf.get_login() is not empty.
			#
			# But if /etc/passwd isn't readable (which is weird), it will fall back to sysconf.h's get_login()
			# If that's not available, like in docker, falls back to ENV['USER].to_s
			#
			# It should return the username under most robust circumstances.
			# But if nothing is available for some reason, it will return an empty String.
			#
			# Note that this is not cached or memoized so use this at your own processing expense.
			def get_user
				unless passwd_readable?
					_l = LinuxStat::Sysconf.get_login().freeze
					return _l.empty? ? ENV['USER'.freeze].to_s : _l
				end

				uid, gid = LinuxStat::Sysconf.get_uid, LinuxStat::Sysconf.get_gid

				username = ''.freeze
				passwd.each { |x|
					splitted = x.split(?:).freeze
					if splitted[2].to_i == uid && splitted[3].to_i == gid
						username = splitted[0]
						break
					end
				}
				username
			end

			##
			# Returns the user ID as integer
			#
			# It directly calls LinuxStat::Sysconf.get_uid
			def get_uid
				LinuxStat::Sysconf.get_uid
			end

			##
			# Returns the group ID as integer
			#
			# It directly calls LinuxStat::Sysconf.get_uid
			def get_gid
				LinuxStat::Sysconf.get_gid
			end

			##
			# Returns the effective user ID as integer
			#
			# It directly calls LinuxStat::Sysconf.get_euid
			def get_euid
				LinuxStat::Sysconf.get_euid
			end

			##
			# Calls LinuxStat::Sysconf.get_login()
			#
			# The username is returned as a String.
			#
			# It doesn't get affected by ENV['USER]
			#
			# But if the name isn't available (say inside a container), it will return an empty String.
			#
			# This is meant for speed but not for reliability.
			# To get more reliable output, you might try LinuxStat::User.get_user()
			def get_login
				LinuxStat::Sysconf.get_login
			end

			##
			# = def usernames_by_uid(gid = get_uid)
			#
			# Where uid is the group id of the user. By default it's the uid of the current user.
			#
			# It returns an Array containing the username corresponding to the uid.
			#
			# For example:
			#    LinuxStat::User.usernames_by_uid(1001)
			#
			#    => ["userx", "usery"]
			#
			# But if the info isn't available it will return an empty Array.
			def usernames_by_uid(uid = get_uid)
				return [] unless passwd_readable?

				usernames = []
				passwd_splitted.each { |x|
					usernames << x[0] if x[2].to_i == uid
				}
				usernames
			end

			##
			# = username_by_gid(gid = get_gid)
			#
			# Where gid is the group id of the user. By default it's the gid of the current user.
			#
			# It returns a String cotaining the username corresponding to the gid
			#
			# But if the info isn't available it will return an empty frozen String.
			def username_by_gid(gid = get_gid)
				return ''.freeze unless passwd_readable?

				username = ''.freeze
				passwd.each do |x|
					splitted = x.split(?:.freeze)
					if splitted[2].to_i == gid
						username = splitted[0]
						break
					end
				end
				username
			end

			##
			# = gid_by_username(username = get_user)
			#
			# Where username is the username to look for, by default it is the current user.
			#
			# It returns the gid by the username.
			# For example:
			#    LinuxStat::User.gid_by_username('root')
			#
			#    => 0
			#
			# The return type is Integer.
			#
			# But if user passed doesn't exist or if the info isn't available, it will return nil.
			def gid_by_username(username = get_user)
				return nil unless passwd_readable?

				gid = nil
				passwd.each do |x|
					splitted = x.split(?:.freeze)
					if splitted[0] == username
						gid = splitted[3].to_i
						break
					end
				end
				gid
			end

			##
			# = uid_by_username(username = get_user)
			#
			# Where username is the username to look for, by default it is the current user.
			#
			# It returns the uid by the username.
			#
			# For example:
			#    LinuxStat::User.uid_by_username('root')
			#
			#    => 0
			#
			# The return type is Integer.
			#
			# But if user passed doesn't exist or if the info isn't available, it will return nil.
			def uid_by_username(username = get_user)
				return nil unless passwd_readable?

				uid = nil
				passwd.each do |x|
					splitted = x.split(?:.freeze)
					if splitted[0] == username
						uid = splitted[2].to_i
						break
					end
				end
				uid
			end

			##
			# = home_by_username(user = get_user)
			#
			# Where user is the name of the user.
			#
			# Returns the user's home. By default it returns the home of the current user.
			#
			# If the info isn't available, it will return ENV['HOME].to_s.freeze
			def home_by_username(user = get_user)
				return ENV['HOME'].to_s.freeze unless passwd_readable?

				home = ''
				passwd.each { |x|
					splitted = x.split(?:)
					if splitted[0] == user
						home = splitted[5]
						break
					end
				}
				home
			end

			##
			# = home_by_uid(id = get_uid)
			#
			# Gets all the users home directory with user id.
			#
			# It returns an Array in this format:
			#    LinuxStat::User.homes_by_uid(1001)
			#
			#    => ["/home/userx", "/home/usery"]
			#
			# Assuming both the users share same UID.
			#
			# If the info isn't available, it will return an empty Array.
			def homes_by_uid(id = get_uid)
				return [] unless passwd_readable?

				home = []
				passwd.each do |x|
					splitted = x.split(?:.freeze)
					home << splitted[5] if splitted[2].to_i == id
				end
				home
			end

			##
			# = home_by_gid(id = get_uid)
			#
			# Gets the home of the user corresponding to the GID.
			#
			# It returns a String in this format:
			#
			# Assuming both the users share same UID.
			#
			# If the info isn't available, it will return an empty frozen String.
			def home_by_gid(id = get_gid)
				return ''.freeze unless passwd_readable?

				home = ''.freeze
				passwd.each do |x|
					splitted = x.split(?:.freeze)

					if splitted[3].to_i == id
						home = splitted[5]
						break
					end
				end
				home
			end

			alias get_current_user get_user

			private
			def passwd
				@@passwd_file ||= '/etc/passwd'.freeze
				IO.readlines(@@passwd_file)
			end

			# Only use this method where we are sure that the whole array is going to be used.
			# In cases like find() or a loop with `break` this is a lot of overhead.
			# In cases like reduce({}) or select, this is not helpful.
			def passwd_splitted
				@@passwd_file ||= '/etc/passwd'.freeze
				IO.readlines(@@passwd_file).map { |x| x.split(?:.freeze) }
			end

			def passwd_readable?
				@@passwd_file ||= '/etc/passwd'.freeze
				@@passwd_readable ||= File.readable?(@@passwd_file)
			end
		end
	end
end
