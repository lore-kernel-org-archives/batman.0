Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri,  1 Jul 2016 15:09:01 +0200
Message-Id: <1467378549-9646-10-git-send-email-sw@simonwunderlich.de>
In-Reply-To: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
References: <1467378549-9646-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCH 09/17] batman-adv: remove useless inline
	attribute for sysfs helper function
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

From: Antonio Quartulli <a@unstable.cc>

the compiler can optimize functions within the same C file and therefore
there is no need to make it explicit.

Remove the useless inline attribute for __batadv_store_uint_attr()

Signed-off-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 414b207..ef5832f 100644
--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -389,12 +389,12 @@ static int batadv_store_uint_attr(const char *buff, size_t count,
 	return count;
 }
 
-static inline ssize_t
-__batadv_store_uint_attr(const char *buff, size_t count,
-			 int min, int max,
-			 void (*post_func)(struct net_device *),
-			 const struct attribute *attr,
-			 atomic_t *attr_store, struct net_device *net_dev)
+static ssize_t __batadv_store_uint_attr(const char *buff, size_t count,
+					int min, int max,
+					void (*post_func)(struct net_device *),
+					const struct attribute *attr,
+					atomic_t *attr_store,
+					struct net_device *net_dev)
 {
 	int ret;
 
-- 
2.8.1

