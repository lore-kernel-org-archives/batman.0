Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 10 Sep 2013 23:11:53 +0200
Message-Id: <1378847522-13776-3-git-send-email-sven@narfation.org>
In-Reply-To: <1378847522-13776-1-git-send-email-sven@narfation.org>
References: <1378847522-13776-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 02/11] batctl: Fix inconsistent use of
	_GNU_SOURCE
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@narfation.org>

Either all or no source file should define _GNU_SOURCE to avoid incompatible
types or function declarations.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 Makefile    | 1 +
 bat-hosts.c | 1 -
 functions.c | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 1961298..7926db3 100755
--- a/Makefile
+++ b/Makefile
@@ -30,6 +30,7 @@ MANPAGE = man/batctl.8
 
 # batctl flags and options
 CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD
+CPPFLAGS += -D_GNU_SOURCE
 LDLIBS += -lm
 
 # disable verbose output
diff --git a/bat-hosts.c b/bat-hosts.c
index f0adb9c..ee862da 100644
--- a/bat-hosts.c
+++ b/bat-hosts.c
@@ -21,7 +21,6 @@
 
 
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdint.h>
 #include <limits.h>
diff --git a/functions.c b/functions.c
index 0359287..2a2f392 100644
--- a/functions.c
+++ b/functions.c
@@ -20,7 +20,6 @@
  */
 
 
-#define _GNU_SOURCE
 #include <netinet/ether.h>
 #include <arpa/inet.h>
 #include <sys/socket.h>
-- 
1.8.4.rc3

