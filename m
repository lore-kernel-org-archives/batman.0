From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 24 Feb 2009 11:52:40 +0100
Message-Id: <1235472760-8775-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] Fix deletion of aggregate_ogm in
	/proc/net/batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

remove_proc_entry needs as second parameter the parent directory and
not the proc_dir_entry of the file to delete. Otherwise nothing will
be removed the deletion of /proc/net/batman-adv will fail because it
still has child nodes.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 6c475d4..00e177a 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -134,7 +134,7 @@ void cleanup_procfs(void)
 		remove_proc_entry(PROC_FILE_VIS, proc_batman_dir);
 
 	if (proc_aggr_file)
-		remove_proc_entry(PROC_FILE_AGGR, proc_aggr_file);
+		remove_proc_entry(PROC_FILE_AGGR, proc_batman_dir);
 
 	if (proc_batman_dir)
 #ifdef __NET_NET_NAMESPACE_H
-- 
1.6.1.3

