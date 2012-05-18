Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 May 2012 17:16:13 +0200
Message-Id: <1337354173-23825-1-git-send-email-sven@narfation.org>
In-Reply-To: <1337192605-8652-12-git-send-email-sven@narfation.org>
References: <1337192605-8652-12-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCH] batman-adv: Prefix bat_sysfs local static
	functions with batadv_
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

All non-static symbols of batman-adv were prefixed with batadv_ to avoid
collisions with other symbols of the kernel. Other symbols of batman-adv
should use the same prefix to keep the naming scheme consistent.

This was actually part of patch used to create the commit
98881e49493eb1a6ae2330d861386432064b2222.

Signed-off-by: Sven Eckelmann <sven@narfation.org>

This is the alternative version of this patch... that keeps the functionality
for ELP

 bat_sysfs.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bat_sysfs.c b/bat_sysfs.c
index 336a61d..07fde83 100644
--- a/bat_sysfs.c
+++ b/bat_sysfs.c
@@ -123,8 +123,9 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 
 
 #define BAT_ATTR_HIF_STORE_UINT(_name, _min, _max, _post_func)		\
-ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
-		      char *buff, size_t count)				\
+ssize_t batadv_store_##_name(struct kobject *kobj,			\
+			     struct attribute *attr, char *buff,	\
+			     size_t count)				\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct hard_iface *hard_iface;					\
@@ -142,8 +143,8 @@ ssize_t store_##_name(struct kobject *kobj, struct attribute *attr,	\
 }
 
 #define BAT_ATTR_HIF_SHOW_UINT(_name)					\
-ssize_t show_##_name(struct kobject *kobj,				\
-		     struct attribute *attr, char *buff)		\
+ssize_t batadv_show_##_name(struct kobject *kobj,			\
+			    struct attribute *attr, char *buff)		\
 {									\
 	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
 	struct hard_iface *hard_iface;					\
-- 
1.7.10

