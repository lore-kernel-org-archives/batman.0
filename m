Return-Path: <pakki001@umn.edu>
From: Aditya Pakki <pakki001@umn.edu>
Date: Mon, 24 Dec 2018 11:49:26 -0600
Message-Id: <20181224174926.20321-1-pakki001@umn.edu>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv/main: Fix check on return value
 of rtnl_link_register
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

rtnl_link_register() may fail and can impact registering the device.
The fix checks the return value and pushes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/batman-adv/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 69c0d85bceb3..e0007f242823 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -109,7 +109,10 @@ static int __init batadv_init(void)
 	batadv_debugfs_init();
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret < 0)
+		return ret;
+
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-- 
2.17.1

