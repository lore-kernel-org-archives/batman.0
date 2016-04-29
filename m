Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:55:32 +0200
Message-ID: <36550935.HMH55OGFCA@sven-edge>
In-Reply-To: <1461875848-11720-4-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-4-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4991565.4MhR2DD3Fj";
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4991565.4MhR2DD3Fj
Content-Type: multipart/mixed; boundary="nextPart2018438.QxtFcXmdVu"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2018438.QxtFcXmdVu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:21 Andrew Lunn wrote:
[....]
> +int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	int portid = NETLINK_CB(cb->skb).portid;

This doesn't build on older kernels because the name of this field was 
changed. Attached is a patch which should work(tm).

This was already discussed here:
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-April/014880.html

But there is now still the problem that info->snd_portid was previously called 
info->snd_pid. Also the genl_register_family_with_ops compat has to be added.

Kind regards,
	Sven
=2D-nextPart2018438.QxtFcXmdVu
Content-Disposition: attachment; filename="0001-add-NETLINK_CB-portid-backport-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-NETLINK_CB-portid-backport-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:43:04 +0200
Subject: [PATCH] add NETLINK_CB portid backport hack
=2D--
 compat-include/linux/netlink.h | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 compat-include/linux/netlink.h

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
new file mode 100644
index 0000000..696f6da
=2D-- /dev/null
+++ b/compat-include/linux/netlink.h
@@ -0,0 +1,45 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+
+#include <linux/version.h>
+#include_next <linux/netlink.h>
+
+#include <net/scm.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+struct batadv_netlink_skb_parms {
+	struct ucred		creds;		/* Skb credentials	*/
+	union {
+		__u32		portid;
+		__u32		pid;
+	};
+	__u32			dst_group;
+};
+
+#undef NETLINK_CB
+#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms*)&((skb)->cb))
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_ */

=2D-nextPart2018438.QxtFcXmdVu--
This is a multi-part message in MIME format.

--nextPart2018438.QxtFcXmdVu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:21 Andrew Lunn wrote:
[....]
> +int batadv_algo_dump(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +	int portid = NETLINK_CB(cb->skb).portid;

This doesn't build on older kernels because the name of this field was 
changed. Attached is a patch which should work(tm).

This was already discussed here:
 https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-April/014880.html

But there is now still the problem that info->snd_portid was previously called 
info->snd_pid. Also the genl_register_family_with_ops compat has to be added.

Kind regards,
	Sven
--nextPart2018438.QxtFcXmdVu
Content-Disposition: attachment; filename="0001-add-NETLINK_CB-portid-backport-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-NETLINK_CB-portid-backport-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:43:04 +0200
Subject: [PATCH] add NETLINK_CB portid backport hack
---
 compat-include/linux/netlink.h | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 compat-include/linux/netlink.h

diff --git a/compat-include/linux/netlink.h b/compat-include/linux/netlink.h
new file mode 100644
index 0000000..696f6da
--- /dev/null
+++ b/compat-include/linux/netlink.h
@@ -0,0 +1,45 @@
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
+#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+#define _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_
+
+#include <linux/version.h>
+#include_next <linux/netlink.h>
+
+#include <net/scm.h>
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+struct batadv_netlink_skb_parms {
+	struct ucred		creds;		/* Skb credentials	*/
+	union {
+		__u32		portid;
+		__u32		pid;
+	};
+	__u32			dst_group;
+};
+
+#undef NETLINK_CB
+#define NETLINK_CB(skb) (*(struct batadv_netlink_skb_parms*)&((skb)->cb))
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
+#endif /* _NET_BATMAN_ADV_COMPAT_LINUX_NETLINK_H_ */

--nextPart2018438.QxtFcXmdVu--

--nextPart4991565.4MhR2DD3Fj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7w0AAoJEF2HCgfBJntGvA8P/3+f3pWhvgSnHka/SCu5FEyQ
OiWZvjbq/3DwTZtfFD3efMCEkkpbCREsgqMHuirdmklKUSX3xWtT4UfM4iKdD0L0
lx41BXZ40oo2/a2Uc0/MwdR9KA4X0VhR8DskTAAv4pwdHknIgVZm8VtqhTs7wjMJ
CbyRSCQ7QVoDvCG/VSpXAHuAyl3qp3DtVUhnHiz2v0NJu6kfQb66vR18AA7pi56u
G7ct53xVlub6leu71oBHmHYVHSallXIbaJNnGoX35YW5fzt31qM9HQMEO7C6JrFi
7WAtSWXMZ5ITixZF9NDTdTxzzCY8S8Z/4Z7bGaneqk95lXAs2XYIg6JEovHVm7AE
S0obsouGMiBP8U7KiB+dcs+Gg+XCixzS6o5A3BaxCyNfwmVF1sRwxWb/CVu1To1w
ARWDSDXJ6XMU7qiAoENqWZvhAMjut8SsbVEAp85VpAtHzeK19xyTYiXKuICwaHBg
WPobK+LiGau9/2BaAFbHY1YaLMoBF4IMIoDxyYStmM7RGshm4w1aWMH3zyffE158
HktvS9uosypx0MnCLvV58pC8EQV6uHvTHjASc/I2ZvcRxzHRVNtgeM652qz0x2n0
coRuY3bia6ZkFxifmrebfbJfnw6lkb33+EsJyGwzNH3mDmeGpgJZJBvFuxOeAjXi
cza3ulTFn1EBhvVo9z8T
=pqHB
-----END PGP SIGNATURE-----

--nextPart4991565.4MhR2DD3Fj--

