Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 21 Mar 2015 23:36:10 +0100
Message-ID: <13855982.zheniJVJDB@sven-edge>
In-Reply-To: <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-26-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2266876.0Ur6cW903I";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 25/26] batman-adv: packet.h,
	add some missing includes
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
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart2266876.0Ur6cW903I
Content-Type: multipart/mixed; boundary="nextPart1503914.9bye3UvnRG"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1503914.9bye3UvnRG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> --- a/packet.h
> +++ b/packet.h
> @@ -18,6 +18,11 @@
>  #ifndef _NET_BATMAN_ADV_PACKET_H_
>  #define _NET_BATMAN_ADV_PACKET_H_
> 
> +#ifdef __KERNEL__
> +#include <linux/bitops.h>
> +#include <uapi/linux/if_ether.h>
> +#endif /* __KERNEL__ */
> +
>  /**
>   * enum batadv_packettype - types for batman-adv encapsulated packets
>   * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV

Ok, so you are including linux/bitops.h for BIT(...) and uapi/linux/if_ether.h 
for ETH_ALEN? You are missing:

 * linux/types.h for uint8_t, __be16 and so on
 * define for the bitfield byteorder comes from asm/byteorder.h

Most of these files are part of linux-libc-dev. The rest requires some kind of 
hack. A way to still work in the batctl build would be to include dummy files. 
An example patch is attached. This builds at least on my Debian system and my 
OpenWrt build environment.

Kind regards,
	Sven
=2D-nextPart1503914.9bye3UvnRG
Content-Disposition: attachment; filename="batctl-packet-h-includes.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="batctl-packet-h-includes.patch"

diff --git a/Makefile b/Makefile
index 0eb71a1..ffbbf72 100755
=2D-- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ MANPAGE = man/batctl.8
 
 # batctl flags and options
 CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
=2DCPPFLAGS += -D_GNU_SOURCE
+CPPFLAGS += -D_GNU_SOURCE -Ikernelinc
 LDLIBS += -lm
 
 # disable verbose output
diff --git a/kernelinc/linux/bitops.h b/kernelinc/linux/bitops.h
new file mode 100644
index 0000000..d41db10
=2D-- /dev/null
+++ b/kernelinc/linux/bitops.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _BATCTL_KERNELINC_LINUX_BITOPS_H
+#define _BATCTL_KERNELINC_LINUX_BITOPS_H
+
+#define BIT(nr) (1UL << (nr))
+
+#endif
diff --git a/main.h b/main.h
index 461f3e3..248467c 100644
=2D-- a/main.h
+++ b/main.h
@@ -36,17 +36,6 @@
 #define DEBUG_TABLE_PATH_MAX_LEN 20
 #define SETTINGS_PATH_MAX_LEN 25
 
=2D#if BYTE_ORDER == BIG_ENDIAN
=2D#define __BIG_ENDIAN_BITFIELD
=2D#elif BYTE_ORDER == LITTLE_ENDIAN
=2D#define __LITTLE_ENDIAN_BITFIELD
=2D#else
=2D#error "unknown endianess"
=2D#endif
=2D
=2D#define __packed __attribute((packed))   /* linux kernel compat */
=2D#define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
=2D
 extern char module_ver_path[];
 
 #ifndef VLAN_VID_MASK
diff --git a/packet.h b/packet.h
index b81fbbf..27b4003 100644
=2D-- a/packet.h
+++ b/packet.h
@@ -18,6 +18,11 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
+#include <asm/byteorder.h>
+#include <linux/bitops.h>
+#include <linux/if_ether.h>
+#include <linux/types.h>
+
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
diff --git a/sys.c b/sys.c
index 676bef1..6c0cab4 100644
=2D-- a/sys.c
+++ b/sys.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <errno.h>
 #include <dirent.h>
+#include <linux/bitops.h>
 
 #include "main.h"
 #include "sys.h"

=2D-nextPart1503914.9bye3UvnRG--
This is a multi-part message in MIME format.

--nextPart1503914.9bye3UvnRG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

> --- a/packet.h
> +++ b/packet.h
> @@ -18,6 +18,11 @@
>  #ifndef _NET_BATMAN_ADV_PACKET_H_
>  #define _NET_BATMAN_ADV_PACKET_H_
> 
> +#ifdef __KERNEL__
> +#include <linux/bitops.h>
> +#include <uapi/linux/if_ether.h>
> +#endif /* __KERNEL__ */
> +
>  /**
>   * enum batadv_packettype - types for batman-adv encapsulated packets
>   * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV

Ok, so you are including linux/bitops.h for BIT(...) and uapi/linux/if_ether.h 
for ETH_ALEN? You are missing:

 * linux/types.h for uint8_t, __be16 and so on
 * define for the bitfield byteorder comes from asm/byteorder.h

Most of these files are part of linux-libc-dev. The rest requires some kind of 
hack. A way to still work in the batctl build would be to include dummy files. 
An example patch is attached. This builds at least on my Debian system and my 
OpenWrt build environment.

Kind regards,
	Sven
--nextPart1503914.9bye3UvnRG
Content-Disposition: attachment; filename="batctl-packet-h-includes.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="batctl-packet-h-includes.patch"

diff --git a/Makefile b/Makefile
index 0eb71a1..ffbbf72 100755
--- a/Makefile
+++ b/Makefile
@@ -30,7 +30,7 @@ MANPAGE = man/batctl.8
 
 # batctl flags and options
 CFLAGS += -Wall -W -std=gnu99 -fno-strict-aliasing -MD -MP
-CPPFLAGS += -D_GNU_SOURCE
+CPPFLAGS += -D_GNU_SOURCE -Ikernelinc
 LDLIBS += -lm
 
 # disable verbose output
diff --git a/kernelinc/linux/bitops.h b/kernelinc/linux/bitops.h
new file mode 100644
index 0000000..d41db10
--- /dev/null
+++ b/kernelinc/linux/bitops.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2009-2014 B.A.T.M.A.N. contributors:
+ *
+ * Marek Lindner <mareklindner@neomailbox.ch>
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA
+ *
+ */
+
+#ifndef _BATCTL_KERNELINC_LINUX_BITOPS_H
+#define _BATCTL_KERNELINC_LINUX_BITOPS_H
+
+#define BIT(nr) (1UL << (nr))
+
+#endif
diff --git a/main.h b/main.h
index 461f3e3..248467c 100644
--- a/main.h
+++ b/main.h
@@ -36,17 +36,6 @@
 #define DEBUG_TABLE_PATH_MAX_LEN 20
 #define SETTINGS_PATH_MAX_LEN 25
 
-#if BYTE_ORDER == BIG_ENDIAN
-#define __BIG_ENDIAN_BITFIELD
-#elif BYTE_ORDER == LITTLE_ENDIAN
-#define __LITTLE_ENDIAN_BITFIELD
-#else
-#error "unknown endianess"
-#endif
-
-#define __packed __attribute((packed))   /* linux kernel compat */
-#define BIT(nr)                 (1UL << (nr)) /* linux kernel compat */
-
 extern char module_ver_path[];
 
 #ifndef VLAN_VID_MASK
diff --git a/packet.h b/packet.h
index b81fbbf..27b4003 100644
--- a/packet.h
+++ b/packet.h
@@ -18,6 +18,11 @@
 #ifndef _NET_BATMAN_ADV_PACKET_H_
 #define _NET_BATMAN_ADV_PACKET_H_
 
+#include <asm/byteorder.h>
+#include <linux/bitops.h>
+#include <linux/if_ether.h>
+#include <linux/types.h>
+
 /**
  * enum batadv_packettype - types for batman-adv encapsulated packets
  * @BATADV_IV_OGM: originator messages for B.A.T.M.A.N. IV
diff --git a/sys.c b/sys.c
index 676bef1..6c0cab4 100644
--- a/sys.c
+++ b/sys.c
@@ -26,6 +26,7 @@
 #include <string.h>
 #include <errno.h>
 #include <dirent.h>
+#include <linux/bitops.h>
 
 #include "main.h"
 #include "sys.h"

--nextPart1503914.9bye3UvnRG--

--nextPart2266876.0Ur6cW903I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVDfJdAAoJEF2HCgfBJntGm/AQAJWTbDnSXX+BYNf3cna2HEX5
zoMEmphW7c8Xd+DZEgA6eZfrc7Oah8RGaSkT7Y8sD/5Ca+DgeCZqfN+9sBahHOpF
IGyPK3ZmWYhC38bjJnfw5O6/HA6oHuQ+Szou8qTV7YLNALnrHu6PZmyrOVae12H/
bfw48I8/vTfKOZrV+V2WJdml7pWu+dSE1H7mfoVw98dLCN4YOWIyuRCw9quUOE72
O3Xs3KDE+NEJwcEjWZzClEfrYKxZK0WVGTkEDMFc9yJ1/EYbwdy3Bx4GTmAAGqD/
SuUo1zZWs5eUUoAW1k+7QHa2elKOGWUQE7/ypyTygja3Njq3Bl4l9KDRnzALKkRO
unGcZm5fDoYlEWhBWYeaAUN9rxbUuZ/+d+M5W087OR5sH/wTbc+DO5fcV/do9yk8
KU/1l4+mZpBxNFZnVYabZwiNmJc9ZEplNMOxvKHQ49W4tNvGO+gneHR2RFdfryxW
28x5aZqaAOmpYii+bFapgK8Kc/JgLMpwhB1hKBvSuPdVlkQlImDIrk2I897MYany
byFmuO5DpfhFwBiXYi0vBMF2QMO/YaJZeZZZpAiFKqOXfQp7tHodqG3SUhEmOLMZ
QfXA+nb7UJOoAO1B3JeARl/p97KMGqz5sbDVNjx8vi2tKD4bddT/kFZUm+XiR7AD
mPhNc3iG/QOSVCkcKzTT
=cbKJ
-----END PGP SIGNATURE-----

--nextPart2266876.0Ur6cW903I--

