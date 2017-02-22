Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Feb 2017 17:25:41 +0100
Message-Id: <20170222162542.23620-1-sven@narfation.org>
In-Reply-To: <4486600.Xps1bk75uv@bentobox>
References: <4486600.Xps1bk75uv@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: decrease maximum fragment
	size
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

With this patch the maximum fragment size is reduced from 1400 to 1280
bytes.

Fragmentation v2 correctly uses the smaller of 1400 and the interface
MTU, thus generally supporting interfaces with an MTU < 1400 bytes, too.

However, currently "Fragmentation v2" does not support re-fragmentation.
Which means that once a packet is split into two packets of 1400 + x
bytes for instance and the next hop provides an interface with an even
smaller MTU of 1280 bytes, then the larger fragment is lost.

A maximum fragment size of 1280 bytes is a safer option as this is the
minimum MTU required by IPv6, making interfaces with an MTU < 1280
rather exotic.

Regarding performance, this should have no negative impact on unicast
traffic: Having some more bytes in the smaller and some less in the
larger does not change the sum of both fragments.

Concerning TT, choosing 1280 bytes fragments might result in more TT
messages than necessary when a large network is bridged into batman-adv.
However, the TT overhead in general is marginal due to its reactive
nature, therefore such a performance impact on TT should not be
noticeable for a user.

Cc: Matthias Schiffer <mschiffer@universe-factory.net>
[linus.luessing@c0d3.blue: Added commit message]
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
 - rebased on master

 net/batman-adv/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 57a8103..81c6a38 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -168,7 +168,7 @@ enum batadv_uev_type {
 /* Maximum number of fragments for one packet */
 #define BATADV_FRAG_MAX_FRAGMENTS 16
 /* Maxumim size of each fragment */
-#define BATADV_FRAG_MAX_FRAG_SIZE 1400
+#define BATADV_FRAG_MAX_FRAG_SIZE 1280
 /* Time to keep fragments while waiting for rest of the fragments */
 #define BATADV_FRAG_TIMEOUT 10000
 
-- 
2.11.0

