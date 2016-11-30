module VirtFS::Ext4
  class FS < VirtFS::Ext3::FS

    attr_accessor :mount_point, :superblock, :root_dir

    attr_accessor :entry_cache, :dir_cache, :cache_hits

    DEF_CACHE_SIZE = 50

    def self.match?(blk_device)
      begin
        blk_device.seek(0, IO::SEEK_SET)
        VirtFS::Ext4::Superblock.new(blk_device)
        return true
      rescue => err
        return false
      end
    end

    def initialize(blk_device)
      blk_device.seek(0, IO::SEEK_SET)
      @superblock  = Superblock.new(blk_device)
      @root_dir    = VirtFS::Ext3::Directory.new(self, superblock)
      @entry_cache = LruHash.new(DEF_CACHE_SIZE)
      @dir_cache   = LruHash.new(DEF_CACHE_SIZE)
      @cache_hits  = 0
    end

    # Wack leading drive leter & colon.
    def unnormalize_path(p)
      p[1] == 58 ? p[2, p.size] : p
    end
  end # class FS
end # module VirtFS::Ext3
