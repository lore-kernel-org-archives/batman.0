Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 May 2016 12:36:54 +0200
Message-ID: <1726573.p6gE20s2JI@sven-edge>
In-Reply-To: <20160505100435.GL11201@prodigo.lan>
References: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
 <20160505100435.GL11201@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8554300.RjgnsotxCg";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: replace
	dev->trans_start update with helper
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart8554300.RjgnsotxCg
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 05 May 2016 18:04:35 Antonio Quartulli wrote:
[...]
> > 
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 7, 0)
> > +
> > +#define netif_trans_update batadv_netif_trans_update
> > +static inline void batadv_netif_trans_update(struct net_device *dev)
> 
> Sven,
> 
> do we really need to rename the function is the original one does not exist
> in kernels < 4.7 ? Or maybe it exists but does something else ?

Not necessarily but Linus' noticed for a different function that some distros 
(or stable maintainers) backported the function which we introduced. Thus we 
used the same trick to solve the conflict.

Kind regards,
	Sven
--nextPart8554300.RjgnsotxCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXKyJGAAoJEF2HCgfBJntG3lMP/1CJlxmgzzpXMh68VaG1HuyA
ZcnD3A1v4AlL+Oalh/CLY2eO2Jw+6q3u3SEHgWHdbB5UOXNEV8op4aaCBSg/vxEd
WkrfuHKfmGYEp/MS9xsIViN+iYMcji3a2lrPs/cFWxM872L2Oy38Jd0Lr7VQ0Ar0
NeETzlcq/HI7q4Mr288jei+W82B3Za/Q4GMb16d9Xp9yRL8faCdkiOHGNnxsdL7o
6B2sxySfIZAiMxDcFecuUpUU4YjlKFHEBpMemoNHUvHK5lFLC8tpDsnDTFxLAkUN
XlyN0OlGq8zqJPHfL7S69ttKkKAZ7t1FgbeJ19T7EEFEMcnIOnL/FK8Se+Ep7a71
JZTtgdPiq5jVpubBUK6H95JYdYql80KQ3hGAumu/iDoG9dEEyIDZOcIOifZdgMXV
C7/6NO9a92O2oHOCKzumju2uIek5VcK+XYlAZWDZdCc4Y15FNQrbnRgzh+Rg/0Wf
1ZPZxXHsmtTdVNiZ5rD9vcczDvk5sCNm/VYFk0qv46uQoPqPwot9jT7Rthl3Hevl
8tMQxXCdRDyb4BZzqiXyprOIFoRK8S4lJvATzxsGHaPAghj+jbwvu/WxVLfVAyG0
TUJcYTAgKft8cAPvfNr+/4STHhBp2N1PGWBl97pPB0nDNQ0gkrbvV4CFJjml3wr8
HvmetOUK6tpPWZinrVi0
=z+qO
-----END PGP SIGNATURE-----

--nextPart8554300.RjgnsotxCg--

