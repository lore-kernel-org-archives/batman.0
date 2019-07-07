Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH maint] batman-adv: Fix netlink dumping of all mcast_flags
 buckets
Date: Sun,  7 Jul 2019 22:19:22 +0200
Message-Id: <20190707201922.13997-1-sven@narfation.org>
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
To: b.a.t.m.a.n@lists.open-mesh.org

The bucket variable is only updated outside the loop over the mcast_flags
buckets. It will only be updated during a dumping run when the dumping has
to be interrupted and a new message has to be started.

This could result in repeated or missing entries when the multicast flags
are dumped to userspace.

Fixes: 06c82b7b15b1 ("batman-adv: Add inconsistent multicast netlink dump detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 67d7f830..a3488cfb 100644
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

