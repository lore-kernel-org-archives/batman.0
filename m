Return-Path: <a@unstable.cc>
From: Antonio Quartulli <a@unstable.cc>
Date: Fri,  6 May 2016 02:46:37 +0800
Message-Id: <1462474003-25279-1-git-send-email-a@unstable.cc>
Subject: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>, mareklindner@neomailbox.ch

the compiler can optimize functions within the same C file and therefore
there is no need to make it explicit.

Remove the useless inline attribute for __batadv_store_uint_attr()

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 net/batman-adv/sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/sysfs.c b/net/batman-adv/sysfs.c
index 414b207..b99ea80 100644
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
+static ssize_t __batadv_store_uint_attr(const char *buff, size_t count, int min,
+					int max,
+					void (*post_func)(struct net_device *),
+					const struct attribute *attr,
+					atomic_t *attr_store,
+					struct net_device *net_dev)
 {
 	int ret;
 
-- 
2.8.2

