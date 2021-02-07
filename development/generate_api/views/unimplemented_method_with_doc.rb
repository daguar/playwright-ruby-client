class UnmplementedMethodWithDoc
  # @param doc [Doc]
  # @param inflector [Dry::Inflector]
  def initialize(doc, inflector)
    @doc = doc
    @inflector = inflector
  end

  # @returns Enumerable<String>
  def lines
    Enumerator.new do |data|
      method_comment_lines.each(&data)
      data << "    def #{method_name_and_args}"
      data << "      raise NotImplementedError.new('#{method_name.rubyish_name} is not implemented yet.')"
      data << '    end'
      method_alias_lines.each(&data)
    end
  end

  def api_coverages
    Enumerator.new do |data|
      data << "* ~~#{method_name.rubyish_name}~~"
    end
  end

  private

  def method_comment_lines
    Enumerator.new do |data|
      @doc.comment&.split("\n")&.each do |line|
        data << '    #' if line.start_with?("```js")
        data << "    # #{line}"
      end
    end
  end

  def method_name_and_args
    if @doc.arg_docs.empty?
      method_name.rubyish_name
    else
      "#{method_name.rubyish_name}(#{join_with_indent_or_spaces(method_args.for_method_definition)})"
    end
  end

  def method_alias_lines
    Enumerator.new do |data|
      if method_name.rubyish_name.start_with?('set_')
        if method_args.setter_parameter?
          data << "    alias_method :#{method_name.rubyish_name[4..-1]}=, :#{method_name.rubyish_name}"
        end
      end

      if method_name.rubyish_name == 'get_attribute'
        data << "    alias_method :[], :get_attribute"
      elsif method_name.rubyish_name.start_with?('get_')
        if method_args.empty?
          data << "    alias_method :#{method_name.rubyish_name[4..-1]}, :#{method_name.rubyish_name}"
        end
      end
    end
  end

  def method_name
    @method_name ||= MethodName.new(@inflector, @doc.name)
  end

  def method_args
    @method_args ||= DocumentedMethodArgs.new(@inflector, @doc.arg_docs)
  end

  # indent with 10 spaces, if arg_definitions.size >= 5
  #
  # [indent]a,
  # [      ]b,
  # [      ]c,
  # [      ]d
  #
  # otherwise, just join with ", "
  #
  # @param args [Array<String>]
  # @returns [String]
  def join_with_indent_or_spaces(args)
    if args.count >= 5
      joined = args.join(",\n          ")
      "\n          #{joined}"
    else
      args.join(', ')
    end
  end
end
