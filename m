Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 11 Mar 2016 14:04:49 +0100
Message-Id: <1457701489-24562-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Fix broadcast/ogm queue limit
	on a removed interface
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

From: Linus Lüssing <linus.luessing@c0d3.blue>

When removing a single interface while a broadcast or ogm packet is
still pending then we will free the forward packet without releasing the
queue slots again.

This patch is supposed to fix this issue.

Fixes: d5bbce8465af ("batman-adv: Add missing hardif_free_ref in forw_packet_free")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
[sven@narfation.org: fix conflicts with current version]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased patch

Patch was resurrected from https://patchwork.open-mesh.org/patch/2921/

I've requested an rebased version at
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-March/014635.html
but done it myself because it was rather trivial.
---
 net/batman-adv/send.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 3ce06e0..7641785 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -675,6 +675,9 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
+			if (!forw_packet->own)
+				atomic_inc(&bat_priv->bcast_queue_left);
+
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
@@ -702,6 +705,9 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
+			if (!forw_packet->own)
+				atomic_inc(&bat_priv->batman_queue_left);
+
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
-- 
2.7.0

