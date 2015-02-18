Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 19:26:43 +0800
Message-ID: <2282256.5kOumjqyC5@voltaire>
In-Reply-To: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1865265.8DpRGocF1h";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Question concerning batman-adv bug #173 "Mesh
	packets on bat0"
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


--nextPart1865265.8DpRGocF1h
Content-Type: multipart/mixed; boundary="nextPart2394197.oXrfbe7zVp"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2394197.oXrfbe7zVp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 08:35:49 Andreas Pape wrote:
> I'm interested if there is any progress concerning the bug entry #173 (
> http://www.open-mesh.org/issues/173). 
> 
> I'm currently observing something similiar on an embedded system running 
> an older kernel 2.6.32.26. Batman-adv versions up to 2013.1.0 work 
> flawlessly out of the box. All newer versions show the phenomenon 
> described in bug #173. 
> In my case I found out, that the batadv_batman_skb_recv function is never 
> called again as soon as I add bat0 to the bridge interface I use. 
> If I use the bat0 interface outside a bridge, everything works fine up to 
> the latest version I tested (which was 2014.4.0) even with the old kernel 
> version. 

Can you please try the attached patch and check whether it makes any 
difference? If the symptoms are the same, please provide step-by-step 
instructions how you create / configure your interfaces.

Thanks,
Marek

=2D-nextPart2394197.oXrfbe7zVp
Content-Disposition: attachment; filename="0001-do-not-call-master-netdev_ops-ndo_init.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-do-not-call-master-netdev_ops-ndo_init.patch"

From=2097dd927aca3747e1a054303638011f93373c96bf Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 19:24:06 +0800
Subject: [PATCH] do not call master->netdev_ops->ndo_init

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


=2D-nextPart2394197.oXrfbe7zVp--
This is a multi-part message in MIME format.

--nextPart2394197.oXrfbe7zVp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 08:35:49 Andreas Pape wrote:
> I'm interested if there is any progress concerning the bug entry #173 (
> http://www.open-mesh.org/issues/173). 
> 
> I'm currently observing something similiar on an embedded system running 
> an older kernel 2.6.32.26. Batman-adv versions up to 2013.1.0 work 
> flawlessly out of the box. All newer versions show the phenomenon 
> described in bug #173. 
> In my case I found out, that the batadv_batman_skb_recv function is never 
> called again as soon as I add bat0 to the bridge interface I use. 
> If I use the bat0 interface outside a bridge, everything works fine up to 
> the latest version I tested (which was 2014.4.0) even with the old kernel 
> version. 

Can you please try the attached patch and check whether it makes any 
difference? If the symptoms are the same, please provide step-by-step 
instructions how you create / configure your interfaces.

Thanks,
Marek

--nextPart2394197.oXrfbe7zVp
Content-Disposition: attachment; filename="0001-do-not-call-master-netdev_ops-ndo_init.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-do-not-call-master-netdev_ops-ndo_init.patch"

From 97dd927aca3747e1a054303638011f93373c96bf Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 18 Feb 2015 19:24:06 +0800
Subject: [PATCH] do not call master->netdev_ops->ndo_init

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


--nextPart2394197.oXrfbe7zVp--

--nextPart1865265.8DpRGocF1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5Hb2AAoJEFNVTo/uthzAZc4IAJbwXRTySMaEfCJnnIqeW9Pt
9WtsMdk2iJ7nqlzg19Up8+BCQ55gDKCXy4a1VvW3w41hOXgccEw8zKYXS29YV+X6
Gmq3y8VpiXcfGrAYdCOWd73mfBfvdVtTJSlyTY7ldbeaiL1o54bAA5jhzxAHaI5w
qKtrtw44JhFhW+3GR8xa5iwqTe3KdPE0qBcUD9G+XzsCCS9XgyFL4eU7gemPUG0c
SrJoQ92Znr2FhYymS96Z/1GBrdCDRXSDVylMre/XWZo8iwymxLVf6Zh8YrtBlkxX
WMwxS1C65mGiJXu1fX5nocOQTgR326I737rzCWtCVtbWCL0m0y6OoeuMJ9xbIX0=
=xejZ
-----END PGP SIGNATURE-----

--nextPart1865265.8DpRGocF1h--

