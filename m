Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] net: bridge: mcast: rename br_ip's u member to dst
Date: Mon, 28 Sep 2020 08:59:58 +0200
Message-ID: <1665109.RXYjxSXZkc@ripper>
In-Reply-To: <20200927191234.22423-1-linus.luessing@c0d3.blue>
References: <20200927191234.22423-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6311710.drN0L23qOB"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org, Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@nvidia.com>, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <a@unstable.cc>

 
--nextPart6311710.drN0L23qOB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

[...]
> +#ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
> +#define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
> +
> +#include <linux/version.h>
> +#include_next <linux/if_bridge.h>
> +
> +#if LINUX_VERSION_IS_LESS(5, 10, 0)
> +
> +struct batadv_br_ip {
> +	union {
> +		__be32  ip4;
> +#if IS_ENABLED(CONFIG_IPV6)
> +		struct in6_addr ip6;
> +#endif
> +	} dst;
> +	__be16          proto;
> +	__u16           vid;
> +};
> +
> +struct batadv_br_ip_list {
> +	struct list_head list;
> +	struct batadv_br_ip addr;
> +};

Better than my version but the BUILD_BUG_ON for all used fields are missing.

diff --git a/compat-include/linux/if_bridge.h b/compat-include/linux/if_bridge.h
index c4f9bc08..9a4cceca 100644
--- a/compat-include/linux/if_bridge.h
+++ b/compat-include/linux/if_bridge.h
@@ -10,6 +10,7 @@
 #ifndef _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
 #define _NET_BATMAN_ADV_COMPAT_LINUX_IF_BRIDGE_H_
 
+#include <linux/bug.h>
 #include <linux/version.h>
 #include_next <linux/if_bridge.h>
 
@@ -31,6 +32,23 @@ struct batadv_br_ip_list {
 	struct batadv_br_ip addr;
 };
 
+/* "static" dropped to force compiler to evaluate it as part of multicast.c
+ * might need to be added again and then called in some kind of dummy
+ * compat.c in case this header is included in multiple files.
+ */
+inline void __batadv_ip_list_check(void)
+{
+	BUILD_BUG_ON(sizeof(struct batadv_br_ip_list) != sizeof(struct br_ip_list));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip_list, list) != offsetof(struct br_ip_list, list));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip_list, addr) != offsetof(struct br_ip_list, addr));
+
+	BUILD_BUG_ON(sizeof(struct batadv_br_ip) != sizeof(struct br_ip));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, dst.ip4) != offsetof(struct br_ip, u.ip4));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, dst.ip6) != offsetof(struct br_ip, u.ip6));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, proto) != offsetof(struct br_ip, proto));
+	BUILD_BUG_ON(offsetof(struct batadv_br_ip, vid) != offsetof(struct br_ip, vid));
+}
+
 #define br_ip batadv_br_ip
 #define br_ip_list batadv_br_ip_list
 


--nextPart6311710.drN0L23qOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl9xie4ACgkQXYcKB8Em
e0Yv3Q//Sz4UmOJh/GkzCL59VxKAQ5zP6/5k120bJ9Sun81gTHMP16Wa8K1T8IRH
hj+6oeWGEha5OkwfDrRrqUfjmzeo6O25SiKGemRF/ueoabVQEzhsKRoDxLJaTmng
XiBR++kBgS8/Ir+IHf6P9LbK9+2lTiIFK2ZDn9vnARr+5EIQVVvkSQGMgftX5A3e
UdBhwnS2Hw3963cEZ5F1mMLSCvkDnyhFodtcvFzwxHQiaq9gERKvcAo+tEFIPpnp
UK2niCeR2zzU5irvbAmnVQJEB00Z4+wtYP/rnSSqad4eXCQf6itmhXVew4HpaUie
aTJ6nh78rzSnUco9qrVD8n0tOt7Zj3gjryKG8DRTEdDDcAtaM82YKteu1XvqzVcw
FU7sFFmSAM63rlV0heNRMS9a/LHZca+kjP3RLjSG+WKmMLD1xfwExfkrRbNbs1yY
122IdWR9KXh97YIr9hsMoKHlmFK0aGZuYap26/u5VeXRv6yGVW2jvtDST38C3RF1
RfLklgr7BB/B45IZsYxPDRtwH+dhYR23AHOXKScmSngIscAFqazw6Ol3y1qFJODy
eBDwBGvMTEmxZS00K80nyXPFUZVyaoiirTAnVFy6H74yT7XpSPvu5Kr5p2LstOdw
nn1uAQiJFQLO7OMfkC0O1C9pTI/CvWXi+wTOmg1DHJBY7YcCY2M=
=w8kn
-----END PGP SIGNATURE-----

--nextPart6311710.drN0L23qOB--


