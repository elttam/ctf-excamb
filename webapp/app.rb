#!/usr/bin/env ruby

require "sinatra"
require "securerandom"

configure do
  enable :inline_templates
end

helpers do
  include ERB::Util
end

set :environment, :production

KEY = ["659db50be4d4f37e24d9df31b4317a9d"].pack("H*")

def encrypt(plaintext)
  plaintext += "\x00" until plaintext.bytesize % 16 == 0
  cipher = OpenSSL::Cipher::Cipher.new("aes-128-ecb")
  cipher.encrypt
  cipher.key = KEY
  cipher.padding = 0
  ciphertext = cipher.update(plaintext) << cipher.final
  return ciphertext.unpack('H*')[0]
end

def prefix
  SecureRandom.random_bytes(SecureRandom.random_number(42) + 1)
end

def suffix
  "Congratulations! Here is the flag for you: #{File.read("flag.txt")}"
end

get "/" do
  @title = "Excamb Challenge"

	redirect to("/?middle=") unless params[:middle]

  middle = params[:middle].to_s

  @ciphertext = encrypt(prefix + middle + suffix).reverse

  erb :index
end



__END__

@@ layout
<!doctype html>
<html>
 <head>
   <style>
    html, body {
        height: 100%;
        background-color: black;
        height: 100%;
        margin: 0px;
        padding: 0px;
        color: white;
        font-family: courier, monospace;
        text-align: center;
    }
    h1 {
        margin-top: 5%;
    }
    a {
        color: green;
    }
    input {
        padding: 10px;
    }
  </style>
  <title><%= h @title %></title>
 </head>
 <body>
  <div class="box">
    <h1><%= h @title %></h1>
    <%= yield %></p>
  </div>
 </body>
</html>

@@ index
<p style="word-wrap:break-word;"><%= @ciphertext %></p>
