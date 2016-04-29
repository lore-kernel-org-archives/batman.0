Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:26 +0200
Message-ID: <1740302.cWm5QmN7C1@sven-edge>
In-Reply-To: <36550935.HMH55OGFCA@sven-edge>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-4-git-send-email-andrew@lunn.ch>
 <36550935.HMH55OGFCA@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2010130.o4iLUjBV9N";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] batman-adv: add generic netlink
	query API to replace debugfs files
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org, Andrew Lunn <andrew@lunn.ch>

--nextPart2010130.o4iLUjBV9N
Content-Type: multipart/mixed; boundary="nextPart3401852.MXFBx4ILtk"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart3401852.MXFBx4ILtk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:55:32 Sven Eckelmann wrote:
[...]
> But there is now still the problem that info->snd_portid was previously
> called info->snd_pid. Also the genl_register_family_with_ops compat has to
> be added.

And here is also the one for genl_register_family_with_ops.

Kind regards,
	Sven
=2D-nextPart3401852.MXFBx4ILtk
Content-Disposition: attachment; filename="0001-add-genl_register_family_with_ops-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-genl_register_family_with_ops-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:24:25 +0200
Subject: [PATCH] add genl_register_family_with_ops hack
=2D--
 compat-include/net/genetlink.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 compat-include/net/genetlink.h

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
new file mode 100644
index 0000000..bf1ba3d
=2D-- /dev/null
+++ b/compat-include/net/genetlink.h
@@ -0,0 +1,34 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+
+#include <linux/version.h>
+#include_next <net/genetlink.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
+
+#define genl_register_family_with_ops(family, ops)     \
+	genl_register_family_with_ops((family), (ops), ARRAY_SIZE(ops))
+
+#endif /* < KERNEL_VERSION(3, 13, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */

=2D-nextPart3401852.MXFBx4ILtk--
This is a multi-part message in MIME format.

--nextPart3401852.MXFBx4ILtk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:55:32 Sven Eckelmann wrote:
[...]
> But there is now still the problem that info->snd_portid was previously
> called info->snd_pid. Also the genl_register_family_with_ops compat has to
> be added.

And here is also the one for genl_register_family_with_ops.

Kind regards,
	Sven
--nextPart3401852.MXFBx4ILtk
Content-Disposition: attachment; filename="0001-add-genl_register_family_with_ops-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-genl_register_family_with_ops-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:24:25 +0200
Subject: [PATCH] add genl_register_family_with_ops hack
---
 compat-include/net/genetlink.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 compat-include/net/genetlink.h

diff --git a/compat-include/net/genetlink.h b/compat-include/net/genetlink.h
new file mode 100644
index 0000000..bf1ba3d
--- /dev/null
+++ b/compat-include/net/genetlink.h
@@ -0,0 +1,34 @@
+/* Copyright (C) 2007-2016 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner, Simon Wunderlich
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * This file contains macros for maintaining compatibility with older versions
+ * of the Linux kernel.
+ */
+
+#ifndef _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_
+
+#include <linux/version.h>
+#include_next <net/genetlink.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 13, 0)
+
+#define genl_register_family_with_ops(family, ops)     \
+	genl_register_family_with_ops((family), (ops), ARRAY_SIZE(ops))
+
+#endif /* < KERNEL_VERSION(3, 13, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_NET_GENETLINK_H_ */

--nextPart3401852.MXFBx4ILtk--

--nextPart2010130.o4iLUjBV9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI8NYAAoJEF2HCgfBJntGJRAQAMWkVg3BiL9ZP7aDKcVIAsk8
X2fcTVBeeXfK0VwD2oFaBHjAMhQVXE4gVQ7+hNzUa34J3rs/Glge8iPT0odWCS+r
ftr/yMXenkP84deDsX9cVCaFUsjO4aWM46EnEaF4keVN37nG/T8PdjfO6nSSw7Uv
GPPMeP2oGnjAa1tGlablPdrJgyOnrVVEaJQOoH9uYN1oNbYa+dIhT6Ih26ufe+7s
hbJe1bMlzpsw6Nj/8PPvP90TiEWDMBR313v6rH2dMon01xg06QRyYgqGhnsYt4OO
/QxDx52Ftvud1KFPe05J6ideHQh8WXNPNKgTQjjmw7OIG507tLt+xpjRLvZ6gPOx
kn8cZvfXcVgGb2CRN8SV9rplf473yb9kMnKxgLQnhVrIaJn8FDokZTbEaaM4WjYO
HX/NNKyk7Z9z175+t6It67Bsr587a90QJaFQ9zbqpMDKUWUUjTvgOB1W6M6r3ZxN
mSmeaVj3FbMOFm+1yejrh+noXuO+edM93J5KPA+tJrOdaJ8SgRfWKzqUt1NkCjCl
VfSO6jE4k16dx94/d0GvvuujHLfOF+7zyqT9b39TaMaS58eh1HQ545+lx4Y2gTdo
6js4GoV5VdtubWtMSDqN1zLUyIRgl6KTTJhZAcgiUC0o+1MfNTYV0kRRuIVYS/Zy
z7xVMOBIgfpDOy4GR8E1
=yxem
-----END PGP SIGNATURE-----

--nextPart2010130.o4iLUjBV9N--

