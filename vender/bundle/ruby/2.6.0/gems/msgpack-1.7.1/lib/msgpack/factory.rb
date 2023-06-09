module MessagePack
  class Factory
    # see ext for other methods

    # [ {type: id, class: Class(or nil), packer: arg, unpacker: arg}, ... ]
    def registered_types(selector=:both)
      packer, unpacker = registered_types_internal
      # packer: Class -> [tid, proc, arg]
      # unpacker: tid -> [klass, proc, arg]

      list = []

      case selector
      when :both
        packer.each_pair do |klass, ary|
          type = ary[0]
          packer_arg = ary[2]
          unpacker_arg = nil
          if unpacker.has_key?(type) && unpacker[type][0] == klass
            unpacker_arg = unpacker.delete(type)[2]
          end
          list << {type: type, class: klass, packer: packer_arg, unpacker: unpacker_arg}
        end

        # unpacker definition only
        unpacker.each_pair do |type, ary|
          list << {type: type, class: ary[0], packer: nil, unpacker: ary[2]}
        end

      when :packer
        packer.each_pair do |klass, ary|
          list << {type: ary[0], class: klass, packer: ary[2]}
        end

      when :unpacker
        unpacker.each_pair do |type, ary|
          list << {type: type, class: ary[0], unpacker: ary[2]}
        end

      else
        raise ArgumentError, "invalid selector #{selector}"
      end

      list.sort{|a, b| a[:type] <=> b[:type] }
    end

    def type_registered?(klass_or_type, selector=:both)
      case klass_or_type
      when Class
        klass = klass_or_type
        registered_types(selector).any?{|entry| klass <= entry[:class] }
      when Integer
        type = klass_or_type
        registered_types(selector).any?{|entry| type == entry[:type] }
      else
        raise ArgumentError, "class or type id"
      end
    end

    def load(src, param = nil)
      unpacker = nil

      if src.is_a? String
        unpacker = unpacker(param)
        unpacker.feed(src)
      else
        unpacker = unpacker(src, param)
      end

      unpacker.full_unpack
    end
    alias :unpack :load

    def dump(v, *rest)
      packer = packer(*rest)
      packer.write(v)
      packer.full_pack
    end
    alias :pack :dump

    def pool(size = 1, **options)
      Pool.new(
        frozen? ? self : dup.freeze,
        size,
        options.empty? ? nil : options,
      )
    end

    class Pool
      if RUBY_ENGINE == "ruby"
        class MemberPool
          def initialize(size, &block)
            @size = size
            @new_member = block
            @members = []
          end

          def with
            member = @members.pop || @new_member.call
            begin
              yield member
            ensure
              # If the pool is already full, we simply drop the extra member.
              # This is because contrary to a connection pool, creating an extra instance
              # is extremely unlikely to cause some kind of resource exhaustion.
              #
              # We could cycle the members (keep the newer one) but first It's more work and second
              # the older member might have been created pre-fork, so it might be at least partially
              # in shared memory.
              if member && @members.size < @size
                member.reset
                @members << member
              end
            end
          end
        end
      else
        class MemberPool
          def initialize(size, &block)
            @size = size
            @new_member = block
            @members = []
            @mutex = Mutex.new
          end

          def with
            member = @mutex.synchronize { @members.pop } || @new_member.call
            begin
              yield member
            ensure
              member.reset
              @mutex.synchronize do
                if member && @members.size < @size
                  @members << member
                end
              end
            end
          end
        end
      end

      def initialize(factory, size, options = nil)
        options = nil if !options || options.empty?
        @factory = factory
        @packers = MemberPool.new(size) { factory.packer(options).freeze }
        @unpackers = MemberPool.new(size) { factory.unpacker(options).freeze }
      end

      def load(data)
        @unpackers.with do |unpacker|
          unpacker.feed(data)
          unpacker.full_unpack
        end
      end

      def dump(object)
        @packers.with do |packer|
          packer.write(object)
          packer.full_pack
        end
      end

      def unpacker(&block)
        @unpackers.with(&block)
      end

      def packer(&block)
        @packers.with(&block)
      end
    end
  end
end
