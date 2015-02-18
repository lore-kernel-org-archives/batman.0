Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 21:55:49 +0800
Message-ID: <6979890.dWcEGHjvn6@voltaire>
In-Reply-To: <OF6FAED1E7.E0D6E49C-ONC1257DF0.0042D59F-C1257DF0.00448642@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <2282256.5kOumjqyC5@voltaire>
 <OF6FAED1E7.E0D6E49C-ONC1257DF0.0042D59F-C1257DF0.00448642@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2322062.o8IHmc2Gof";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Question concerning batman-adv bug
	#173 "Mesh	packets on bat0"
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2322062.o8IHmc2Gof
Content-Type: multipart/mixed; boundary="nextPart45976363.ZZJ1fLcevV"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart45976363.ZZJ1fLcevV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 13:28:27 Andreas Pape wrote:
> I adapted your patch to batman-adv-2014.4.0 without success. I got the 
> additional issue that with the patched version of batman-adv I was not 
> able to destroy the virtual wireless interface anymore used fot the adhoc 
> connection over which I try to use batman-adv (error message was: 
> unregister_netdevice: waiting for ath0 to become free).

It is very possible that the supplied patches have side effects. Right now, I 
am trying to figure out which part of the code introduced with 2013.2.0 causes 
the malfunction. I prepared some more patches which deactivate more code, most 
notably rtnl code added with 2013.2.0. Please give it a try and let me know 
how it goes.


> 
> With the unpatched 2014.4.0 I did the following test on two of my devices:
> 
> 1. created a virtual wireless interface ath0 in adhoc mode
> 2. iwconfig ath0 essid TEST
> 3. iwconfig ath0 channel 40
> 4. ifconfig ath0 up
> 5. batctl if add ath0
> 
> After this the two devices connected and I could see the repective 
> neighbor via the batctl o command on both devices. So far so good. 

At this point the mesh is working to your expectation ? Can you transport 
payload across the mesh ? If so, this is a deviation from #173 - wouldn't you 
agree ?


> But I can see via batctl td bat0 OGM packets sent with the MAC address of 
> the wlan interface of the device itself and also from the neigbour this 
> device is connected to via wlan. Is this OK?

Yes, batman-adv continues to use the mac addresses of the interfaces you 
configure.


Cheers,
Marek


=2D-nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0001-do-not-call-master-netdev_ops-ndo_init.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-do-not-call-master-netdev_ops-ndo_init.patch"

From=20b810a3fa1168abe9f8d21f0d9c2b19f5ecf81e0e Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 19:24:06 +0800
Subject: [PATCH 1/3] do not call master->netdev_ops->ndo_init

=2D--
 hard-interface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fbda6b5..010a403 100644
=2D-- a/hard-interface.c
+++ b/hard-interface.c
@@ -349,7 +349,7 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
  * is free'd and master can correctly change its internal state.
  * Return 0 on success, a negative value representing the error otherwise
  */
=2Dstatic int batadv_master_del_slave(struct batadv_hard_iface *slave,
+/*tatic int batadv_master_del_slave(struct batadv_hard_iface *slave,
 				   struct net_device *master)
 {
 	int ret;
@@ -362,7 +362,7 @@ static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 		ret = master->netdev_ops->ndo_del_slave(master, slave->net_dev);
 
 	return ret;
=2D}
+}*/
 
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name)
@@ -403,10 +403,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	/* check if the interface is enslaved in another virtual one and
 	 * in that case unlink it first
 	 */
=2D	master = netdev_master_upper_dev_get(hard_iface->net_dev);
+	/* master = netdev_master_upper_dev_get(hard_iface->net_dev);
 	ret = batadv_master_del_slave(hard_iface, master);
 	if (ret)
=2D		goto err_dev;
+		goto err_dev; */
 
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
=2D- 
2.1.4


=2D-nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0002-remove-netdev_-calls.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-remove-netdev_-calls.patch"

From=20df56faedb87a4beddbe8b478210bf71ebdfd7de5 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 21:18:05 +0800
Subject: [PATCH 2/3] remove netdev_* calls

=2D--
 hard-interface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 010a403..64ef086 100644
=2D-- a/hard-interface.c
+++ b/hard-interface.c
@@ -411,9 +411,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
=2D	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	/*ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
 	if (ret)
=2D		goto err_dev;
+		goto err_dev;*/
 
 	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 	if (ret < 0)
@@ -466,7 +466,7 @@ out:
 	return 0;
 
 err_upper:
=2D	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
+	/*netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);*/
 err_dev:
 	hard_iface->soft_iface = NULL;
 	dev_put(soft_iface);
@@ -521,7 +521,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 	}
 
=2D	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
+	/*netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);*/
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
 
=2D- 
2.1.4


=2D-nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0003-remove-ndo-workarounds.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-remove-ndo-workarounds.patch"

From=2005f48d1e40e55097ac960dc2a8a50d594cf967a8 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 21:44:02 +0800
Subject: [PATCH 3/3] remove ndo workarounds

=2D--
 compat.h         | 14 --------------
 soft-interface.c |  2 --
 2 files changed, 16 deletions(-)

diff --git a/compat.h b/compat.h
index 27d8a21..c3796a8 100644
=2D-- a/compat.h
+++ b/compat.h
@@ -191,20 +191,6 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
=2D/* Hack for removing ndo_add/del_slave at the end of net_device_ops.
=2D * This is somewhat ugly because it requires that ndo_validate_addr
=2D * is at the end of this struct in soft-interface.c.
=2D */
=2D#define ndo_validate_addr \
=2D	ndo_validate_addr = eth_validate_addr, \
=2D}; \
=2Dstatic const struct { \
=2D	void *ndo_validate_addr; \
=2D	void *ndo_add_slave; \
=2D	void *ndo_del_slave; \
=2D} __attribute__((unused)) __useless_ops1 = { \
=2D	.ndo_validate_addr
=2D
 #define ndo_del_slave          ndo_init
 #define ndo_init(x, y)         ndo_init - master->netdev_ops->ndo_init - EBUSY
 
diff --git a/soft-interface.c b/soft-interface.c
index 8748987..a73ebd0 100644
=2D-- a/soft-interface.c
+++ b/soft-interface.c
@@ -874,8 +874,6 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_set_rx_mode = batadv_interface_set_rx_mode,
 	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr,
=2D	.ndo_add_slave = batadv_softif_slave_add,
=2D	.ndo_del_slave = batadv_softif_slave_del,
 };
 
 /**
=2D- 
2.1.4


=2D-nextPart45976363.ZZJ1fLcevV--
This is a multi-part message in MIME format.

--nextPart45976363.ZZJ1fLcevV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 13:28:27 Andreas Pape wrote:
> I adapted your patch to batman-adv-2014.4.0 without success. I got the 
> additional issue that with the patched version of batman-adv I was not 
> able to destroy the virtual wireless interface anymore used fot the adhoc 
> connection over which I try to use batman-adv (error message was: 
> unregister_netdevice: waiting for ath0 to become free).

It is very possible that the supplied patches have side effects. Right now, I 
am trying to figure out which part of the code introduced with 2013.2.0 causes 
the malfunction. I prepared some more patches which deactivate more code, most 
notably rtnl code added with 2013.2.0. Please give it a try and let me know 
how it goes.


> 
> With the unpatched 2014.4.0 I did the following test on two of my devices:
> 
> 1. created a virtual wireless interface ath0 in adhoc mode
> 2. iwconfig ath0 essid TEST
> 3. iwconfig ath0 channel 40
> 4. ifconfig ath0 up
> 5. batctl if add ath0
> 
> After this the two devices connected and I could see the repective 
> neighbor via the batctl o command on both devices. So far so good. 

At this point the mesh is working to your expectation ? Can you transport 
payload across the mesh ? If so, this is a deviation from #173 - wouldn't you 
agree ?


> But I can see via batctl td bat0 OGM packets sent with the MAC address of 
> the wlan interface of the device itself and also from the neigbour this 
> device is connected to via wlan. Is this OK?

Yes, batman-adv continues to use the mac addresses of the interfaces you 
configure.


Cheers,
Marek


--nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0001-do-not-call-master-netdev_ops-ndo_init.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-do-not-call-master-netdev_ops-ndo_init.patch"

From b810a3fa1168abe9f8d21f0d9c2b19f5ecf81e0e Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 19:24:06 +0800
Subject: [PATCH 1/3] do not call master->netdev_ops->ndo_init

---
 hard-interface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index fbda6b5..010a403 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -349,7 +349,7 @@ batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
  * is free'd and master can correctly change its internal state.
  * Return 0 on success, a negative value representing the error otherwise
  */
-static int batadv_master_del_slave(struct batadv_hard_iface *slave,
+/*tatic int batadv_master_del_slave(struct batadv_hard_iface *slave,
 				   struct net_device *master)
 {
 	int ret;
@@ -362,7 +362,7 @@ static int batadv_master_del_slave(struct batadv_hard_iface *slave,
 		ret = master->netdev_ops->ndo_del_slave(master, slave->net_dev);
 
 	return ret;
-}
+}*/
 
 int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 				   const char *iface_name)
@@ -403,10 +403,10 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	/* check if the interface is enslaved in another virtual one and
 	 * in that case unlink it first
 	 */
-	master = netdev_master_upper_dev_get(hard_iface->net_dev);
+	/* master = netdev_master_upper_dev_get(hard_iface->net_dev);
 	ret = batadv_master_del_slave(hard_iface, master);
 	if (ret)
-		goto err_dev;
+		goto err_dev; */
 
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
-- 
2.1.4


--nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0002-remove-netdev_-calls.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0002-remove-netdev_-calls.patch"

From df56faedb87a4beddbe8b478210bf71ebdfd7de5 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 21:18:05 +0800
Subject: [PATCH 2/3] remove netdev_* calls

---
 hard-interface.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hard-interface.c b/hard-interface.c
index 010a403..64ef086 100644
--- a/hard-interface.c
+++ b/hard-interface.c
@@ -411,9 +411,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	hard_iface->soft_iface = soft_iface;
 	bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
+	/*ret = netdev_master_upper_dev_link(hard_iface->net_dev, soft_iface);
 	if (ret)
-		goto err_dev;
+		goto err_dev;*/
 
 	ret = bat_priv->bat_algo_ops->bat_iface_enable(hard_iface);
 	if (ret < 0)
@@ -466,7 +466,7 @@ out:
 	return 0;
 
 err_upper:
-	netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);
+	/*netdev_upper_dev_unlink(hard_iface->net_dev, soft_iface);*/
 err_dev:
 	hard_iface->soft_iface = NULL;
 	dev_put(soft_iface);
@@ -521,7 +521,7 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface,
 			batadv_softif_destroy_sysfs(hard_iface->soft_iface);
 	}
 
-	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);
+	/*netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->soft_iface);*/
 	hard_iface->soft_iface = NULL;
 	batadv_hardif_free_ref(hard_iface);
 
-- 
2.1.4


--nextPart45976363.ZZJ1fLcevV
Content-Disposition: attachment; filename="0003-remove-ndo-workarounds.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0003-remove-ndo-workarounds.patch"

From 05f48d1e40e55097ac960dc2a8a50d594cf967a8 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 21:44:02 +0800
Subject: [PATCH 3/3] remove ndo workarounds

---
 compat.h         | 14 --------------
 soft-interface.c |  2 --
 2 files changed, 16 deletions(-)

diff --git a/compat.h b/compat.h
index 27d8a21..c3796a8 100644
--- a/compat.h
+++ b/compat.h
@@ -191,20 +191,6 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
-/* Hack for removing ndo_add/del_slave at the end of net_device_ops.
- * This is somewhat ugly because it requires that ndo_validate_addr
- * is at the end of this struct in soft-interface.c.
- */
-#define ndo_validate_addr \
-	ndo_validate_addr = eth_validate_addr, \
-}; \
-static const struct { \
-	void *ndo_validate_addr; \
-	void *ndo_add_slave; \
-	void *ndo_del_slave; \
-} __attribute__((unused)) __useless_ops1 = { \
-	.ndo_validate_addr
-
 #define ndo_del_slave          ndo_init
 #define ndo_init(x, y)         ndo_init - master->netdev_ops->ndo_init - EBUSY
 
diff --git a/soft-interface.c b/soft-interface.c
index 8748987..a73ebd0 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -874,8 +874,6 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_set_rx_mode = batadv_interface_set_rx_mode,
 	.ndo_start_xmit = batadv_interface_tx,
 	.ndo_validate_addr = eth_validate_addr,
-	.ndo_add_slave = batadv_softif_slave_add,
-	.ndo_del_slave = batadv_softif_slave_del,
 };
 
 /**
-- 
2.1.4


--nextPart45976363.ZZJ1fLcevV--

--nextPart2322062.o8IHmc2Gof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5JnoAAoJEFNVTo/uthzAHuEIAKiXKj1JCIhn0P9d2xcIOOq2
/JA/4S8IyRUeYnmHte7Q53AhVWXx9Sf9GHJFiQwDSP96YdCgXWhIWHk9ttpdFXeF
BY4K1Q6fELvk6nL/NyTIkevfakr1FxoRcJ0LchbV/LIVA4B8L1xhst8EN2m9hKXx
jvpUHFQ9eSqm8zHhTsCAqMKOFFXJAfa+u0rPmf7Hywk+SkOK6EzcTrDP3a0roFSb
63Fr93VMmcF5jxZXGdE+1WULlFXTdu2/XWAE/5h4ntVyK0+9v2V5BNowtVMQ7KNI
o6u9BvdihKxTjG7n92wUFiS5CUfHalny0h4qGr2bb7TZKTEBX3fBF3L3FTKTmY0=
=tzvt
-----END PGP SIGNATURE-----

--nextPart2322062.o8IHmc2Gof--

