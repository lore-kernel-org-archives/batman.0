Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sat, 27 Jul 2013 03:24:44 +0200
Message-Id: <1374888285-20775-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH next 1/2] batman-adv: check return type of
	unicast packet preparations
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

batadv_send_skb_prepare_unicast(_4addr) might reallocate the skb's data.
And if it tries to do so then this can potentially fail.

We shouldn't continue working on this skb in such a case.

Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 unicast.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/unicast.c b/unicast.c
index dc8b5d4..4c5a1aa 100644
--- a/unicast.c
+++ b/unicast.c
@@ -428,11 +428,13 @@ find_router:
 
 	switch (packet_type) {
 	case BATADV_UNICAST:
-		batadv_unicast_prepare_skb(skb, orig_node);
+		if (!batadv_unicast_prepare_skb(skb, orig_node))
+			goto out;
 		break;
 	case BATADV_UNICAST_4ADDR:
-		batadv_unicast_4addr_prepare_skb(bat_priv, skb, orig_node,
-						 packet_subtype);
+		if (!batadv_unicast_4addr_prepare_skb(bat_priv, skb, orig_node,
+						      packet_subtype))
+			goto out;
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
-- 
1.7.10.4

