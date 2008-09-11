Date: Thu, 11 Sep 2008 15:53:27 +0200
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20080911135327.GA21671@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Remove batgat proc entries correctly
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

We must remove the /proc/net/batgat/clients file and /proc/net/batgat dir
correctly or otherwise we will get a oops when someone tries to access the
file. If we do not remove the directory it is possible that more then one batgat
entry appears inside of /proc/net/

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman/linux/modules/gateway.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index e90be0b..d7af197 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -769,8 +769,16 @@ int choose_vip(void *data, int32_t size)
 
 static void cleanup_procfs(void)
 {
-	if(clients_file) remove_proc_entry("PROC_FILE_CLIENTS", proc_dir);
-	if(proc_dir) remove_proc_entry(PROC_ROOT_DIR, NULL);
+	if (clients_file)
+		remove_proc_entry(PROC_FILE_CLIENTS, proc_dir);
+
+#ifdef __NET_NET_NAMESPACE_H
+	if (proc_dir)
+		remove_proc_entry(PROC_ROOT_DIR, init_net.proc_net);
+#else
+	if (proc_dir)
+		remove_proc_entry(PROC_ROOT_DIR, proc_net);
+#endif
 }
 
 static int setup_procfs(void)
-- 
1.6.0.1


