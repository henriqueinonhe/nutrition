class Errors::Error < StandardError
  attr_reader :msg

  def initialize(msg:, tags:)
    super(msg)

    @msg = msg
    @tags = tags
  end

  def has_tag?(*tags)
    tags.any? { |tag| @tags.include?(tag) }
  end

  def to_s
    <<~HEREDOC
    #{super()}

    Tags: #{@tags.to_s}
    HEREDOC
  end
end