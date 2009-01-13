From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 13 Jan 2009 19:46:16 +0100
Message-Id: <1231872376-21395-2-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
References: <1F97746F-9493-4343-A46A-B2A9A727E13B@7degrees.co.za>
Subject: [B.A.T.M.A.N.] [PATCH] Fix compilation on freebsd
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

FreeBSD doesn't include as much deep includes in their socket headers
as the linux ones does. To support building on freebsd we must include
them explicit.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
CC: Antoine van Gelder <antoine@7degrees.co.za>
---
 vis-advanced/vis.c |    2 +-
 vis-advanced/vis.h |    2 ++
 vis/vis.c          |    2 +-
 vis/vis.h          |    2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/vis-advanced/vis.c b/vis-advanced/vis.c
index 721d690..69f69b8 100644
--- a/vis-advanced/vis.c
+++ b/vis-advanced/vis.c
@@ -23,10 +23,10 @@
 
 
 #include <fcntl.h>
+#include <sys/socket.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/select.h>
-#include <sys/time.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/vis-advanced/vis.h b/vis-advanced/vis.h
index 6f6793e..a060c83 100644
--- a/vis-advanced/vis.h
+++ b/vis-advanced/vis.h
@@ -25,6 +25,8 @@
 #include <pthread.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/time.h>
+#include <netinet/in.h>
 #include <arpa/inet.h>
 #include <errno.h>
 
diff --git a/vis/vis.c b/vis/vis.c
index 05f4096..c488365 100644
--- a/vis/vis.c
+++ b/vis/vis.c
@@ -23,10 +23,10 @@
 
 
 #include <fcntl.h>
+#include <sys/socket.h>
 #include <net/if.h>
 #include <sys/ioctl.h>
 #include <sys/select.h>
-#include <sys/time.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/vis/vis.h b/vis/vis.h
index 8953b70..1f343d8 100644
--- a/vis/vis.h
+++ b/vis/vis.h
@@ -25,7 +25,9 @@
 #include <pthread.h>
 #include <sys/socket.h>
 #include <sys/types.h>
+#include <sys/time.h>
 #include <arpa/inet.h>
+#include <netinet/in.h>
 #include <errno.h>
 
 
-- 
1.6.0.6

