Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:15:23 +0200
Message-ID: <14059223.O2V5p1EoNq@sven-edge>
In-Reply-To: <1461875848-11720-11-git-send-email-andrew@lunn.ch>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-11-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart162441644.nXN9VMh6S6";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 10/10] batman-adv: add B.A.T.M.A.N. Dump
	BLA claims via netlink
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

--nextPart162441644.nXN9VMh6S6
Content-Type: multipart/mixed; boundary="nextPart2258048.UeUabJotxB"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2258048.UeUabJotxB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:28 Andrew Lunn wrote:
> Dump the list of bridge loop avoidance claims via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/uapi/linux/batman_adv.h        |   6 ++
>  net/batman-adv/bridge_loop_avoidance.c | 162
> +++++++++++++++++++++++++++++++++ net/batman-adv/bridge_loop_avoidance.h | 
>  9 +-
>  net/batman-adv/netlink.c               |   7 ++
>  4 files changed, 183 insertions(+), 1 deletion(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
=2D-nextPart2258048.UeUabJotxB
Content-Disposition: attachment; filename="0020-missing-includes-10.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0020-missing-includes-10.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:07:57 +0200
Subject: [PATCH] missing includes 10
=2D--
 net/batman-adv/bridge_loop_avoidance.c | 3 +++
 net/batman-adv/bridge_loop_avoidance.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index b3fab2a..2e40ada 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -35,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -45,6 +46,8 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 2d6acfd..a80b9e9 100644
=2D-- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct net_device;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

=2D-nextPart2258048.UeUabJotxB--
This is a multi-part message in MIME format.

--nextPart2258048.UeUabJotxB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 28 April 2016 22:37:28 Andrew Lunn wrote:
> Dump the list of bridge loop avoidance claims via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  include/uapi/linux/batman_adv.h        |   6 ++
>  net/batman-adv/bridge_loop_avoidance.c | 162
> +++++++++++++++++++++++++++++++++ net/batman-adv/bridge_loop_avoidance.h | 
>  9 +-
>  net/batman-adv/netlink.c               |   7 ++
>  4 files changed, 183 insertions(+), 1 deletion(-)

You can find the missing includes in the attached patch

Kind regards,
	Sven
--nextPart2258048.UeUabJotxB
Content-Disposition: attachment; filename="0020-missing-includes-10.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0020-missing-includes-10.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:07:57 +0200
Subject: [PATCH] missing includes 10
---
 net/batman-adv/bridge_loop_avoidance.c | 3 +++
 net/batman-adv/bridge_loop_avoidance.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index b3fab2a..2e40ada 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -35,6 +35,7 @@
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -45,6 +46,8 @@
 #include <linux/string.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
 #include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
diff --git a/net/batman-adv/bridge_loop_avoidance.h b/net/batman-adv/bridge_loop_avoidance.h
index 2d6acfd..a80b9e9 100644
--- a/net/batman-adv/bridge_loop_avoidance.h
+++ b/net/batman-adv/bridge_loop_avoidance.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct net_device;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

--nextPart2258048.UeUabJotxB--

--nextPart162441644.nXN9VMh6S6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7LLAAoJEF2HCgfBJntG89sP/iyAIJ191rAMuI9nt8M93WNB
FZ25lqqy6xFaF/n0+0Jgv3miRx7Z1FhLUgFJqMdpK7Ak/a5MOnEnD7y6AQKCdMtJ
fBoNLijExgeT1IQQwyMncB5koT395S41tdns1fY4OfelqN3GBpLEk/uTny/kzBmm
41MvYbDdBigM4UW5JOBnVFmUYBGvxwFdBCATZfuME7MIviVbLLFFL+i796LJyjSK
AEkpMVTXeXnA8YFUI8aWLsOuhhIYVDQrHvd8ZBIN8H/R7Qoqoz2sn3DSr+KzCJu4
jw+rETfUg47jVJK09sVBq4dGEgykfFtx2BXStQJyGlfYRUdqDzRXki0/d7Mhv4Kx
GyzpLCMUocKcDDDfmvooV+Rrrjmm+YnpYqn29pCh0ZL6i779UjP+FfgeAADqdG5r
QRbHvU6/DMSc9rV15okkVrDh3JSWT4SfqdkKhmPAiIW84fdJAD34cA2kWUaA0K8f
ctC9e9xeGhzsq0vEkK5e1xXTrUccwjqd6f/n4SNA+V66zyp63EluD5nGr0vU6xJN
jabOslcdBNW1UnyfCMqOi/AAX51ZnN1e5lRuw9+KYxf/7aQAV7BGgepPNxBSc4JD
UfbGhYmLO2zCMjQ8f2yrtsLqnkM1K7+YHE+ynylHT287sT8GwmlyBxHFVvWJbT8H
ljedWubXLsfd6viPp+tM
=/zHe
-----END PGP SIGNATURE-----

--nextPart162441644.nXN9VMh6S6--

