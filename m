Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jul 2016 18:01:52 +0200
Message-ID: <2013831.j3g2g36yXy@sven-edge>
In-Reply-To: <9358912.PbkjNdNDRZ@prime>
References: <1465152428-17299-1-git-send-email-sven@narfation.org>
 <1465152428-17299-3-git-send-email-sven@narfation.org>
 <9358912.PbkjNdNDRZ@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4007139.C5LnOaH0E4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 03/10] alfred: Add netlink dependencies
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4007139.C5LnOaH0E4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 21. Juli 2016 17:58:07 CEST Simon Wunderlich wrote:
> > diff --git a/vis/batman_adv.h b/vis/batman_adv.h
> > new file mode 120000
> > index 0000000..72222e9
> > --- /dev/null
> > +++ b/vis/batman_adv.h
> > @@ -0,0 +1 @@
> > +../batman_adv.h
> > \ No newline at end of file
> > diff --git a/vis/netlink.c b/vis/netlink.c
> > new file mode 120000
> > index 0000000..06d13cc
> > --- /dev/null
> > +++ b/vis/netlink.c
> > @@ -0,0 +1 @@
> > +../netlink.c
> > \ No newline at end of file
> > diff --git a/vis/netlink.h b/vis/netlink.h
> > new file mode 120000
> > index 0000000..c7a63b5
> > --- /dev/null
> > +++ b/vis/netlink.h
> > @@ -0,0 +1 @@
> > +../netlink.h
> > \ No newline at end of file
> 
> I was wondering why you use symlinks here, while we pull in the other
> headers from their original paths (../packet.h, ../list.h).
> 
> We should probably keep the header handling consistent. What would be your
> opinion whether we should use relative paths or symlinks?

This doesn't work for netlink.c because it would break during parallel builds. 
And netlink.c requires batman_adv.h which must be in the search path for it.

Possible would be to symlink netlink.c and netlink.h and Add "-I.." to 
CPPFLAGS of batadv-vis.

Kind regards,
	Sven

--nextPart4007139.C5LnOaH0E4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXkPHwAAoJEF2HCgfBJntGoM8P/A8WSL/fBgksYUg1geeT686b
SvPDyWjPfIROm+Fp0IYRAi+X6YVS6pTCDoBfl4Jkea/3HDy5/v0IXXZmJPFeYOrF
VLv4FAz2cVL1tLxM+Z2jjZwUl57X1L9c5YQbV+Ev0o6R8FA4oAgnAfkHDNJiKLTL
sj1ra8XkRCtWbQEe2H89WaCEEYaPlIabEMY9P0valFCiZec1buwvvK5qG0rrKajq
UVDxi1M8Kt1ubaYNMtiKSGI008z1twX14cXU95Iw0qNuL7PNmoKbKkmlI5oQ2w5Y
88uY9CJM/If07JSyRoL9/uBNFFksnqSTZpxf0DY/Rc37F6UkwgsZMZnW2XEzz5hN
9TUf7Bvjn11gBnDiSV9yXQrz9V499vX9Zu5CBTg/NpubZ486ZIXxgj6ju71ztoRn
j8aidRvbthLbxeOSjWf5CydQaHpUUHwKH9yFQyUMb/pJzJGCRwBb9HELaM4GGPSJ
TqfRvrDGqoN8+ear9YCnVTGNWywH31ARS7IXSkAxqMEdJIGMahIFozfdSCg2H+Cj
+Rubok2gtQQMjgqbw+S8fTrDazzNaJrKMcDrEU11CtvMRW7Fi8UHNvQtWmGS0q+O
NVGn5X+0FLwRhgAwMsd4BhKwIIW7s300iCdW7tEvkIO+dAq1ceqKBGBjOX+MHewV
C3I6Ub+UFJeirI7AZJuB
=SVfe
-----END PGP SIGNATURE-----

--nextPart4007139.C5LnOaH0E4--

