Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Wed,  7 Jun 2017 22:51:22 +0800
Message-Id: <20170607145122.18207-1-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH] tp_meter: mark init function with __init
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

batadv_tp_meter_init() is invoked in batadv_init() only
which is marked with __init.

For this reason batadv_tp_meter_init() can be marked with
__init as well and dropped after module load.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 556f9a86..0334c56d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1497,7 +1497,7 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 /**
  * batadv_tp_meter_init - initialize global tp_meter structures
  */
-void batadv_tp_meter_init(void)
+void __init batadv_tp_meter_init(void)
 {
 	get_random_bytes(batadv_tp_prerandom, sizeof(batadv_tp_prerandom));
 }
-- 
2.13.0

