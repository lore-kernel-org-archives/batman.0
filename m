Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 15:57:43 +0200
Message-Id: <20161018135743.3705-8-sven@narfation.org>
In-Reply-To: <2219629.dYY2ZvZvNG@bentobox>
References: <2219629.dYY2ZvZvNG@bentobox>
Subject: [B.A.T.M.A.N.] [PATCH v3 8/8] batman-adv: compat: Move vid api
	wrapper to coccinelle
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
v3:
 - no changes
v2:
 - new patch
---
 compat-include/linux/netdevice.h        |  6 +++
 compat-patches/0005-vid-callbacks.cocci | 74 +++++++++++++++++++++++++++++++++
 compat.h                                | 54 ------------------------
 3 files changed, 80 insertions(+), 54 deletions(-)
 create mode 100644 compat-patches/0005-vid-callbacks.cocci

diff --git a/compat-include/linux/netdevice.h b/compat-include/linux/netdevice.h
index fb5b519..0de9d78 100644
--- a/compat-include/linux/netdevice.h
+++ b/compat-include/linux/netdevice.h
@@ -28,6 +28,12 @@
 
 #include <linux/netdev_features.h>
 
+#define __vid_api_returntype void
+
+#else
+
+#define __vid_api_returntype int
+
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
diff --git a/compat-patches/0005-vid-callbacks.cocci b/compat-patches/0005-vid-callbacks.cocci
new file mode 100644
index 0000000..2cebc0e
--- /dev/null
+++ b/compat-patches/0005-vid-callbacks.cocci
@@ -0,0 +1,74 @@
+@ add_assignment @
+identifier batadv_interface_add_vid, batadv_netdev_ops;
+@@
+
+ struct net_device_ops batadv_netdev_ops = {
+ 	.ndo_vlan_rx_add_vid = batadv_interface_add_vid,
+ };
+
+@ kill_assignment @
+identifier batadv_interface_kill_vid, batadv_netdev_ops;
+@@
+
+ struct net_device_ops batadv_netdev_ops = {
+ 	.ndo_vlan_rx_kill_vid = batadv_interface_kill_vid,
+ };
+
+@ add_vid @
+identifier add_assignment.batadv_interface_add_vid;
+type be16;
+identifier dev, proto, vid;
+@@
+
+-batadv_interface_add_vid
++batadv_interface_add_vid_orig
+			       (struct net_device *dev, be16 proto,
+				unsigned short vid)
+ { ... }
+
++static __vid_api_returntype batadv_interface_add_vid(struct net_device *dev,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
++			   			      be16 proto,
++#endif
++			   			      unsigned short vid)
++{
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
++    be16 proto = htons(ETH_P_8021Q);
++#endif
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
++	batadv_interface_add_vid_orig(dev, proto, vid);
++#else
++	return batadv_interface_add_vid_orig(dev, proto, vid);
++#endif
++}
+
+
+@ kill_vid @
+identifier kill_assignment.batadv_interface_kill_vid;
+type be16;
+identifier dev, proto, vid;
+@@
+
+-batadv_interface_kill_vid
++batadv_interface_kill_vid_orig
+			       (struct net_device *dev, be16 proto,
+				unsigned short vid)
+ { ... }
+
++static __vid_api_returntype batadv_interface_kill_vid(struct net_device *dev,
++#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 10, 0)
++			   			       be16 proto,
++#endif
++			   			       unsigned short vid)
++{
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
++    be16 proto = htons(ETH_P_8021Q);
++#endif
++
++#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
++	batadv_interface_kill_vid_orig(dev, proto, vid);
++#else
++	return batadv_interface_kill_vid_orig(dev, proto, vid);
++#endif
++}
diff --git a/compat.h b/compat.h
index 2865eeb..d59fb5f 100644
--- a/compat.h
+++ b/compat.h
@@ -42,31 +42,6 @@
 
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 3, 0)
-
-#define batadv_interface_add_vid(x, y, z) \
-__batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-                          unsigned short vid);\
-static void batadv_interface_add_vid(struct net_device *dev, unsigned short vid)\
-{\
-       __batadv_interface_add_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-                                     unsigned short vid)
-
-#define batadv_interface_kill_vid(x, y, z) \
-__batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-                           unsigned short vid);\
-static void batadv_interface_kill_vid(struct net_device *dev,\
-                                     unsigned short vid)\
-{\
-       __batadv_interface_kill_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-                                      unsigned short vid)
-
-#endif /* < KERNEL_VERSION(3, 3, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define batadv_interface_set_mac_addr(x, y) \
@@ -95,35 +70,6 @@ static int __batadv_interface_tx(struct sk_buff *skb, \
 
 #endif /* < KERNEL_VERSION(3, 9, 0) */
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 10, 0)
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 3, 0)
-
-#define batadv_interface_add_vid(x, y, z) \
-__batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-			   unsigned short vid);\
-static int batadv_interface_add_vid(struct net_device *dev, unsigned short vid)\
-{\
-	return __batadv_interface_add_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_add_vid(struct net_device *dev, __be16 proto,\
-				      unsigned short vid)
-
-#define batadv_interface_kill_vid(x, y, z) \
-__batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-			    unsigned short vid);\
-static int batadv_interface_kill_vid(struct net_device *dev,\
-				     unsigned short vid)\
-{\
-	return __batadv_interface_kill_vid(dev, htons(ETH_P_8021Q), vid);\
-}\
-static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
-				       unsigned short vid)
-
-#endif /* >= KERNEL_VERSION(3, 3, 0) */
-
-#endif /* < KERNEL_VERSION(3, 10, 0) */
-
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 15, 0)
 
 /* the expected behaviour of this function is to return 0 on success, therefore
-- 
2.9.3

