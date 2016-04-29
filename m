Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:15:05 +0200
Message-ID: <5260794.F0xJx6Cp5q@sven-edge>
In-Reply-To: <36550935.HMH55OGFCA@sven-edge>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <1461875848-11720-4-git-send-email-andrew@lunn.ch>
 <36550935.HMH55OGFCA@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5944872.ei9VePAo6e";
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

--nextPart5944872.ei9VePAo6e
Content-Type: multipart/mixed; boundary="nextPart2979459.aPmVvST0Ih"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart2979459.aPmVvST0Ih
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:55:32 Sven Eckelmann wrote:
[...]
> But there is now still the problem that info->snd_portid was previously
> called info->snd_pid. Also the genl_register_family_with_ops compat has to
> be added.

I don't have a better idea for the snd_portid right now than the attached
patch.

The seems to be already solved by backports.git but I will not try to 
understand their hacks tonight.

https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/tree/backport/backport-include/net/genetlink.h?id=a91a3e6e3a6ed6cdbbe942bafe05ae5fcdf41ce9

Kind regards,
	Sven

=2D-nextPart2979459.aPmVvST0Ih
Content-Disposition: attachment; filename="0001-add-snd_portid-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-snd_portid-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:10:20 +0200
Subject: [PATCH] add snd_portid hack
=2D--
 compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat.h b/compat.h
index 0644241..fc78948 100644
=2D-- a/compat.h
+++ b/compat.h
@@ -62,6 +62,12 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#define snd_portid snd_pid
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define batadv_interface_set_mac_addr(x, y) \

=2D-nextPart2979459.aPmVvST0Ih--
This is a multi-part message in MIME format.

--nextPart2979459.aPmVvST0Ih
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 21:55:32 Sven Eckelmann wrote:
[...]
> But there is now still the problem that info->snd_portid was previously
> called info->snd_pid. Also the genl_register_family_with_ops compat has to
> be added.

I don't have a better idea for the snd_portid right now than the attached
patch.

The seems to be already solved by backports.git but I will not try to 
understand their hacks tonight.

https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/tree/backport/backport-include/net/genetlink.h?id=a91a3e6e3a6ed6cdbbe942bafe05ae5fcdf41ce9

Kind regards,
	Sven

--nextPart2979459.aPmVvST0Ih
Content-Disposition: attachment; filename="0001-add-snd_portid-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-add-snd_portid-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 22:10:20 +0200
Subject: [PATCH] add snd_portid hack
---
 compat.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/compat.h b/compat.h
index 0644241..fc78948 100644
--- a/compat.h
+++ b/compat.h
@@ -62,6 +62,12 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 3, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(3, 7, 0)
+
+#define snd_portid snd_pid
+
+#endif /* < KERNEL_VERSION(3, 7, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3, 9, 0)
 
 #define batadv_interface_set_mac_addr(x, y) \

--nextPart2979459.aPmVvST0Ih--

--nextPart5944872.ei9VePAo6e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI8DJAAoJEF2HCgfBJntGmQAP/AjWuUTvbhU8rfyb4seRLCHp
P5FU/0DT8c36u39ub0hFDELgUqJEl7ejUJsYFFnjO9QCeNn/GJ3SO51emf0l0SQX
qWp7Rgz3/HCoOyAl+ezPqkBTCJiCFmKattWtw4Dt4r2mQ9mI0MvI9IN2AXWcOcOf
/EE1zUOoBomDn0gfpfMPWt77sHy/0VR44E0ONnRZvlTvMsQGB2WeMaM6KNXAv0DK
Sq51HU9ChW+vl5FaCAzwS/ndVqFAi5DyHiaP8/pFZMmTtPlQ3ACq2Zw6BkPREosr
MveGtQHpEeel5E7FhI0z5+ofKTIuScNtwJMtomosuv+6OMEcrQw+vnhKUSmMT4w9
xNu06nqUNGPU7odW97jWG2Blr6NJ3fNwG514TQ37uRzA2z/JFGYgeKNxRv/gT8Vx
TSPfEzY7RJLFhe4i8U2/jT+xj1nl/21ixRzs/ERnVmoId/MmCy4dyYfS4EzVtsFd
5VpXwfmJ7tuL6FR6MYR4FW0Yi0JcHtBzADxLLzvpZQhLBpLTJ3E1kkiwT0iHtNA8
AF+QyzZUHxIwX9jPuqIiqMGIUiNf3b7U1B0GjHZ5V6U0V5DIZr82ITO5RlBKCnbJ
l1ipWnEkSOf4EZ3Uv+be4lLbOXPpZX/Jsee6XIC3OKlXDEvwIbCGfWjeTggvAPg4
knk6CvtSZ94QHC36X8nf
=TRKM
-----END PGP SIGNATURE-----

--nextPart5944872.ei9VePAo6e--

