Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun, 16 Feb 2014 13:01:02 +0100
Message-Id: <1392552062-17927-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: compat: fix null pointer
	exception for kernels < 3.9
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

The compat code of the new multicast patchset leads to null pointer
derefernces for kernels 3.9 in netdev_master_upper_dev_get_rcu(). This
is because the initially NULL is assigned to upper, which is equal to
dev. dev is dereferenced one line later, though, leading to a crash.

Fixing this by assigning NULL only when we are sure that the according
pointer is not going to be dereferenced anymore.

Introduced by: 532cadf26cfbb1099ef31fae9ccafcbbfc37b9b5
("batman-adv: Multicast Listener Announcements via Translation Table")

Reported-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Linus Lüssing <linus.luessing@web.de>
---
 compat.h |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/compat.h b/compat.h
index 7a3d235..7beba36 100644
--- a/compat.h
+++ b/compat.h
@@ -162,12 +162,13 @@ static inline int batadv_param_set_copystring(const char *val,
 #define NET_ADDR_RANDOM 0
 
 #define netdev_master_upper_dev_get_rcu(dev) \
-	NULL; \
+	upper; \
 	if (dev->br_port ? 1 : 0) { \
 		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	}
+	} else \
+		dev = NULL;
 
 #endif /* < KERNEL_VERSION(2, 6, 36) */
 
@@ -371,12 +372,13 @@ static int __batadv_interface_tx(struct sk_buff *skb, \
 
 #ifndef netdev_master_upper_dev_get_rcu
 #define netdev_master_upper_dev_get_rcu(dev) \
-	NULL; \
+	upper; \
 	if (dev->priv_flags & IFF_BRIDGE_PORT) { \
 		rcu_read_unlock(); \
 		dev_hold(dev); \
 		return dev; \
-	}
+	} else \
+		dev = NULL;
 
 #endif /* netdev_master_upper_dev_get_rcu */
 
-- 
1.7.10.4

