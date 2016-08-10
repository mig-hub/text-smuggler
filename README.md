Text Smuggler
=============

`TextSmuggler` makes it easy to obfuscate pieces of text which need to be decoded later on, using OpenSSL::Cipher. Possibly incorporated in a URL.

Put this in your `Gemfile`:

```
gem 'text-smuggler'
```

Then use it like this:

```
secret_location = 'The secret location of Luke Skywalker is xxxxxx.'
han_solo = TextSmuggler.new key: 'change_me'

encoded = han_solo.encode secret_location

# Now you can use this string in a database or in a URL quite safely.
# And then when you need to decode it...

decoded = han_solo.decode encoded
```

You can also initialize a `TextSmuggler` with a specific type of ciper.
The default is `aes-256-cbc`.

```
smuggler = TextSmuggler.new({
  key: 'change_me',
  cipher_type: 'aes-256-cbc'
})
```

For more details about `OpenSSL::Cipher`, you can [read documentation here](http://ruby-doc.org/stdlib-1.9.3/libdoc/openssl/rdoc/OpenSSL/Cipher.html)

Warning
-------

Bear in mind that while this method is quite safe, you should only use it when 
you absolutely have to retrieve the data. For example, avoid saving passwords 
in a database with this method. Passwords only need to be compared and are safer
if they are saved with a non-reversible method (i.e. Hashed and salted).

