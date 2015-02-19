Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 12:15:45 +0800
Message-ID: <1549090.s6anOn0kWk@voltaire>
In-Reply-To: <OF9D4BC429.65445525-ONC1257DF0.0057EC95-C1257DF0.0058D385@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <23381002.yeogTpj88W@voltaire>
 <OF9D4BC429.65445525-ONC1257DF0.0057EC95-C1257DF0.0058D385@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3383582.Na2leCD4y6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Antwort: Re: Antwort: Re:
	Question	concerning	batman-adv bug	#173 "Mesh	packets on bat0"
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


--nextPart3383582.Na2leCD4y6
Content-Type: multipart/mixed; boundary="nextPart2075742.AEyD6QK7me"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2075742.AEyD6QK7me
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 17:10:12 Andreas Pape wrote:
> The essential call is in patch 2 as assumed. As soon as I add the
> netdev_master_upper_dev_link call again to the compilable code, the
> problem starts to occur (mesh doesn't work as soon as bat0 is added to the
> bridge, ogm packets can be seen at bat0). It seems that this call behaves
> in older kernels different compared to newer ones.
> 
> I haven't tried to add all the other excluded parts again except for the
> netdev_master_upper_dev_link call. If you are interested I can test this
> tomorrow, too.

Can you try the attached patch without applying any of the previous patches ?
This patch is meant to fix the compat issue without harming any functionality 
and could be included in the next release.

Cheers,
Marek

=2D-nextPart2075742.AEyD6QK7me
Content-Disposition: attachment; filename="0001-batman-adv-make-netdev_set_master-generic-for-kernel.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-make-netdev_set_master-generic-for-kernel.patch"

From=20c01b68bc11a857770c2799f0b033852e05559431 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 12:03:39 +0800
Subject: [PATCH] batman-adv: make netdev_set_master() generic for kernels
 older than 2.6.39

batman-adv calls netdev_master_upper_dev_link() which is replaced with with
netdev_set_master() for kernels older than 3.9 via compat.h.
Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
setup bonding devices. Calling this function from batman-adv leads to
unexpected behavior when current batman-adv versions are used on these
older kernels.

To fix the situation compat.h now ships its own implementation of
netdev_set_master() for kernels older than 2.6.39.

Reported-by: Andreas Pape <APape@phoenixcontact.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 compat.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/compat.h b/compat.h
index 27d8a21..f1da3da 100644
=2D-- a/compat.h
+++ b/compat.h
@@ -191,6 +191,30 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
+	struct net_device *old = slave->master;
+
+	ASSERT_RTNL();
+
+	if (master) {
+		if (old)
+			return -EBUSY;
+		dev_hold(master);
+	}
+
+	slave->master = master;
+
+	if (old) {
+		synchronize_net();
+		dev_put(old);
+	}
+	return 0;
+}
+
+#define netdev_set_master batadv_netdev_set_master
+
 /* Hack for removing ndo_add/del_slave at the end of net_device_ops.
  * This is somewhat ugly because it requires that ndo_validate_addr
  * is at the end of this struct in soft-interface.c.
=2D- 
2.1.4


=2D-nextPart2075742.AEyD6QK7me--
This is a multi-part message in MIME format.

--nextPart2075742.AEyD6QK7me
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, February 18, 2015 17:10:12 Andreas Pape wrote:
> The essential call is in patch 2 as assumed. As soon as I add the
> netdev_master_upper_dev_link call again to the compilable code, the
> problem starts to occur (mesh doesn't work as soon as bat0 is added to the
> bridge, ogm packets can be seen at bat0). It seems that this call behaves
> in older kernels different compared to newer ones.
> 
> I haven't tried to add all the other excluded parts again except for the
> netdev_master_upper_dev_link call. If you are interested I can test this
> tomorrow, too.

Can you try the attached patch without applying any of the previous patches ?
This patch is meant to fix the compat issue without harming any functionality 
and could be included in the next release.

Cheers,
Marek

--nextPart2075742.AEyD6QK7me
Content-Disposition: attachment; filename="0001-batman-adv-make-netdev_set_master-generic-for-kernel.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-make-netdev_set_master-generic-for-kernel.patch"

From c01b68bc11a857770c2799f0b033852e05559431 Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 12:03:39 +0800
Subject: [PATCH] batman-adv: make netdev_set_master() generic for kernels
 older than 2.6.39

batman-adv calls netdev_master_upper_dev_link() which is replaced with with
netdev_set_master() for kernels older than 3.9 via compat.h.
Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
setup bonding devices. Calling this function from batman-adv leads to
unexpected behavior when current batman-adv versions are used on these
older kernels.

To fix the situation compat.h now ships its own implementation of
netdev_set_master() for kernels older than 2.6.39.

Reported-by: Andreas Pape <APape@phoenixcontact.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 compat.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/compat.h b/compat.h
index 27d8a21..f1da3da 100644
--- a/compat.h
+++ b/compat.h
@@ -191,6 +191,30 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
+	struct net_device *old = slave->master;
+
+	ASSERT_RTNL();
+
+	if (master) {
+		if (old)
+			return -EBUSY;
+		dev_hold(master);
+	}
+
+	slave->master = master;
+
+	if (old) {
+		synchronize_net();
+		dev_put(old);
+	}
+	return 0;
+}
+
+#define netdev_set_master batadv_netdev_set_master
+
 /* Hack for removing ndo_add/del_slave at the end of net_device_ops.
  * This is somewhat ugly because it requires that ndo_validate_addr
  * is at the end of this struct in soft-interface.c.
-- 
2.1.4


--nextPart2075742.AEyD6QK7me--

--nextPart3383582.Na2leCD4y6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5WN0AAoJEFNVTo/uthzAemwH+wZ1tXtCVANvL+r0fk2QQS68
cNusBwFDxrCAaEK2NCM8Hf7bOM9qVlLQp6eXs6/9DWFhvzYeskdg/QAwV+93tQz2
YdbuBo9mRCjQFmAQwn47ILbwdwTsgiqIDudtnyBCwQ5vxANW6AxxvB+/bxLFqyVO
qFbejHk4SWY/Jnzy3lDjBJopUg5Bifxd/J+6d0HTOT2BKsKX7ERd/aqvfsmFzsGa
eAl4WolY02GUoQj4YGwiyMCz0eJ0rTYLwK2dhbeOOqUodzQbepXnMaU4LrfpiRq8
Mcq8VPg+gwpxaY+37W+0uOuju6elxN6zcvChO4S+yhRcs/9MANbML1hrlqNoSZw=
=Zxgv
-----END PGP SIGNATURE-----

--nextPart3383582.Na2leCD4y6--

