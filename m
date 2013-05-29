Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 10:10:39 +0200
Message-Id: <1369815051-708-10-git-send-email-ordex@autistici.org>
In-Reply-To: <1369815051-708-1-git-send-email-ordex@autistici.org>
References: <1369815051-708-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH 09/21] batman-adv: don't initialise batman_iv
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

hard-interface.c has to do not contain any routing algorithm
specific code.

Allocate the hard-interface with kzalloc() and remove any
useless and algorithm specific member initialisation

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
---
 net/batman-adv/hard-interface.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 4a76ed6..c478e6b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
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

