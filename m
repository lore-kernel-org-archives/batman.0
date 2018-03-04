Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun,  4 Mar 2018 12:53:29 +0100
Message-Id: <20180304115329.4520-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint v2] batman-adv: Fix multicast packet
 loss with a single WANT_ALL_IPV4/6 flag
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

As the kernel doc describes too the code is supposed to skip adding
multicast TT entries if both the WANT_ALL_IPV4 and WANT_ALL_IPV6 flags
are present.

Unfortunately, the current code even skips adding multicast TT entries
if only either the WANT_ALL_IPV4 or WANT_ALL_IPV6 is present.

This could lead to IPv6 multicast packet loss if only an IGMP but not an
MLD querier is present for instance or vice versa.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
v2: Fixed typo in last sentence: "non" -> "not"

 net/batman-adv/multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 6eaffe50..15a7b314 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -543,8 +543,8 @@ static bool batadv_mcast_mla_tvlv_update(struct batadv_priv *bat_priv)
 		bat_priv->mcast.enabled = true;
 	}
 
-	return !(mcast_data.flags &
-		 (BATADV_MCAST_WANT_ALL_IPV4 | BATADV_MCAST_WANT_ALL_IPV6));
+	return !(mcast_data.flags & BATADV_MCAST_WANT_ALL_IPV4 &&
+		 mcast_data.flags & BATADV_MCAST_WANT_ALL_IPV6);
 }
 
 /**
-- 
2.11.0

