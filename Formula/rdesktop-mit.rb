class RdesktopMit < Formula
  desc "UNIX client for connecting to Windows Remote Desktop Services"
  homepage "https://github.com/rdesktop/rdesktop"
  url "https://github.com/rdesktop/rdesktop/releases/download/v1.9.0/rdesktop-1.9.0.tar.gz"
  sha256 "473c2f312391379960efe41caad37852c59312bc8f100f9b5f26609ab5704288"
  license "GPL-3.0-or-later"
  revision 2

  bottle do
    sha256 big_sur:     "60d5a72e5a55cace788d0a28241b9080fbf039c25fd91eb3bf91a95a8e8e4a89"
    sha256 catalina:    "8b22a2d1f52ff40334a16fc4614bc2f2c9e50386f0732e8e4478f68c7008f961"
    sha256 mojave:      "91b95a137be4361dee7d8bf2e442fa75eaf159469c09e238a127aa1186534638"
    sha256 high_sierra: "84ca9f1d74ad63108e320f2cae63a2afdfafd3995aa2d37837d551cc5dda8688"
  end

  deprecate! date: "2020-11-12", because: :unmaintained

  depends_on "pkg-config" => :build
  depends_on "gnutls"
  depends_on "libao"
  depends_on "libtasn1"
  depends_on "libx11"
  depends_on "libxcursor"
  depends_on "libxrandr"
  depends_on "nettle"
  depends_on "krb5"

  patch :DATA

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-smartcard
      --with-sound=libao
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rdesktop -help 2>&1", 64)
  end
end
__END__
diff --git a/configure.orig b/configure
index 22ae556..6b8c134 100755
--- a/configure.orig
+++ b/configure
@@ -5291,7 +5291,7 @@ if test "x$enable_credssp" != "xno"; then :
 
 	case "$OSTYPE" in
 	     darwin*)
-		ac_fn_c_check_header_mongrel "$LINENO" "Kerberos/gssapi_krb5.h" "ac_cv_header_Kerberos_gssapi_krb5_h" "$ac_includes_default"
+		ac_fn_c_check_header_mongrel "$LINENO" "gssapi/gssapi_krb5.h" "ac_cv_header_Kerberos_gssapi_krb5_h" "$ac_includes_default"
 if test "x$ac_cv_header_Kerberos_gssapi_krb5_h" = xyes; then :
   WITH_CREDSSP=1
 else
@@ -5300,7 +5300,7 @@ fi
 
 
 		GSSAPI_CFLAGS=""
-		GSSAPI_LIBS="-framework Kerberos"
+		GSSAPI_LIBS="-lgssapi_krb5"
 		;;
 	     *)
 		#if 'OSTYPE' is not set use 'host' instead
diff --git a/configure.ac.orig b/configure.ac
index 1ab12a8..f5b545b 100644
--- a/configure.ac.orig
+++ b/configure.ac
@@ -70,9 +70,9 @@ AC_ARG_ENABLE([credssp], AS_HELP_STRING([--disable-credssp], [disable support fo
 AS_IF([test "x$enable_credssp" != "xno"], [
 	case "$OSTYPE" in
 	     darwin*)
-		AC_CHECK_HEADER(Kerberos/gssapi_krb5.h, [WITH_CREDSSP=1], [WITH_CREDSSP=0])
+		AC_CHECK_HEADER(gssapi/gssapi_krb5.h, [WITH_CREDSSP=1], [WITH_CREDSSP=0])
 		GSSAPI_CFLAGS=""
-		GSSAPI_LIBS="-framework Kerberos"
+		GSSAPI_LIBS="-lgssapi_krb5"
 		;;
 	     *)
 		#if 'OSTYPE' is not set use 'host' instead
