Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v3 2/3] batman-adv: bcast: avoid skb-copy for (re)queued broadcasts
Date: Mon, 17 May 2021 00:33:08 +0200
Message-Id: <20210516223309.12596-2-linus.luessing@c0d3.blue>
In-Reply-To: <20210516223309.12596-1-linus.luessing@c0d3.blue>
References: <20210516223309.12596-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

Broadcast packets send via batadv_send_outstanding_bcast_packet() were
originally copied in batadv_forw_bcast_packet_to_list() before being
queued. And after that only the ethernet header will be pushed through
batadv_send_broadcast_skb()->batadv_send_skb_packet() which works safely
on skb clones as it uses batadv_skb_head_push()->skb_cow_head().

Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---

Changelog v3:

* newly added this patch, to move skb_copy()->skb_clone() change from
  PATCH 01/03 to a separate patch with its own explanation

 net/batman-adv/send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 07b0ba26..0b9dd29d 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -1072,7 +1072,7 @@ static void batadv_send_outstanding_bcast_packet(st=
ruct work_struct *work)
 	}
=20
 	/* send a copy of the saved skb */
-	skb1 =3D skb_copy(forw_packet->skb, GFP_ATOMIC);
+	skb1 =3D skb_clone(forw_packet->skb, GFP_ATOMIC);
 	if (!skb1)
 		goto out;
=20
--=20
2.31.0
