Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2012 09:16:10 +0100
Message-Id: <1351498570-5409-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Remove unused define
	BAT_ATTR_HIF_UINT
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

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- Rebased this patch from May on top of current master

 sysfs.c |   50 --------------------------------------------------
 1 file changed, 50 deletions(-)

diff --git a/sysfs.c b/sysfs.c
index cc56ed0..9dc58b5 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -123,56 +123,6 @@ ssize_t batadv_show_##_name(struct kobject *kobj,			\
 			   batadv_store_##_name)
 
 
-#define BATADV_ATTR_HIF_STORE_UINT(_name, _var, _min, _max, _post_func)	\
-ssize_t batadv_store_##_name(struct kobject *kobj,			\
-			     struct attribute *attr, char *buff,	\
-			     size_t count)				\
-{									\
-	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct batadv_hard_iface *hard_iface;				\
-	ssize_t length;							\
-									\
-	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
-	if (!hard_iface)						\
-		return 0;						\
-									\
-	length = __batadv_store_uint_attr(buff, count, _min, _max,	\
-					  _post_func, attr,		\
-					  &hard_iface->_var, net_dev);	\
-									\
-	batadv_hardif_free_ref(hard_iface);				\
-	return length;							\
-}
-
-#define BATADV_ATTR_HIF_SHOW_UINT(_name, _var)				\
-ssize_t batadv_show_##_name(struct kobject *kobj,			\
-			    struct attribute *attr, char *buff)		\
-{									\
-	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);	\
-	struct batadv_hard_iface *hard_iface;				\
-	ssize_t length;							\
-									\
-	hard_iface = batadv_hardif_get_by_netdev(net_dev);		\
-	if (!hard_iface)						\
-		return 0;						\
-									\
-	length = sprintf(buff, "%i\n", atomic_read(&hard_iface->_var));	\
-									\
-	batadv_hardif_free_ref(hard_iface);				\
-	return length;							\
-}
-
-/* Use this, if you are going to set [name] in hard_iface to an
- * unsigned integer value
- */
-#define BATADV_ATTR_HIF_UINT(_name, _var, _mode, _min, _max, _post_func)\
-	static BATADV_ATTR_HIF_STORE_UINT(_name, _var, _min,		\
-					  _max, _post_func)		\
-	static BATADV_ATTR_HIF_SHOW_UINT(_name, _var)			\
-	static BATADV_ATTR(_name, _mode, batadv_show_##_name,		\
-			   batadv_store_##_name)
-
-
 static int batadv_store_bool_attr(char *buff, size_t count,
 				  struct net_device *net_dev,
 				  const char *attr_name, atomic_t *attr)
-- 
1.7.10.4

