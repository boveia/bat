# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Bat < Formula
  homepage "https://github.com/bat"
#  head "https://github.com/bat/bat.git", :tag => "v0.9.4"
  head "https://github.com/bat/bat.git", :branch => "sed"
  sha1 ""

  # depends_on "cmake" => :build
  depends_on "root6"
  depends_on "automake" # for autoreconf, aclocal
  depends_on "libtool"
  
  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system ". autogen.sh"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test bat`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end

  patch :DATA
  
end

__END__

diff --git a/models/base/Makefile.am b/models/base/Makefile.am
index fa48055..f5a3b6f 100644
--- a/models/base/Makefile.am
+++ b/models/base/Makefile.am
@@ -78,8 +78,8 @@ libBATmodels_rdict.cxx: $(library_include_HEADERS) LinkDef.h
 	$(ROOTCLING) -f $@.tmp -s libBATmodels@SHLIBEXT@ -rml libBATmodels@SHLIBEXT@ -rmf libBATmodels.rootmap -c $(CPPFLAGS) $(CXXFLAGS) -I$(includedir) $+
 	@# Some magic to prefix header names with "$(PACKAGE)/", and only that, in dictionary and rootmap:
 	$(GREP) -F -v '"'"`pwd`"'/",' $@.tmp | $(SED) 's|"\([^"]*/\)\?\([^/"]*[.]h\)",|"'$(PACKAGE)/'\2",| ; s|\\"\([^"]*/\)\?\([^/"]*[.]h\)\\"\\n"|\\"'$(PACKAGE)/'\2\\"\\n"|' > $@ && $(RM) $@.tmp
-	$(SED) -i'' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
-	$(SED) -i'' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmodels.rootmap
+	$(SED) -i '' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
+	$(SED) -i '' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmodels.rootmap
 
 .libs/libBATmodels.rootmap: libBATmodels.la
 	cp libBATmodels.rootmap libBATmodels_rdict.pcm .libs/
diff --git a/models/mtf/Makefile.am b/models/mtf/Makefile.am
index 55e5ae1..469f2c9 100644
--- a/models/mtf/Makefile.am
+++ b/models/mtf/Makefile.am
@@ -71,8 +71,8 @@ libBATmtf_rdict.cxx: $(library_include_HEADERS) LinkDef.h
 	$(ROOTCLING) -f $@.tmp -s libBATmtf@SHLIBEXT@ -rml libBATmtf@SHLIBEXT@ -rmf libBATmtf.rootmap -c $(CPPFLAGS) $(CXXFLAGS) -I$(includedir) $+
 	@# Some magic to prefix header names with "$(PACKAGE)/", and only that, in dictionary and rootmap:
 	$(GREP) -F -v '"'"`pwd`"'/",' $@.tmp | $(SED) 's|"\([^"]*/\)\?\([^/"]*[.]h\)",|"'$(PACKAGE)/'\2",| ; s|\\"\([^"]*/\)\?\([^/"]*[.]h\)\\"\\n"|\\"'$(PACKAGE)/'\2\\"\\n"|' > $@ && $(RM) $@.tmp
-	$(SED) -i'' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
-	$(SED) -i'' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmtf.rootmap
+	$(SED) -i '' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
+	$(SED) -i '' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmtf.rootmap
 
 .libs/libBATmtf.rootmap: libBATmtf.la
 	cp libBATmtf.rootmap libBATmtf_rdict.pcm .libs/
diff --git a/models/mvc/Makefile.am b/models/mvc/Makefile.am
index 1d2807b..696d297 100644
--- a/models/mvc/Makefile.am
+++ b/models/mvc/Makefile.am
@@ -69,8 +69,8 @@ libBATmvc_rdict.cxx: $(library_include_HEADERS) LinkDef.h
 	$(ROOTCLING) -f $@.tmp -s libBATmvc@SHLIBEXT@ -rml libBATmvc@SHLIBEXT@ -rmf libBATmvc.rootmap -c $(CPPFLAGS) $(CXXFLAGS) -I$(includedir) $+
 	@# Some magic to prefix header names with "$(PACKAGE)/", and only that, in dictionary and rootmap:
 	$(GREP) -F -v '"'"`pwd`"'/",' $@.tmp | $(SED) 's|"\([^"]*/\)\?\([^/"]*[.]h\)",|"'$(PACKAGE)/'\2",| ; s|\\"\([^"]*/\)\?\([^/"]*[.]h\)\\"\\n"|\\"'$(PACKAGE)/'\2\\"\\n"|' > $@ && $(RM) $@.tmp
-	$(SED) -i'' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
-	$(SED) -i'' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmvc.rootmap
+	$(SED) -i '' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
+	$(SED) -i '' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBATmvc.rootmap
 
 .libs/libBATmvc.rootmap: libBATmvc.la
 	cp libBATmvc.rootmap libBATmvc_rdict.pcm .libs/
diff --git a/src/Makefile.am b/src/Makefile.am
index 62a5a53..9409f13 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -88,8 +88,8 @@ libBAT_rdict.cxx: $(library_include_HEADERS) LinkDef.h
 	$(ROOTCLING) -f $@.tmp -s libBAT@SHLIBEXT@ -rml libBAT@SHLIBEXT@ -rmf libBAT.rootmap -c $(CPPFLAGS) $(CXXFLAGS) -I$(includedir) $+
 	@# Some magic to prefix header names with "$(PACKAGE)/", and only that, in dictionary and rootmap:
 	$(GREP) -F -v '"'"`pwd`"'/",' $@.tmp | $(SED) 's|"\([^"]*/\)\?\([^/"]*[.]h\)",|"'$(PACKAGE)/'\2",| ; s|\\"\([^"]*/\)\?\([^/"]*[.]h\)\\"\\n"|\\"'$(PACKAGE)/'\2\\"\\n"|' > $@ && $(RM) $@.tmp
-	$(SED) -i'' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
-	$(SED) -i'' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBAT.rootmap
+	$(SED) -i '' 's|\$$clingAutoload\$$\([^/""]\+/\)*|$$clingAutoload$$'$(PACKAGE)'/|; /.*DICTPAYLOAD(.*/,/.*)DICTPAYLOAD.*/ s|#include "\([^/"]\+/\)*\(.*\)"|#include <'$(PACKAGE)'/\2>|' $@
+	$(SED) -i '' 's|\(header \+\)\([^ ].*/\)\?\([^ ].*[.]h\)|\1'$(PACKAGE)/'\3|' libBAT.rootmap
 
 .libs/libBAT.rootmap: libBAT.la
 	cp libBAT.rootmap libBAT_rdict.pcm .libs/
