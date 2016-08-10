require 'minitest/autorun'
require 'text_smuggler'

ENV['RACK_ENV'] = 'test'

describe TextSmuggler do
  
  parallelize_me!
  
  subject { TextSmuggler.new }
  let(:custom) { 
    TextSmuggler.new(key: TextSmuggler::DEFAULT_KEY.reverse) 
  }

  let(:strings) {
    [
      'simple string', 'me@example.com', "Long text\nwith\nreturn lines",
      'http://example.com/path/to/page?foo=1&bar=2'
    ]
  }

  it 'Encodes text' do
    strings.each do |s|
      refute_equal s, subject.encode(s)
    end
  end

  it 'Encodes something different each time' do
    strings.each do |s|
      refute_equal subject.encode(s), subject.encode(s)
    end
  end

  it 'Decodes text' do
    strings.each do |s|
      assert_equal s, subject.decode(subject.encode(s))
    end
  end

  it 'Encodes URL friendly text' do
    strings.each do |s|
      assert_match(/^[a-zA-Z0-9,\-_]+$/, subject.encode(s))
    end
  end

end
