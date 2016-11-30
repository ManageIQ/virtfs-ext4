require 'binary_struct'

module VirtFS::Ext4
  EXTENT_HEADER = BinaryStruct.new([
    'S',  'magic',      # Signature.
    'S',  'entries',    # Number of Valid Entries
    'S',  'max',        # Capacity of Store in Entries
    'S',  'depth',      # Has tree real underlying blocks?
    'L',  'generation', # Generation of the tree.
  ])

  SIZEOF_EXTENT_HEADER = EXTENT_HEADER.size

  class ExtentHeader
    attr_reader :magic, :entries, :max, :depth, :generation

    def initialize(buf)
      raise "Ext4::ExtentHeader.initialize: Nil buffer" if buf.nil?
      @eh = EXTENT_HEADER.decode(buf)

      @magic      = @eh['magic']
      @entries    = @eh['entries']
      @max        = @eh['max']
      @depth      = @eh['depth']
      @generation = @eh['generation']
    end
  end
end
