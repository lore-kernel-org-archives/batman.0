Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 20 Mar 2018 02:19:24 +0100
Message-Id: <20180320011924.28287-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batctl: netlink: fix resetting
 mcast_flags_priv to unsupported state
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

This fixes a copy & paste error detected by Coverity.

Fixes: b56061058113 ("batctl: add netlink dump function for multicast flags table")
Reported-by: scan-admin@coverity.com
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink.c b/netlink.c
index ab7be1e..f0fd1d9 100644
--- a/netlink.c
+++ b/netlink.c
@@ -252,7 +252,7 @@ static int info_callback(struct nl_msg *msg, void *arg)
 		if (attrs[BATADV_ATTR_MCAST_FLAGS_PRIV])
 			mcast_flags_priv = nla_get_u32(attrs[BATADV_ATTR_MCAST_FLAGS_PRIV]);
 		else
-			mcast_flags = -EOPNOTSUPP;
+			mcast_flags_priv = -EOPNOTSUPP;
 
 		switch (opts->nl_cmd) {
 		case BATADV_CMD_GET_TRANSTABLE_LOCAL:
-- 
2.11.0

