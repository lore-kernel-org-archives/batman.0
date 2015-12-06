Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:28:25 +0100
Message-Id: <1449415705-23386-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv-doc: Fix external links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README             | 20 ++++++++++----------
 batmand.docbook    |  4 ++--
 copyright.docbook  |  2 +-
 references.docbook |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/README b/README
index 8f4ff7d..59ebe63 100644
--- a/README
+++ b/README
@@ -1,18 +1,18 @@
 Requirements
 ============
 
- * GNU make - http://www.gnu.org/software/make/
+ * GNU make - https://www.gnu.org/software/make/
  * xmlto - https://fedorahosted.org/xmlto/
- * docbook-xml (>= 4.5) - http://www.oasis-open.org/docbook/xml/
- * docbook-xsl - http://wiki.docbook.org/topic/DocBookXslStylesheets
- * fop - http://xmlgraphics.apache.org/fop/
+ * docbook-xml (>= 4.5) - https://www.oasis-open.org/docbook/xml/
+ * docbook-xsl - http://wiki.docbook.org/DocBookXslStylesheets
+ * fop - https://xmlgraphics.apache.org/fop/
  * ghostscript - http://www.ghostscript.com/
- * coreutils - http://www.gnu.org/software/coreutils/
+ * coreutils - https://www.gnu.org/software/coreutils/coreutils.html
  * gnuplot - http://gnuplot.sourceforge.net/
- * dia - http://live.gnome.org/Dia
- * texlive-latex-base - http://www.tug.org/texlive/
- * texlive-base - http://www.tug.org/texlive/
- * ps2eps - http://www.tm.uka.de/~bless/ps2eps
+ * dia - https://wiki.gnome.org/action/show/Apps/Dia
+ * texlive-latex-base - https://www.tug.org/texlive/
+ * texlive-base - https://www.tug.org/texlive/
+ * ps2eps - https://www.tm.uka.de/~bless/ps2eps
  * imagemagick - http://www.imagemagick.org/
 
 
@@ -31,4 +31,4 @@ Troubleshooting
  * "libjli.so: cannot open shared object file: No such file or directory"
    Make sure that /proc is mounted and `/bin/ls -l /proc/self/exe` prints
    [...] /proc/self/exe -> /bin/ls
-   See http://bugs.debian.org/435293 for more informations
+   See https://bugs.debian.org/435293 for more informations
diff --git a/batmand.docbook b/batmand.docbook
index 9f6c68b..350e9ed 100644
--- a/batmand.docbook
+++ b/batmand.docbook
@@ -18,7 +18,7 @@
         <listitem><para>libpthread</para></listitem>
       </orderedlist></listitem>
       <listitem><para>Download the B.A.T.M.A.N. daemon code from the website
-      <ulink url="http://www.open-mesh.net/wiki/Download" /></para></listitem>
+      <ulink url="https://www.open-mesh.org/projects/open-mesh/wiki/Download" /></para></listitem>
     </itemizedlist>
   </section>
   <section>
@@ -26,7 +26,7 @@
     <para>All you have to do is untar and make, then you will see the executable
     file called <emphasis>batmand</emphasis>.</para>
     <programlisting><userinput>$ wget \
-http://downloads.open-mesh.net/batman/stable/sources/batman/batman-0.3.tar.gz
+https://downloads.open-mesh.org/batman/stable/sources/batman/batman-0.3.tar.gz
 $ tar xzvf batman-0.3.tar.gz
 $ cd batman-0.3
 $ make</userinput></programlisting>
diff --git a/copyright.docbook b/copyright.docbook
index 4ec2dff..1cf1d6a 100644
--- a/copyright.docbook
+++ b/copyright.docbook
@@ -5,6 +5,6 @@
   you can redistribute it and/or modify it under the terms of the
   GNU General Public License as published by the Free Software
   Foundation; version 2 of the License. To view a copy of this
-  license, visit  <ulink url="http://www.gnu.org/licenses/old-licenses/gpl-2.0.html" /> or write to the Free Software Foundation, Inc., 51 Franklin
+  license, visit  <ulink url="https://www.gnu.org/licenses/old-licenses/gpl-2.0.html" /> or write to the Free Software Foundation, Inc., 51 Franklin
   Street, Fifth Floor, Boston, MA  02110-1301  USA.</para>
 </chapter>
diff --git a/references.docbook b/references.docbook
index 0cd65d3..0cce1d4 100644
--- a/references.docbook
+++ b/references.docbook
@@ -2,7 +2,7 @@
 <section>
   <title>Reference Links</title>
   <itemizedlist>
-    <listitem><ulink url="http://www.open-mesh.net/" /></listitem>
+    <listitem><ulink url="https://www.open-mesh.org/" /></listitem>
     <listitem><ulink url="http://www.olsr.org/" /></listitem>
   </itemizedlist>
 </section>
-- 
2.6.2

