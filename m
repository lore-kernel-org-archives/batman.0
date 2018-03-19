Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:22 +0100
Message-Id: <20180319163726.10921-2-sw@simonwunderlich.de>
In-Reply-To: <20180319163726.10921-1-sw@simonwunderlich.de>
References: <20180319163726.10921-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Fix multicast packet loss
 with a single WANT_ALL_IPV4/6 flag
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Linus Lüssing <linus.luessing@c0d3.blue>

As the kernel doc describes too the code is supposed to skip adding
multicast TT entries if both the WANT_ALL_IPV4 and WANT_ALL_IPV6 flags
are present.

Unfortunately, the current code even skips adding multicast TT entries
if only either the WANT_ALL_IPV4 or WANT_ALL_IPV6 is present.

This could lead to IPv6 multicast packet loss if only an IGMP but not an
MLD querier is present for instance or vice versa.

Fixes: 687937ab3489 ("batman-adv: Add multicast optimization support for bridged setups")
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index cbdeb47ec3f6..d70640135e3a 100644
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

