Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 23 Oct 2013 08:22:56 +0200
Message-Id: <1382509376-2105-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH next] batman-adv: remove blank line before
	bracket
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

Fix a style error introduced by bb69cb678d37144842cb66ee5afd0031c3e412a2
("batman-adv: generalize batman-adv icmp packet handling")

Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---

Since Simon is rather busy these days I try to help him by sending this patch :)

Cheers,


 routing.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/routing.c b/routing.c
index c04b7e6..d4114d7 100644
--- a/routing.c
+++ b/routing.c
@@ -318,7 +318,6 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	default:
 		/* drop unknown type */
 		goto out;
-
 	}
 out:
 	if (primary_if)
-- 
1.8.4

