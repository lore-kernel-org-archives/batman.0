Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 12 Mar 2016 11:12:59 +0100
Message-Id: <1457777579-28982-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: fix DAT candidate selection
	(must use vid)
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
Cc: Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

Now that DAT is VLAN aware, it must use the VID when
computing the DHT address of the candidate nodes where
an entry is going to be stored/retrieved.

Fixes: 3e26722bc9f2 ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Antonio Quartulli <a@unstable.cc>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased patch
 - added kernel-doc for new parameters

Patch was resurrected from https://patchwork.open-mesh.org/patch/3427/

I've requested an rebased version at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014636.html
but done it myself because it was rather trivial.
---
 net/batman-adv/distributed-arp-table.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 771708c..3b7b141 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -568,6 +568,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * be sent to
  * @bat_priv: the bat priv with all the soft interface information
  * @ip_dst: ipv4 to look up in the DHT
+ * @vid: VLAN identifier
  *
  * An originator O is selected if and only if its DHT_ID value is one of three
  * closest values (from the LEFT, with wrap around if needed) then the hash
@@ -576,7 +577,8 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  * Return: the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
 static struct batadv_dat_candidate *
-batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
+batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
+			     unsigned short vid)
 {
 	int select;
 	batadv_dat_addr_t last_max = BATADV_DAT_ADDR_MAX, ip_key;
@@ -592,7 +594,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
 		return NULL;
 
 	dat.ip = ip_dst;
-	dat.vid = 0;
+	dat.vid = vid;
 	ip_key = (batadv_dat_addr_t)batadv_hash_dat(&dat,
 						    BATADV_DAT_ADDR_MAX);
 
@@ -612,6 +614,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  * @bat_priv: the bat priv with all the soft interface information
  * @skb: payload to send
  * @ip: the DHT key
+ * @vid: VLAN identifier
  * @packet_subtype: unicast4addr packet subtype to use
  *
  * This function copies the skb with pskb_copy() and is sent as unicast packet
@@ -622,7 +625,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
  */
 static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 				 struct sk_buff *skb, __be32 ip,
-				 int packet_subtype)
+				 unsigned short vid, int packet_subtype)
 {
 	int i;
 	bool ret = false;
@@ -631,7 +634,7 @@ static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
 	struct sk_buff *tmp_skb;
 	struct batadv_dat_candidate *cand;
 
-	cand = batadv_dat_select_candidates(bat_priv, ip);
+	cand = batadv_dat_select_candidates(bat_priv, ip, vid);
 	if (!cand)
 		goto out;
 
@@ -1022,7 +1025,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		ret = true;
 	} else {
 		/* Send the request to the DHT */
-		ret = batadv_dat_send_data(bat_priv, skb, ip_dst,
+		ret = batadv_dat_send_data(bat_priv, skb, ip_dst, vid,
 					   BATADV_P_DAT_DHT_GET);
 	}
 out:
@@ -1150,8 +1153,8 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 	/* Send the ARP reply to the candidates for both the IP addresses that
 	 * the node obtained from the ARP reply
 	 */
-	batadv_dat_send_data(bat_priv, skb, ip_src, BATADV_P_DAT_DHT_PUT);
-	batadv_dat_send_data(bat_priv, skb, ip_dst, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT);
+	batadv_dat_send_data(bat_priv, skb, ip_dst, vid, BATADV_P_DAT_DHT_PUT);
 }
 
 /**
-- 
2.7.0

