Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue,  2 Apr 2013 12:16:53 +0200
Message-Id: <1364897813-19421-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't initialise batman_iv
	private members in hard-interface.c
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

hard-interface.c has to do not contain any routing algorithm
specific code.

Allocate the hard-interface with kzalloc() and remove any
useless and algorithm specific member initialisation

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 hard-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 18f4523..dc4ac29 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -577,7 +577,7 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 
 	dev_hold(net_dev);
 
-	hard_iface = kmalloc(sizeof(*hard_iface), GFP_ATOMIC);
+	hard_iface = kzalloc(sizeof(*hard_iface), GFP_ATOMIC);
 	if (!hard_iface)
 		goto release_dev;
 
@@ -603,12 +603,6 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	batadv_check_known_mac_addr(hard_iface->net_dev);
 	list_add_tail_rcu(&hard_iface->list, &batadv_hardif_list);
 
-	/* This can't be called via a bat_priv callback because
-	 * we have no bat_priv yet.
-	 */
-	atomic_set(&hard_iface->bat_iv.ogm_seqno, 1);
-	hard_iface->bat_iv.ogm_buff = NULL;
-
 	return hard_iface;
 
 free_if:
-- 
1.8.1.5

