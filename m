Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Mon, 25 Mar 2013 22:27:00 +0100
Message-Id: <1364246820-15581-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: don't check the source address
	twice
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

The source address has already been checked in
batadv_check_management_packet() upon packet reception and
therefore it does not need to be checked again in
ogm_process()

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 bat_iv_ogm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index da239c5..952a1ff 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -1051,9 +1051,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		if (batadv_compare_eth(batadv_ogm_packet->prev_sender,
 				       hard_iface->net_dev->dev_addr))
 			is_my_oldorig = 1;
-
-		if (is_broadcast_ether_addr(ethhdr->h_source))
-			is_broadcast = 1;
 	}
 	rcu_read_unlock();
 
@@ -1071,13 +1068,6 @@ static void batadv_iv_ogm_process(const struct ethhdr *ethhdr,
 		return;
 	}
 
-	if (is_broadcast) {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Drop packet: ignoring all packets with broadcast source addr (sender: %pM)\n",
-			   ethhdr->h_source);
-		return;
-	}
-
 	if (is_my_orig) {
 		unsigned long *word;
 		int offset;
-- 
1.8.1.5

