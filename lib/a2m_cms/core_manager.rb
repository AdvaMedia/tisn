module A2mCms
  class CoreManager
    def self.restart
      tmpfile = File.join(RAILS_ROOT, '/tmp/restart.txt')
      if File.exist?(tmpfile)
        File.delete(tmpfile)
      else
        File.open(tmpfile, 'w') {|f| f.write('') }
      end
    end
  end
end
