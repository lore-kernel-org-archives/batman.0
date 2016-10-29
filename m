Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Oct 2016 10:03:26 +0200
Message-Id: <20161029080328.26584-1-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: genetlink: no longer support
	using static family IDs
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

From: Johannes Berg <johannes.berg@intel.com>

Static family IDs have never really been used, the only
use case was the workaround I introduced for those users
that assumed their family ID was also their multicast
group ID.

Additionally, because static family IDs would never be
reserved by the generic netlink code, using a relatively
low ID would only work for built-in families that can be
registered immediately after generic netlink is started,
which is basically only the control family (apart from
the workaround code, which I also had to add code for so
it would reserve those IDs)

Thus, anything other than GENL_ID_GENERATE is flawed and
luckily not used except in the cases I mentioned. Move
those workarounds into a few lines of code, and then get
rid of GENL_ID_GENERATE entirely, making it more robust.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Patch already in net-next

 net/batman-adv/netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index aee20a3..a951e02 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -49,7 +49,6 @@
 #include "translation-table.h"
 
 struct genl_family batadv_netlink_family = {
-	.id = GENL_ID_GENERATE,
 	.hdrsize = 0,
 	.name = BATADV_NL_NAME,
 	.version = 1,
-- 
2.10.1

