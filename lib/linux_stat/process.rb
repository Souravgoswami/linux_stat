module LinuxStat
	module Process
		class << self
			def list
				Dir['/proc/*'].select! { |x|
					pid = File.split(x)[1]
					pid.to_i.to_s == pid
				}.map! { |x| File.split(x)[-1].to_i }
			end

			def count
				list.count
			end

			def names
				list.reduce({}) { |h, x|
					begin
						h.merge!( x => IO.foreach(File.join('/proc', x.to_s, 'status')).first.split[1] )
					rescue Exception
						h
					end
				}
			end

			def types
				list.reduce({}) { |h, x|
					begin
						h.merge!(x =>
							case IO.read(File.join('/proc', x.to_s, 'stat')).split[2]
								when ?S.freeze then :sleeping
								when ?I.freeze then :idle
								when ?Z.freeze then :zombie
								when ?R.freeze then :running
								else :unknown
							end
						)
					rescue Exception
						h
					end
				}
			end

			def sleeping
				list.select { |x|
					begin
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?S
					rescue Exception
						nil
					end
				}
			end

			def idle
				list.select { |x|
					begin
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?I
					rescue Exception
						nil
					end
				}
			end

			def zombie
				list.select { |x|
					begin
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?Z
					rescue Exception
						nil
					end
				}
			end

			def running
				list.select { |x|
					begin
						IO.read(File.join('/proc', x.to_s, 'stat')).split[2] == ?R
					rescue Exception
						nil
					end
				}
			end
		end
	end
end
