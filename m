Return-Path: <ap420073@gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH v3 net] batman-adv: set .owner to THIS_MODULE
Date: Sun, 15 Nov 2020 10:30:04 +0000
Message-Id: <20201115103004.30618-1-ap420073@gmail.com>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, sven@narfation.org, b.a.t.m.a.n@lists.open-mesh.org
Cc: ap420073@gmail.com

If THIS_MODULE is not set, the module would be removed while debugfs is
being used.
It eventually makes kernel panic.

Fixes: 9e466250ede3 ("batman-adv: Prefix bat_debugfs local static functions with batadv_")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Separate from one big series

v2:
 - Change headline
 - Squash patches into per-driver/subsystem

 net/batman-adv/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/log.c b/net/batman-adv/log.c
index a67b2b091447..c0ca5fbe5b08 100644
--- a/net/batman-adv/log.c
+++ b/net/batman-adv/log.c
@@ -180,6 +180,7 @@ static const struct file_operations batadv_log_fops = {
 	.read           = batadv_log_read,
 	.poll           = batadv_log_poll,
 	.llseek         = no_llseek,
+	.owner          = THIS_MODULE,
 };
 
 /**
-- 
2.17.1

