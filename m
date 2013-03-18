Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Mon, 18 Mar 2013 06:09:54 +0100
Message-Id: <1363583397-4800-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1363583397-4800-1-git-send-email-linus.luessing@web.de>
References: <201303071427.27817.lindner_marek@yahoo.de>
 <1363583397-4800-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Remove unnecessary
	INIT_HLIST_NODE() calls
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

There's no need to for an explicit hlist_node initialization if it is
added to a list right away, like it's the case with the
hlist_add_head()s here.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 bat_iv_ogm.c |    2 --
 send.c       |    2 --
 2 files changed, 4 deletions(-)

diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
index 4e33e0e..77568ba 100644
--- a/bat_iv_ogm.c
+++ b/bat_iv_ogm.c
@@ -409,8 +409,6 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	}
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN + NET_IP_ALIGN);
 
-	INIT_HLIST_NODE(&forw_packet_aggr->list);
-
 	skb_buff = skb_put(forw_packet_aggr->skb, packet_len);
 	forw_packet_aggr->packet_len = packet_len;
 	memcpy(skb_buff, packet_buff, packet_len);
diff --git a/send.c b/send.c
index 08ac5e8..c151982 100644
--- a/send.c
+++ b/send.c
@@ -217,8 +217,6 @@ _batadv_add_bcast_packet_to_list(struct batadv_priv *bat_priv,
 				 struct batadv_forw_packet *forw_packet,
 				 unsigned long send_time)
 {
-	INIT_HLIST_NODE(&forw_packet->list);
-
 	/* add new packet to packet list */
 	spin_lock_bh(&bat_priv->forw_bcast_list_lock);
 	hlist_add_head(&forw_packet->list, &bat_priv->forw_bcast_list);
-- 
1.7.10.4

