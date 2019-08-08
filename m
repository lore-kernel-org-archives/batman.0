Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 1/2] batman-adv: Fix netlink dumping of all mcast_flags buckets
Date: Thu,  8 Aug 2019 15:02:07 +0200
Message-Id: <20190808130208.2124-2-sw@simonwunderlich.de>
In-Reply-To: <20190808130208.2124-1-sw@simonwunderlich.de>
References: <20190808130208.2124-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>, Simon Wunderlich <sw@simonwunderlich.de>

From: Sven Eckelmann <sven@narfation.org>

The bucket variable is only updated outside the loop over the mcast_flags
buckets. It will only be updated during a dumping run when the dumping has
to be interrupted and a new message has to be started.

This could result in repeated or missing entries when the multicast flags
are dumped to userspace.

Fixes: d2d489b7d851 ("batman-adv: Add inconsistent multicast netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 67d7f83009ae..a3488cfb3d1e 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2303,7 +2303,7 @@ __batadv_mcast_flags_dump(struct sk_buff *msg, u32 portid,
 
 	while (bucket_tmp < hash->size) {
 		if (batadv_mcast_flags_dump_bucket(msg, portid, cb, hash,
-						   *bucket, &idx_tmp))
+						   bucket_tmp, &idx_tmp))
 			break;
 
 		bucket_tmp++;
-- 
2.20.1

