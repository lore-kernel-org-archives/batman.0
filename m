Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 23 Mar 2013 20:09:03 +0100
Message-Id: <1364065743-20076-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: invoke ogm_schedule() only when
	the interface is activated
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

the current implementation works as expected because once
ogm_schedule() has been invoked once it will continue to
invoke itself periodically thanks to the schedule (but not
sent) packets.

A correct behaviour would be to wait for the interface to be
ready for sending before scheduling the first OGM.

Moreover another routing algorithm may not schedule any
packet because the interface is not active yet, and this
would lead to a breakage in the interface activation
procedure

Signed-off-by: Antonio Quartulli <ordex@autistici.org>
---
 hard-interface.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index d55213c..4a1a24b 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -339,6 +339,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
+	/* begin scheduling originator messages on that interface */
+	batadv_schedule_bat_ogm(hard_iface);
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
@@ -453,9 +455,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			   "Not using interface %s (retrying later): interface not active\n",
 			   hard_iface->net_dev->name);
 
-	/* begin scheduling originator messages on that interface */
-	batadv_schedule_bat_ogm(hard_iface);
-
 out:
 	return 0;
 
-- 
1.8.1.5

