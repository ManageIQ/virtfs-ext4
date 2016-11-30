require 'binary_struct'

module VirtFS::Ext4
  EXTENT = BinaryStruct.new([
    'L',  'block',      # first logical block extent covers
    'S',  'length',     # number of blocks covered by extent
    'S',  'start_hi',   # high 16 bits of physical block
    'L',  'start_lo',   # low  32 bits of physical block
  ])

  SIZEOF_EXTENT = EXTENT.size

  class Extent
    attr_reader :block, :length, :start

    def initialize(buf)
      raise "Ext4::Extent.initialize: Nil buffer" if buf.nil?
      @extent = EXTENT.decode(buf)

      @block      = @extent['block']
      @length     = @extent['length']
      @start      = (@extent['start_hi'] << 32) | @extent['start_lo']
    end
  end
end
