Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 11 Feb 2014 13:48:01 +0100
Message-Id: <1392122903-805-2-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [RFC 01/23] batman-adv: invoke ogm_schedule() only
	when the interface is activated
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

In the current implementation the first OGM is scheduled
when a new hard-interface is enabled, no matter if it is
active (thus ready for sending packets) or not.

However, the B.A.T.M.A.N. IV OGM scheduling mechanism works
in a way that reschedules the task forever even if the
interface is not yet ready and therefore everything works as
expected.

Unfortunately this behaviour is not fine in general and
other algorithms may pretend the interface to be active
before scheduling the first OGM.

Change this behaviour by scheduling the first OGM upon
interface activation.

Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---
 hard-interface.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index b851cc5..2a04130 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -320,6 +320,8 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 
 	batadv_update_min_mtu(hard_iface->soft_iface);
 
+	/* begin scheduling originator messages on that interface */
+	batadv_schedule_bat_ogm(hard_iface);
 out:
 	if (primary_if)
 		batadv_hardif_free_ref(primary_if);
@@ -459,9 +461,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 			   "Not using interface %s (retrying later): interface not active\n",
 			   hard_iface->net_dev->name);
 
-	/* begin scheduling originator messages on that interface */
-	batadv_schedule_bat_ogm(hard_iface);
-
 out:
 	return 0;
 
-- 
1.8.5.3

