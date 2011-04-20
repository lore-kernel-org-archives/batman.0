Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 20 Apr 2011 08:54:39 +0200
Message-Id: <1303282479-17392-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Move definition of
	atomic_dec_not_zero() into main.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

atomic_dec_not_zero() is very usefull and it is currently defined
multiple times. So it is possible to move it in main.h
---
 aggregation.c |    1 -
 main.h        |    2 ++
 send.c        |    1 -
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/aggregation.c b/aggregation.c
index af45d6b..c11788c 100644
--- a/aggregation.c
+++ b/aggregation.c
@@ -95,7 +95,6 @@ static bool can_aggregate_with(struct batman_packet *new_batman_packet,
 	return false;
 }
 
-#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
 /* create a new aggregated packet and add this packet to it */
 static void new_aggregated_packet(unsigned char *packet_buff, int packet_len,
 				  unsigned long send_time, bool direct_link,
diff --git a/main.h b/main.h
index a0059dd..101d9dc 100644
--- a/main.h
+++ b/main.h
@@ -177,4 +177,6 @@ static inline int compare_eth(void *data1, void *data2)
 	return (memcmp(data1, data2, ETH_ALEN) == 0 ? 1 : 0);
 }
 
+#define atomic_dec_not_zero(v)	atomic_add_unless((v), -1, 0)
+
 #endif /* _NET_BATMAN_ADV_MAIN_H_ */
diff --git a/send.c b/send.c
index e78670c..7650e2b 100644
--- a/send.c
+++ b/send.c
@@ -393,7 +393,6 @@ static void _add_bcast_packet_to_list(struct bat_priv *bat_priv,
 			   send_time);
 }
 
-#define atomic_dec_not_zero(v)          atomic_add_unless((v), -1, 0)
 /* add a broadcast packet to the queue and setup timers. broadcast packets
  * are sent multiple times to increase probability for beeing received.
  *
-- 
1.7.3.4

