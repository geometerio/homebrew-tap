class JanusGateway < Formula
  desc "Meetecho Janus Gateway"
  homepage "https://github.com/meetecho/janus-gateway"
  sha256 "af2cdb3451b97e09b2362e283a766800db21ab9294820f0605e8ad1bf28ef53b"
  license "GPL-3.0"
  head "https://github.com/meetecho/janus-gateway.git", tag: "v0.11.5"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "pkg-config" => :build
  depends_on "autoconf"
  depends_on "autogen"
  depends_on "automake"
  depends_on "cmake"
  depends_on "curl"
  depends_on "ffmpeg"
  depends_on "gengetopt"
  depends_on "glib"
  depends_on "jansson"
  depends_on "libconfig"
  depends_on "libtool"
  depends_on "libwebsockets"
  depends_on "libnice"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "srtp"
  depends_on "zlib"

  def install
    ENV.prepend "LDFLAGS", "-L#{Formula["openssl@1.1"].opt_lib}, -L#{Formula["srtp"].opt_lib}"
    ENV.prepend "CFLAGS", "-I#{Formula["openssl@1.1"].opt_include} -I#{Formula["srtp"].opt_include}"
    
    args = %W[
      --enable-post-processing
      --enable-openssl
    ]

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", *args
    system "make", "test"
    system "make", "install"
    system "make", "configs"
  end
end