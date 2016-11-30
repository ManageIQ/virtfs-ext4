require 'spec_helper'
require 'fileutils'
require 'tmpdir'

describe "mount sub-dir on sub-dir" do
  before(:all) do
    reset_context

    @root = File::SEPARATOR
    @ext  = build(:ext)
    VirtFS.mount(@ext.fs, @root)
  end

  after(:all) do
    VirtFS.umount(@root)
  end

  context "Read access" do
    it "directory entries should match" do
      expect(VirtFS::VDir.entries(@ext.fs.mount_point)).to match_array(VirtFS::VDir.entries(@root))
    end
  end
end
