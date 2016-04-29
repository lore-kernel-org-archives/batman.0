Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:36:41 +0200
Message-ID: <2180723.WTc0BYtVHT@sven-edge>
In-Reply-To: <3953178.c6GRPhn5yY@sven-edge>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-10-git-send-email-andrew@lunn.ch>
 <3953178.c6GRPhn5yY@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1567212.pUCfpkxH0s";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/10] batman-adv: add B.A.T.M.A.N. Dump
	gateways via netlink
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

--nextPart1567212.pUCfpkxH0s
Content-Type: multipart/mixed; boundary="nextPart182747217.0FVkfQt3I0"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart182747217.0FVkfQt3I0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:15:20 Sven Eckelmann wrote:
> On Thursday 28 April 2016 22:37:27 Andrew Lunn wrote:
> > Dump the list of gateways via the netlink socket.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> >  include/uapi/linux/batman_adv.h |   4 ++
> >  net/batman-adv/gateway_client.c | 126
> > 
> > ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.h |
> > 
> >  1 +
> >  net/batman-adv/netlink.c        |   7 +++
> >  4 files changed, 138 insertions(+)
> 
> You can find the missing includes in the attached patch

There were more missing in gateway_client.c. See attached patch

Kind regards,
	Sven
=2D-nextPart182747217.0FVkfQt3I0
Content-Disposition: attachment; filename="0018-missing-includes-9.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0018-missing-includes-9.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:05:29 +0200
Subject: [PATCH] missing includes 9
=2D--
 net/batman-adv/gateway_client.c | 5 +++++
 net/batman-adv/gateway_client.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 4e8525d..655849a 100644
=2D-- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/etherdevice.h>
+#include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
@@ -31,6 +32,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -39,6 +41,9 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "gateway_common.h"
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 294ff09..f1b2d39 100644
=2D-- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct batadv_tvlv_gateway_data;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

=2D-nextPart182747217.0FVkfQt3I0--
This is a multi-part message in MIME format.

--nextPart182747217.0FVkfQt3I0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:15:20 Sven Eckelmann wrote:
> On Thursday 28 April 2016 22:37:27 Andrew Lunn wrote:
> > Dump the list of gateways via the netlink socket.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > 
> >  include/uapi/linux/batman_adv.h |   4 ++
> >  net/batman-adv/gateway_client.c | 126
> > 
> > ++++++++++++++++++++++++++++++++++++++++ net/batman-adv/gateway_client.h |
> > 
> >  1 +
> >  net/batman-adv/netlink.c        |   7 +++
> >  4 files changed, 138 insertions(+)
> 
> You can find the missing includes in the attached patch

There were more missing in gateway_client.c. See attached patch

Kind regards,
	Sven
--nextPart182747217.0FVkfQt3I0
Content-Disposition: attachment; filename="0018-missing-includes-9.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0018-missing-includes-9.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:05:29 +0200
Subject: [PATCH] missing includes 9
---
 net/batman-adv/gateway_client.c | 5 +++++
 net/batman-adv/gateway_client.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 4e8525d..655849a 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -21,6 +21,7 @@
 #include <linux/atomic.h>
 #include <linux/byteorder/generic.h>
 #include <linux/etherdevice.h>
+#include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
@@ -31,6 +32,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
+#include <linux/netlink.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/seq_file.h>
@@ -39,6 +41,9 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/udp.h>
+#include <net/genetlink.h>
+#include <net/netlink.h>
+#include <net/sock.h>
 #include <uapi/linux/batman_adv.h>
 
 #include "gateway_common.h"
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 294ff09..f1b2d39 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -23,6 +23,7 @@
 #include <linux/types.h>
 
 struct batadv_tvlv_gateway_data;
+struct netlink_callback;
 struct seq_file;
 struct sk_buff;
 

--nextPart182747217.0FVkfQt3I0--

--nextPart1567212.pUCfpkxH0s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI8XZAAoJEF2HCgfBJntGkJQQALR73tq6S0M9hGaSmiciRY9a
CRLbcpFCPtoX5W3cxWpECY52tA7mwOTPVxN9eoQEHw+alq2FNROEhbd6TS1i3vVi
RzVCzfVraZhyz4Mda93Mm42bZaY99QB3bj5mo/H5HhKcooo8k1qrpaOzJRAwQET7
1bhYbvB2klo83myertYf6sHEMHCyH/6xvqNlVXf6Fj4zHvqJqanQNaqJSd3aMU8W
mL3e4ARML4sG436R+QMY3N5mF68jXihNEPYA6OIIkhVq7h2y+76hlKbHyzBzNQKP
TWpobcUp/Fk7WSMfrR8Tv0q0sx8er0+gIU8+qK9kHpvrjfPcr8hmFw+P0gy3Qnqe
qZzy4bjcT2S2r4Gj23JxrM0hyW+o08UGwIrK3+ZL2wE0UBCd8hQRfh2NzrIoEjWq
mU6y899/e4O/uCtrjNv0o/iGAVH5h4tebiyYwyEtzhiqvCDxYqYSGDvaaraolNNb
gtZAV8wyqMLhJycBCHFDmwuYBhojEhum+C94jR4IH0+PLVJm93KFzKQ3AN8jyy9o
vKTgzpNodFCI4vP7Ml6g/wR6IxRTGNt7QO655gfuBfppM1B0NR4DPck+dcSiaXtN
dhW0rhIsPbjE8ssYfsaxJHyChs64tdJxiNhdk1yw0me/w41iSmBLnX4KSksx9/xU
QEkgzBeGz8IVYEHxcwKr
=uVOJ
-----END PGP SIGNATURE-----

--nextPart1567212.pUCfpkxH0s--

