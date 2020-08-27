Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batman-adv: bla: fix type misuse for backbone_gw hash indexing
Date: Thu, 27 Aug 2020 17:34:48 +0200
Message-Id: <20200827153448.3935-1-linus.luessing@c0d3.blue>
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
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <ll@simonwunderlich.de>

From: Linus L=C3=BCssing <ll@simonwunderlich.de>

It seems that due to a copy & paste error the void pointer
in batadv_choose_backbone_gw() is cast to the wrong type.

Fixing this by using "struct batadv_bla_backbone_gw" instead of "struct
batadv_bla_claim" which better matches the caller's side.

For now it seems that we were lucky because the two structs both have
their orig/vid and addr/vid in the beginning. However I stumbled over
this issue when I was trying to add some debug variables in front of
"orig" in batadv_backbone_gw, which caused hash lookups to fail.

Fixes: 7e15c9305ce0 ("batman-adv: don't rely on positions in struct for h=
ashing")
Signed-off-by: Linus L=C3=BCssing <ll@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/brid=
ge_loop_avoidance.c
index b643dadc..4ba984bf 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -88,11 +88,12 @@ static inline u32 batadv_choose_claim(const void *dat=
a, u32 size)
  */
 static inline u32 batadv_choose_backbone_gw(const void *data, u32 size)
 {
-	const struct batadv_bla_claim *claim =3D (struct batadv_bla_claim *)dat=
a;
+	const struct batadv_bla_backbone_gw *gw;
 	u32 hash =3D 0;
=20
-	hash =3D jhash(&claim->addr, sizeof(claim->addr), hash);
-	hash =3D jhash(&claim->vid, sizeof(claim->vid), hash);
+	gw =3D (struct batadv_bla_backbone_gw *)data;
+	hash =3D jhash(&gw->orig, sizeof(gw->orig), hash);
+	hash =3D jhash(&gw->vid, sizeof(gw->vid), hash);
=20
 	return hash % size;
 }
--=20
2.28.0.rc1
