Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 23 Feb 2015 19:08:48 +0100
Message-Id: <1424714928-29768-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] alfred: Add explanation how to run alfred as
	non-root user
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

Reported-by: MK <mailing.m1@kkk-web.de>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 README | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/README b/README
index 90a99de..205c156 100644
--- a/README
+++ b/README
@@ -256,6 +256,32 @@ To get JSON formatted output, use:
 
 See gpsd_json(5) for documentation of the tpv object. 
 
+Running alfred as non-root user
+-------------------------------
+
+Alfred currently requires special capabilities and access rights to work
+correctly. The user root is normally the only user having these
+capabilities/rights on a standard Linux system.
+
+Operations requiring special capabilities:
+
+ * bind to device
+ * creating the unix socket
+ * accessing the debugfs filesystem
+
+The first operation can still be executed when the admin grants the special
+capability CAP_NET_RAW to anyone executing the alfred binary. The unix socket
+can also be moved to a different directly which is accessible by the user by
+adding the parameter '-u'.
+
+ $ sudo setcap cap_net_raw+ep alfred
+ $ ./alfred -u alfred.sock -i eth0
+
+The user running alfred must still be in a group which is allowed to access
+/sys/kernel/debugfs to correctly choose best neighbors for communication.
+It is possible (but not recommended) to disable the neighbor
+selection/prioritization using the parameter '-b none'.
+
 License
 -------
 
-- 
2.1.4

