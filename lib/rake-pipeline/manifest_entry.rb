module Rake
  class Pipeline
    # Represents a single entry in a dynamic dependency {Manifest}.
    class ManifestEntry
      # Create a new entry from the given hash.
      def self.from_hash(hash)
        entry = new

        entry.mtime = hash["mtime"]

        hash["deps"].each do |dep, time_string|
          entry.deps[dep] = time_string
        end

        entry
      end

      attr_accessor :deps, :mtime, :metadata

      def initialize(deps={}, mtime=nil)
        @deps, @mtime = deps, mtime
      end

      def metadata!(metadata)
        $stderr.puts "Metadata: #{metadata.inspect}"
        @metadata = metadata
      end

      def as_json
        { :deps => @deps, :mtime => @mtime }.merge(metadata || {})
      end

      def ==(other)
        mtime == other.mtime
        deps == other.deps
      end
    end
  end
end
