require 'openssl'
require 'base64'

class TextSmuggler

  DEFAULT_CIPHER_TYPE = 'aes-256-cbc'
  DEFAULT_KEY = '0123456789abcdef0123456789abcdef'

  def initialize opts={}
    @opts = {
      cipher_type: DEFAULT_CIPHER_TYPE, 
      key: (ENV['TEXT_SMUGGLER_KEY'] || DEFAULT_KEY)
    }.merge(opts)
  end

  def encode s
    cipher = cipher_for :encrypt
    iv = cipher.random_iv
    encrypted = cipher.update(s) + cipher.final
    encrypted = iv + encrypted
    url_friendly(encrypted)
  end

  def decode s
    cipher = cipher_for :decrypt
    encrypted = from_url_friendly s
    cipher.iv = encrypted.slice!(0,16)
    decrypted = cipher.update(encrypted) + cipher.final
    decrypted
  end

  private

  def cipher_for direction=:encrypt
    cipher = OpenSSL::Cipher.new(@opts[:cipher_type])
    cipher.public_send(direction)
    cipher.key = @opts[:key]
    cipher
  end

  def url_friendly s
    Base64.strict_encode64(s).tr('+/=', '-_,')
  end

  def from_url_friendly s
    Base64.strict_decode64(s.tr('-_,', '+/='))
  end

end

