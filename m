Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 21 Sep 2013 12:28:14 +0200
Message-Id: <1379759294-1481-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix DAT candidate selection
	(must use vid)
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

Now that DAT is VLAN aware, it must use the VID when
computing the DHT address of the candidate nodes where
an entry is going to be stored/retrieved.

Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
("batman-adv: make the Distributed ARP Table vlan aware")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 distributed-arp-table.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/distributed-arp-table.c b/distributed-arp-table.c
index 6c8c393..d4b3940 100644
--- a/distributed-arp-table.c
+++ b/distributed-arp-table.c
@@ -530,11 +530,13 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
+			     unsigned short vid)
 {
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
 	struct batadv_dat_candidate *res;
+	struct batadv_dat_entry to_hash;
 
 	if (!bat_priv->orig_hash)
 		return NULL;
@@ -543,7 +545,10 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 	if (!res)
 		return NULL;
 
-	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
+	to_hash.ip = ip_dst;
+	to_hash.vid = vid;
+
+	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&to_hash,
 						    BATADV_DAT_ADDR_MAX);
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv,
@@ -572,7 +577,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 unsigned short vid, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -581,7 +586,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
 
-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
 		goto out;
 
@@ -969,7 +974,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+		ret = batadv_dat_send_data(bat_priv, skb, ip_dst, vid,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1092,8 +1097,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
 }
 /**
  * batadv_dat_snoop_incoming_arp_reply - snoop the ARP reply and fill the local
-- 
1.8.1.5

