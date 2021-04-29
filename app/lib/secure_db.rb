# frozen_string_literal: true

require 'base64'
require 'rbnacl'

# Encrypt and Decrypt from Database
class SecureDB
  class NoDbKeyError < StandardError; end

  # Generate key for Rake tasks (typically not called at runtime)
  def self.generate_key
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64 key
  end

<<<<<<< HEAD
  def self.setup(base_key)
    raise NoDbKeyError unless base_key

    @key = Base64.strict_decode64(base_key)
=======
  def self.key
    return @key if @key

    db_key = ENV.delete('DB_KEY')
    raise NoDbKeyError unless db_key

    @key = Base64.strict_decode64(db_key)
>>>>>>> e4faaca (Hardens database and secures configuration)
  end

  # Encrypt or else return nil if data is nil
  def self.encrypt(plaintext)
    return nil unless plaintext

<<<<<<< HEAD
    simple_box = RbNaCl::SimpleBox.from_secret_key(@key)
=======
    simple_box = RbNaCl::SimpleBox.from_secret_key(key)
>>>>>>> e4faaca (Hardens database and secures configuration)
    ciphertext = simple_box.encrypt(plaintext)
    Base64.strict_encode64(ciphertext)
  end

  # Decrypt or else return nil if database value is nil already
  def self.decrypt(ciphertext64)
    return nil unless ciphertext64

    ciphertext = Base64.strict_decode64(ciphertext64)
<<<<<<< HEAD
    simple_box = RbNaCl::SimpleBox.from_secret_key(@key)
    simple_box.decrypt(ciphertext).force_encoding(Encoding::UTF_8)
=======
    simple_box = RbNaCl::SimpleBox.from_secret_key(key)
    simple_box.decrypt(ciphertext)
>>>>>>> e4faaca (Hardens database and secures configuration)
  end
end
