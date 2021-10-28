Return-Path: <yajun.deng@linux.dev>
From: Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH net-next] batman-adv: Fix the wrong definition
Date: Thu, 28 Oct 2021 15:23:06 +0800
Message-Id: <20211028072306.1351-1-yajun.deng@linux.dev>
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
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>

There are three variables that are required at most,
no need to define four variables.

Fixes: 0fa4c30d710d ("batman-adv: Make sysfs support optional")
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3ddd66e4c29e..758035b3796d 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -656,7 +656,7 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 {
 	int ret = -ENOMEM;
 	struct kobject *bat_kobj;
-	char *uevent_env[4] = { NULL, NULL, NULL, NULL };
+	char *uevent_env[3] = {};
 
 	bat_kobj = &bat_priv->soft_iface->dev.kobj;
 
-- 
2.32.0

