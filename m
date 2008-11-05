Date: Wed, 5 Nov 2008 15:48:38 +0100
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Message-ID: <20081105144838.GA30895@sven-desktop.lazhur.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH] Use device_create instead of
	device_create_drvdata in linux modules
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

The function device_create_drvdata was renamed to device_create in linux
v2.6.26-5782-g4e10673. Until v2.6.27-4446-g7fb6b5d there was a compatibility
define in include/linux/device.h which is removed in linux 2.6.28-rc1.

Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv-kernelland/batman-core/compat.h |   10 +++++++++-
 batman-adv-kernelland/batman-core/device.c |    2 +-
 batman/linux/modules/compat26.h            |   12 +++++++++++-
 batman/linux/modules/gateway.c             |    2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/batman-adv-kernelland/batman-core/compat.h b/batman-adv-kernelland/batman-core/compat.h
index 5f58f8f..3704656 100644
--- a/batman-adv-kernelland/batman-core/compat.h
+++ b/batman-adv-kernelland/batman-core/compat.h
@@ -38,10 +38,18 @@
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 26)
 
-#define device_create_drvdata(_cls, _parent, _devt, _device, _fmt) \
+#define device_create(_cls, _parent, _devt, _device, _fmt) \
 	class_device_create(_cls, _parent, _devt, _device, _fmt)
 
 #define device_destroy(_cls, _device) \
 	class_device_destroy(_cls, _device)
 
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 26) */
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27)
+
+#define device_create(_cls, _parent, _devt, _device, _fmt) \
+	device_create_drvdata(_cls, _parent, _devt, _device, _fmt)
+
+#endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 27) */
diff --git a/batman-adv-kernelland/batman-core/device.c b/batman-adv-kernelland/batman-core/device.c
index c401634..028cf7d 100644
--- a/batman-adv-kernelland/batman-core/device.c
+++ b/batman-adv-kernelland/batman-core/device.c
@@ -83,7 +83,7 @@ void bat_device_setup(void)
 		debug_log(LOG_TYPE_WARN, "Could not register class 'batman-adv' \n");
 		return;
 	} else {
-		device_create_drvdata(batman_class, NULL, MKDEV(tmp_major, 0), NULL, "batman-adv");
+		device_create(batman_class, NULL, MKDEV(tmp_major, 0), NULL, "batman-adv");
 	}
 #endif
 
diff --git a/batman/linux/modules/compat26.h b/batman/linux/modules/compat26.h
index f1fdc67..692d271 100644
--- a/batman/linux/modules/compat26.h
+++ b/batman/linux/modules/compat26.h
@@ -34,6 +34,7 @@ static inline struct iphdr *ip_hdr(const struct sk_buff *skb)
 
 #endif /* KERNEL_VERSION(2, 6, 22) */
 
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 19)
 
 static inline int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
@@ -43,12 +44,21 @@ static inline int kernel_bind(struct socket *sock, struct sockaddr *addr, int ad
 
 #endif /* KERNEL_VERSION(2, 6, 19) */
 
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,26)
 
-#define device_create_drvdata \
+#define device_create \
 	class_device_create
 
 #define device_destroy \
 	class_device_destroy
 
 #endif /* KERNEL_VERSION(2,6,26) */
+
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,27)
+
+#define device_create \
+	device_create_drvdata
+
+#endif /* KERNEL_VERSION(2,6,27) */
diff --git a/batman/linux/modules/gateway.c b/batman/linux/modules/gateway.c
index fcf4dd2..b1b346c 100644
--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -91,7 +91,7 @@ int init_module()
 	if ( IS_ERR( batman_class ) )
 		DBG( "could not register class 'batgat'" );
 	else
-		device_create_drvdata(batman_class, NULL, MKDEV(Major, 0), NULL, "batgat");
+		device_create(batman_class, NULL, MKDEV(Major, 0), NULL, "batgat");
 
 
 	DBG( "batgat loaded %s", strlen(REVISION_VERSION) > 3 ? REVISION_VERSION : "" );
-- 
1.6.0.2


