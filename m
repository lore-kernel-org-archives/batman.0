Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  6 Dec 2015 16:15:28 +0100
Message-Id: <1449414928-21480-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batmand: Switch to HTTPS version of links
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
Cc: elektra <onelektra@gmx.net>
---
 CHANGELOG      | 2 +-
 INSTALL        | 6 +++---
 bitarray.c     | 4 ++--
 man/batmand.8  | 2 +-
 originator.c   | 2 +-
 posix/tunnel.c | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/CHANGELOG b/CHANGELOG
index 9552e53..b562a3d 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -1,3 +1,3 @@
 For a reasonable up-to-date CHANGELOG visit:
 
-http://git.open-mesh.org/?p=batmand.git;a=shortlog
+https://git.open-mesh.org/batmand.git
diff --git a/INSTALL b/INSTALL
index eae3eac..e8ad3c2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -39,12 +39,12 @@ Compiling
 
 You don't necessarily need to compile. May be your distribution or our
 download store offers precompiled packages. Check
-http://www.open-mesh.org/wiki/open-mesh/Download to get an overview.
+https://www.open-mesh.org/projects/open-mesh/wiki/Download to get an overview.
 
 Download and compile the latest stable sources from the download section
-http://www.open-mesh.org/wiki/open-mesh/Download by executing eg.:
+https://www.open-mesh.org/projects/open-mesh/wiki/Download by executing eg.:
 
-$ wget http://downloads.open-mesh.org/batman/stable/sources/batmand/batmand-0.3.2.tar.gz
+$ wget https://downloads.open-mesh.org/batman/stable/sources/batmand/batmand-0.3.2.tar.gz
 $ tar xzvf batmand-0.3.2.tar.gz
 $ cd batman-0.3.2
 $ make
diff --git a/bitarray.c b/bitarray.c
index 354eddd..69bf812 100644
--- a/bitarray.c
+++ b/bitarray.c
@@ -173,7 +173,7 @@ int bit_packet_count( TYPE_OF_WORD *seq_bits ) {
 
 		while (word) {
 
-			word &= word-1;   /* see http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan */
+			word &= word-1;   /* see https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan */
 			hamming++;
 
 		}
@@ -190,7 +190,7 @@ uint8_t bit_count( int32_t to_count ) {
 
 	while ( to_count ) {
 
-		to_count &= to_count-1;   /* see http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan */
+		to_count &= to_count-1;   /* see https://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetKernighan */
 		hamming++;
 
 	}
diff --git a/man/batmand.8 b/man/batmand.8
index c26d62b..89fcde5 100644
--- a/man/batmand.8
+++ b/man/batmand.8
@@ -28,7 +28,7 @@ batmand \- better approach to mobile ad\(hyhoc networking
 .br
 .SH DESCRIPTION
 .B B.A.T.M.A.N
-means better approach to mobile ad\(hyhoc networking, this is a new routing protocol for multi\(hyhop ad\(hyhoc mesh networks. Go to http://www.open\-mesh.org/ to get more information.
+means better approach to mobile ad\(hyhoc networking, this is a new routing protocol for multi\(hyhop ad\(hyhoc mesh networks. Go to https://www.open\-mesh.org/ to get more information.
 .PP
 The following document will explain how to use the \fBbatman daemon\fP.
 .PP
diff --git a/originator.c b/originator.c
index f017741..9ed7353 100644
--- a/originator.c
+++ b/originator.c
@@ -74,7 +74,7 @@ int compare_orig( void *data1, void *data2 )
 
 
 /* hashfunction to choose an entry in a hash table of given size */
-/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+/* hash algorithm from https://en.wikipedia.org/wiki/Hash_table */
 int choose_orig( void *data, int32_t size ) {
 
 	unsigned char *key= data;
diff --git a/posix/tunnel.c b/posix/tunnel.c
index 8e7611b..88721ae 100644
--- a/posix/tunnel.c
+++ b/posix/tunnel.c
@@ -507,7 +507,7 @@ static int compare_vip(void *data1, void *data2)
 }
 
 /* hashfunction to choose an entry in a hash table of given size */
-/* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
+/* hash algorithm from https://en.wikipedia.org/wiki/Hash_table */
 static int choose_wip(void *data, int32_t size)
 {
 	unsigned char *key= data;
-- 
2.6.2

