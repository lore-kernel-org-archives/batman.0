Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 17:40:34 +0800
Message-ID: <1485649.labZ4ZGvMV@voltaire>
In-Reply-To: <OF7D539C0F.7F2029AA-ONC1257DF1.002DB2B5-C1257DF1.002ECBFC@phoenixcontact.com>
References: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
 <1549090.s6anOn0kWk@voltaire>
 <OF7D539C0F.7F2029AA-ONC1257DF1.002DB2B5-C1257DF1.002ECBFC@phoenixcontact.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1903910.6YAAGPXsOi";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Antwort: Re: Antwort: Antwort: Re: Antwort: Re:
	Question concerning batman-adv bug #173 "Mesh packets on bat0"
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


--nextPart1903910.6YAAGPXsOi
Content-Type: multipart/mixed; boundary="nextPart15347714.kqh6NbhTuU"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart15347714.kqh6NbhTuU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 19, 2015 09:31:08 Andreas Pape wrote:
> the problem seems to be a little bit more complex. Your latest patch does 
> not solve the problem.
> 
> But I found out, that commenting out the following line in your patch 
> makes bat0 work:
> 
> slave->master = master;
> 
> But as this is the core of "enslaving" a device to a master device, this 
> breaks the complete concept behind this I guess (I'm not a skilled kernel 
> developer). From this I conclude that there might be a bug somewhere 
> deeper in the kernel version I use.  I don't want to give up too early, 
> but it looks a little bit as if this "enslaving concept using rtnl" might 
> not be usable in these older kernels. What do you think?

Please try the attached patch instead. This time we are replacing the function 
with our own function doing nothing at all. The net_dev->master variable seems 
to be reserved for interface bonding and shouldn't be touched at all on these 
ancient kernels.

Cheers,
Marek

=2D-nextPart15347714.kqh6NbhTuU
Content-Disposition: attachment; filename="0001-batman-adv-ignore-netdev_set_master-calls-on-kernels.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-ignore-netdev_set_master-calls-on-kernels.patch"

From=20b115b2a7025e00b8f0c345b7bcf1796282c9223d Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 12:03:39 +0800
Subject: [PATCH] batman-adv: ignore netdev_set_master() calls on kernels older
 than 2.6.39

batman-adv calls netdev_master_upper_dev_link() which is replaced with with
netdev_set_master() for kernels older than 3.9 via compat.h.
Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
setup bonding devices. Calling this function from batman-adv leads to
unexpected behavior when current batman-adv versions are used on these
older kernels.

To fix the situation compat.h now ships its own implementation of
netdev_set_master() which does not change the net_dev->master state
on kernels older than 2.6.39.

Reported-by: Andreas Pape <APape@phoenixcontact.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
=2D--
 compat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat.h b/compat.h
index 27d8a21..916d447 100644
=2D-- a/compat.h
+++ b/compat.h
@@ -191,6 +191,15 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+/* On older kernels net_dev->master is reserved for iface bonding */
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
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


=2D-nextPart15347714.kqh6NbhTuU--
This is a multi-part message in MIME format.

--nextPart15347714.kqh6NbhTuU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 19, 2015 09:31:08 Andreas Pape wrote:
> the problem seems to be a little bit more complex. Your latest patch does 
> not solve the problem.
> 
> But I found out, that commenting out the following line in your patch 
> makes bat0 work:
> 
> slave->master = master;
> 
> But as this is the core of "enslaving" a device to a master device, this 
> breaks the complete concept behind this I guess (I'm not a skilled kernel 
> developer). From this I conclude that there might be a bug somewhere 
> deeper in the kernel version I use.  I don't want to give up too early, 
> but it looks a little bit as if this "enslaving concept using rtnl" might 
> not be usable in these older kernels. What do you think?

Please try the attached patch instead. This time we are replacing the function 
with our own function doing nothing at all. The net_dev->master variable seems 
to be reserved for interface bonding and shouldn't be touched at all on these 
ancient kernels.

Cheers,
Marek

--nextPart15347714.kqh6NbhTuU
Content-Disposition: attachment; filename="0001-batman-adv-ignore-netdev_set_master-calls-on-kernels.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-batman-adv-ignore-netdev_set_master-calls-on-kernels.patch"

From b115b2a7025e00b8f0c345b7bcf1796282c9223d Mon Sep 17 00:00:00 2001
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 19 Feb 2015 12:03:39 +0800
Subject: [PATCH] batman-adv: ignore netdev_set_master() calls on kernels older
 than 2.6.39

batman-adv calls netdev_master_upper_dev_link() which is replaced with with
netdev_set_master() for kernels older than 3.9 via compat.h.
Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed to
setup bonding devices. Calling this function from batman-adv leads to
unexpected behavior when current batman-adv versions are used on these
older kernels.

To fix the situation compat.h now ships its own implementation of
netdev_set_master() which does not change the net_dev->master state
on kernels older than 2.6.39.

Reported-by: Andreas Pape <APape@phoenixcontact.com>
Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 compat.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat.h b/compat.h
index 27d8a21..916d447 100644
--- a/compat.h
+++ b/compat.h
@@ -191,6 +191,15 @@ static inline int batadv_param_set_copystring(const char *val,
 #define kstrtoul strict_strtoul
 #define kstrtol  strict_strtol
 
+/* On older kernels net_dev->master is reserved for iface bonding */
+static inline int batadv_netdev_set_master(struct net_device *slave,
+					   struct net_device *master)
+{
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


--nextPart15347714.kqh6NbhTuU--

--nextPart1903910.6YAAGPXsOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU5a+VAAoJEFNVTo/uthzApJ0H/RWp2aO+s+upwNxr7LUY49cI
gJa8T/ytPLz8kjuSWKH+oHM3VlVHATnE7w/Ngl722CWl2fult7Y4eGrFz9jt8bhl
n8Qa2kK67nIPyJ0X1AnPvwwbtqhHHphL5vBUmWRPifpHgPNQDvaZdAcpVf++MEzN
S3h410jaCV5zf+up1xOOlZHMW62bhuhuVtJASqSb/3Ybcuo/awA9Gr770Sh0Hn8L
K8ycfvdKpsKga6A67Om79h3PY4BL7gGQHfl6i1F00nXJQkokzfA+gtfPJjz2Yx/N
L93+M+HkHbfizEQfrOnmuXG8BbDPJP6VZ9Jcfq8ExpZoGK1mjFbBrkFq+KGqkkk=
=azXi
-----END PGP SIGNATURE-----

--nextPart1903910.6YAAGPXsOi--

