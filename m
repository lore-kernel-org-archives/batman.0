Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Thu, 18 Apr 2013 00:08:36 +0200
Message-Id: <1366236516-14512-1-git-send-email-linus.luessing@web.de>
In-Reply-To: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
References: <1366235673-13763-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 1/2] batman-adv: Fix broadcast/ogm queue
	limit on a removed interface
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

When removing a single interface while a broadcast or ogm packet is
still pending then we will free the forward packet without releasing the
queue slots again.

This patch is supposed to fix this issue.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 send.c |    6 ++++++
 1 file changed, 6 insertions(+)


* v2: Fix summary line of commit message: This issue can happen for both
      OGMs and broadcast packets.

diff --git a/send.c b/send.c
index ed7072a..2d539d6 100644
--- a/send.c
+++ b/send.c
@@ -356,6 +356,9 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
+			if (!forw_packet->own)
+				atomic_inc(&bat_priv->bcast_queue_left);
+
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
@@ -382,6 +385,9 @@ batadv_purge_outstanding_packets(struct batadv_priv *bat_priv,
 
 		if (pending) {
 			hlist_del(&forw_packet->list);
+			if (!forw_packet->own)
+				atomic_inc(&bat_priv->batman_queue_left);
+
 			batadv_forw_packet_free(forw_packet);
 		}
 	}
-- 
1.7.10.4

