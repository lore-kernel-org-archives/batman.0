Return-Path: <artem.chernyshev@red-soft.ru>
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: [PATCH] batman-adv: Check return value
Date: Sun, 25 Dec 2022 02:33:11 +0300
Message-Id: <20221224233311.48678-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Check, if rtnl_link_register() call in batadv_init() was successful

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: a4ac28c0d06a ("batman-adv: Allow to use rntl_link for device creation/deletion")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 net/batman-adv/main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a449915566..04cd9682bd29 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -113,7 +113,11 @@ static int __init batadv_init(void)
 		goto err_create_wq;
 
 	register_netdevice_notifier(&batadv_hard_if_notifier);
-	rtnl_link_register(&batadv_link_ops);
+	ret = rtnl_link_register(&batadv_link_ops);
+	if (ret) {
+		pr_err("Can't register link_ops\n");
+		goto err_create_wq;
+	}
 	batadv_netlink_register();
 
 	pr_info("B.A.T.M.A.N. advanced %s (compatibility version %i) loaded\n",
-- 
2.30.3

