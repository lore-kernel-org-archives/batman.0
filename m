Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Fri, 26 Jul 2013 20:50:45 +0200
Message-Id: <1374864646-19268-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: check return type of unicast
	packet preparations
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
 send.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/send.c b/send.c
index d2cc507..9c9cab6 100644
--- a/send.c
+++ b/send.c
@@ -266,11 +266,14 @@ static int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 
 	switch (packet_type) {
 	case BATADV_UNICAST:
-		batadv_send_skb_prepare_unicast(skb, orig_node);
+		if (!batadv_send_skb_prepare_unicast(skb, orig_node))
+			goto out;
 		break;
 	case BATADV_UNICAST_4ADDR:
-		batadv_send_skb_prepare_unicast_4addr(bat_priv, skb, orig_node,
-						      packet_subtype);
+		if (!batadv_send_skb_prepare_unicast_4addr(bat_priv, skb,
+							   orig_node,
+							   packet_subtype))
+			goto out;
 		break;
 	default:
 		/* this function supports UNICAST and UNICAST_4ADDR only. It
-- 
1.7.10.4

