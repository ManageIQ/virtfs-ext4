require 'ostruct'
require 'virtfs/block_io'
require 'virt_disk/block_file'

FactoryGirl.define do
  factory :ext, class: OpenStruct do
    path '/home/mmorsi/workspace/cfme/virtfs/virtfs-ext4/ext4.fs'
    fs { VirtFS::Ext4::FS.new(VirtFS::BlockIO.new(VirtDisk::BlockFile.new(path))) }
    root_dir ["bar", "foo", "foobar", "lost+found"]
    glob_dir ["bar/secrets", "foo/subdir"]
    #boot_size 2048
  end
end
