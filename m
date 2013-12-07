Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat,  7 Dec 2013 11:21:22 +0100
Message-Id: <1386411684-2448-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
References: <1386411684-2448-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: fix typ0 in
	batadv_orig_hardif_seq_print_text()
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Introduced by f13f960797fd1969b3c0470cc97435ddfb6aecb4
("batman-adv: add debugfs support to view multiif tables")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 originator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/originator.c b/originator.c
index 4af1c77..2243003 100644
--- a/originator.c
+++ b/originator.c
@@ -958,7 +958,7 @@ int batadv_orig_hardif_seq_print_text(struct seq_file *seq, void *offset)
 	hard_iface = batadv_hardif_get_by_netdev(net_dev);
 
 	if (!hard_iface || !hard_iface->soft_iface) {
-		seq_puts(seq, "Interface not known to to B.A.T.M.A.N.\n");
+		seq_puts(seq, "Interface not known to B.A.T.M.A.N.\n");
 		goto out;
 	}
 
-- 
1.8.5.1

