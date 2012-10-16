Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 16 Oct 2012 08:24:41 +0200
Message-Id: <1350368681-24616-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: remove bogus kernel-doc for
	batadv_vis_data_open()
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

This patch removes some bogus kernel-doc for batadv_vis_data_open() in debugfs.c

This was introduced with ("batman-adv: Distributed ARP Table - implement local
storage")

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 debugfs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/debugfs.c b/debugfs.c
index 61c7d4d..3f679cb 100644
--- a/debugfs.c
+++ b/debugfs.c
@@ -300,11 +300,6 @@ static int batadv_transtable_local_open(struct inode *inode, struct file *file)
 	return single_open(file, batadv_tt_local_seq_print_text, net_dev);
 }
 
-/**
- * batadv_vis_data_open - prepare file handler for reads from dat_cache
- * @inode:
- * @file:
- */
 static int batadv_vis_data_open(struct inode *inode, struct file *file)
 {
 	struct net_device *net_dev = (struct net_device *)inode->i_private;
-- 
1.7.12.3

