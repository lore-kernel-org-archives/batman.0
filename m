From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon,  1 Dec 2008 19:56:58 +0100
Message-Id: <1228157822-29406-4-git-send-email-sven.eckelmann@gmx.de>
In-Reply-To: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
References: <1228157822-29406-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Use declaration of vis_if from batman.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

---
 batman/posix/posix.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/batman/posix/posix.c b/batman/posix/posix.c
index 048cf94..17b0667 100644
--- a/batman/posix/posix.c
+++ b/batman/posix/posix.c
@@ -42,8 +42,6 @@
 #define BAT_LOGO_END(x,y) printf("\x1B[8;0H");fflush(NULL);bat_wait( x, y );              /* end of current picture */
 #define IOCREMDEV 2
 
-extern struct vis_if vis_if;
-
 static clock_t last_clock_tick;
 static float system_tick;
 
-- 
1.6.0.4

