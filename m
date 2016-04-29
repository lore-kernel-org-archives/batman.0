Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:51:12 +0200
Message-ID: <7460918.gGjtq2HAJI@sven-edge>
In-Reply-To: <13794357.HqoOAIfBmV@bentobox>
References: <1461875848-11720-1-git-send-email-andrew@lunn.ch>
 <20160429121427.GB4053@lunn.ch> <13794357.HqoOAIfBmV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1501387.JHULFoi7BA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 01/10] batman-adv: Handle parent
	interfaces in a different netns
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

--nextPart1501387.JHULFoi7BA
Content-Type: multipart/mixed; boundary="nextPart1676580.kur3a7VF0k"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1676580.kur3a7VF0k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 14:59:21 Sven Eckelmann wrote:
> On Friday 29 April 2016 14:14:27 Andrew Lunn wrote:
> > On Fri, Apr 29, 2016 at 07:52:42AM +0200, Sven Eckelmann wrote:
> > > On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
> > > > batman-adv tries to prevent the user from placing a batX soft
> > > > interface into another batman mesh as a hard interface. It does this
> > > > by walking up the devices list of parents and ensures they are all
> > > > none batX interfaces. iflink can point to an interface in a different
> > > > namespace, so also retrieve the parents name space when finding the
> > > > parent and use it when doing the comparison.
> > > > 
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > Acked-by: Antonio Quartulli <a@untable.cc>
> > > > ---
> > > 
> > > You are unfortunately reverting back to an older version of the patch
> > > which is harder to make compile on older kernels.
> > 
> > Hi Sven
> > 
> > Please point me at the version you would prefer.
> 
> Partially this one: https://patchwork.open-mesh.org/patch/15921/
> 
> I know that your current submission doesn't contain the compat-patches part
> (which I find rather ugly) but this version has only a single function
> handling the batadv_getlink_net and thus could be easier to create some wild
> #defines working around the compat problem on older versions. But it will
> most likely end with a warning and being a big NOP on older kernels.
> 
> It is something like (untested):
> 
>     /* WARNING dirty hack for batadv_getlink_net */
>     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
>     	#define get_link_net get_xstats_size || 1 ||
> netdev->rtnl_link_ops->get_xstats_size #endif

Attached is the patch version of the hack. It creates following warning:

/tmp/qemu-batman/batman-adv/net/batman-adv/hard-interface.c:103:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
  return netdev->rtnl_link_ops->get_link_net(netdev);
         ^

If somebody else has a good/better idea then please post it.

Kind regards,
	Sven
=2D-nextPart1676580.kur3a7VF0k
Content-Disposition: attachment; filename="0001-get_link_net-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-get_link_net-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:48:55 +0200
Subject: [PATCH] get_link_net hack
=2D--
 compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat.h b/compat.h
index 5a5f478..0644241 100644
=2D-- a/compat.h
+++ b/compat.h
@@ -140,6 +140,13 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* WARNING for batadv_getlink_net */
+#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
 
 #define IFF_NO_QUEUE	0; dev->tx_queue_len = 0

=2D-nextPart1676580.kur3a7VF0k--
This is a multi-part message in MIME format.

--nextPart1676580.kur3a7VF0k
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 29 April 2016 14:59:21 Sven Eckelmann wrote:
> On Friday 29 April 2016 14:14:27 Andrew Lunn wrote:
> > On Fri, Apr 29, 2016 at 07:52:42AM +0200, Sven Eckelmann wrote:
> > > On Thursday 28 April 2016 22:37:19 Andrew Lunn wrote:
> > > > batman-adv tries to prevent the user from placing a batX soft
> > > > interface into another batman mesh as a hard interface. It does this
> > > > by walking up the devices list of parents and ensures they are all
> > > > none batX interfaces. iflink can point to an interface in a different
> > > > namespace, so also retrieve the parents name space when finding the
> > > > parent and use it when doing the comparison.
> > > > 
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > Acked-by: Antonio Quartulli <a@untable.cc>
> > > > ---
> > > 
> > > You are unfortunately reverting back to an older version of the patch
> > > which is harder to make compile on older kernels.
> > 
> > Hi Sven
> > 
> > Please point me at the version you would prefer.
> 
> Partially this one: https://patchwork.open-mesh.org/patch/15921/
> 
> I know that your current submission doesn't contain the compat-patches part
> (which I find rather ugly) but this version has only a single function
> handling the batadv_getlink_net and thus could be easier to create some wild
> #defines working around the compat problem on older versions. But it will
> most likely end with a warning and being a big NOP on older kernels.
> 
> It is something like (untested):
> 
>     /* WARNING dirty hack for batadv_getlink_net */
>     #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
>     	#define get_link_net get_xstats_size || 1 ||
> netdev->rtnl_link_ops->get_xstats_size #endif

Attached is the patch version of the hack. It creates following warning:

/tmp/qemu-batman/batman-adv/net/batman-adv/hard-interface.c:103:9: warning: return makes pointer from integer without a cast [-Wint-conversion]
  return netdev->rtnl_link_ops->get_link_net(netdev);
         ^

If somebody else has a good/better idea then please post it.

Kind regards,
	Sven
--nextPart1676580.kur3a7VF0k
Content-Disposition: attachment; filename="0001-get_link_net-hack.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="0001-get_link_net-hack.patch"

From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 Apr 2016 21:48:55 +0200
Subject: [PATCH] get_link_net hack
---
 compat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/compat.h b/compat.h
index 5a5f478..0644241 100644
--- a/compat.h
+++ b/compat.h
@@ -140,6 +140,13 @@ static int __batadv_interface_kill_vid(struct net_device *dev, __be16 proto,\
 
 #endif /* < KERNEL_VERSION(3, 15, 0) */
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 0, 0)
+
+/* WARNING for batadv_getlink_net */
+#define get_link_net get_xstats_size || 1 || netdev->rtnl_link_ops->get_xstats_size
+
+#endif /* < KERNEL_VERSION(4, 0, 0) */
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(4, 3, 0)
 
 #define IFF_NO_QUEUE	0; dev->tx_queue_len = 0

--nextPart1676580.kur3a7VF0k--

--nextPart1501387.JHULFoi7BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXI7swAAoJEF2HCgfBJntGa/oQAK/3urskbt9F/WGog2u//oPO
fdHYXtLJwKp7yCB8VYPw3uZOvEKsvVaX+4NheysvsNEaWCi/QTxXn/tEhXcNk766
UJ6kUCdzGPS8cy3h+pZOHw1UGLOWLOv/jMBiEFgRqtSVkGmt2jve60vqPB/bVHdp
wl05SMktKveKz/irRo03vLk5ka/cvjruP+qUpsBMW0P/NF58knY8RJjBhsbE4ovg
vOVwOmL4AQGMFyYHAlwo56RMjjrQj2tBoVwR2EbVia8/Jtt2phbJPSGVI/OoObbu
ZQjuCO+H3dXLr+amgHEGzT7jcm6zHTPRBQKrrw7CsYClVUKn7p847eB0fFLOy+id
OXrhlZOw0xKZYc0WY96dkck/IVFej8B1KQctkj8M3XdizkPb8+xMi+tGzeCIZFcp
q80ls5u1MIgTJJwZ/d+3vVTOgZQ9oLCfVYpj9d7Or1aMEo+bAH7FHHW+MXiZiw/l
0jUujgRB3L4qrsj5Yt1FBifmGD761WIoEmfS+0C0uF8C2joi1pfvTDrqWJ1XKxzo
/xbSfoYJRl4wD5+TOIdsWK/Be7P2BC5ZuMnA3N5GLq0sFTyldX4jDC17uWI1d7Ul
M30zFbYMKHLwZeywiEOqos6e2D27w9cDsoer+wYkXplRwqrf/fMos03rxBXx4pkv
HGfwdFRAnhlCW6RxtRUt
=tIyo
-----END PGP SIGNATURE-----

--nextPart1501387.JHULFoi7BA--

