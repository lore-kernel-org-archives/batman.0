Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:21:06 +0100
Message-Id: <20170122122113.29588-2-sven@narfation.org>
In-Reply-To: <3266034.EiLA6asg3G@sven-edge>
References: <3266034.EiLA6asg3G@sven-edge>
Subject: [B.A.T.M.A.N.] [PATCH 2/9] batctl: Use geteuid for checks of root
	privileges
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

The getuid only shows the UID of the current user. But the EUID is relevant
for accessing the debugfs and sysfs files. This check is still to strict
when it comes to netlink but avoids a lot of bogus warnings like

    Error received: Operation not permitted
    Error - mesh has not been enabled yet
    Activate your mesh by adding interfaces to batman-adv

when only the euid of the process was 0 but the interface was actually
working.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 functions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/functions.c b/functions.c
index c1aaf12..2239440 100644
--- a/functions.c
+++ b/functions.c
@@ -1141,7 +1141,7 @@ void get_random_bytes(void *buf, size_t buflen)
 
 void check_root_or_die(const char *cmd)
 {
-	if (getuid() || getgid()) {
+	if (geteuid() != 0) {
 		fprintf(stderr, "Error - you must be root to run '%s' !\n", cmd);
 		exit(EXIT_FAILURE);
 	}
-- 
2.11.0

