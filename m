Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Fri,  6 May 2016 02:46:41 +0800
Message-Id: <1462474003-25279-5-git-send-email-a@unstable.cc>
In-Reply-To: <1462474003-25279-1-git-send-email-a@unstable.cc>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: statically print MAX TQ
	value in gateway table header
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
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

To make it easier to search through the code it is better to print static
strings directly instead of using format strings printing constants.

This was addressed in a previous patch, but the Gateway table header
was not updated accordingly.

Directly print the number 255 instead of using %s with BATADV_TQ_MAX_VALUE.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/gateway_client.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index acf85b1..18c3715 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -638,10 +638,9 @@ int batadv_gw_client_seq_print_text(struct seq_file *seq, void *offset)
 		goto out;
 
 	seq_printf(seq,
-		   "      Gateway      (#/%i)           Nexthop [outgoingIF]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
-		   BATADV_TQ_MAX_VALUE, BATADV_SOURCE_VERSION,
-		   primary_if->net_dev->name, primary_if->net_dev->dev_addr,
-		   net_dev->name);
+		   "      Gateway      (#/255)           Nexthop [outgoingIF]: advertised uplink bandwidth ... [B.A.T.M.A.N. adv %s, MainIF/MAC: %s/%pM (%s)]\n",
+		   BATADV_SOURCE_VERSION, primary_if->net_dev->name,
+		   primary_if->net_dev->dev_addr, net_dev->name);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(gw_node, &bat_priv->gw.list, list) {
-- 
2.8.2

