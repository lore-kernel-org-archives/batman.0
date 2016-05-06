Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 06 May 2016 09:23:40 +0200
Message-ID: <41788197.Cke9H3Q0EA@sven-edge>
In-Reply-To: <20160506023434.GA16484@prodigo.lan>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <2675515.pbCZCtK98O@sven-edge> <20160506023434.GA16484@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5359142.Gy7LTUb6SJ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/7] batman-adv: remove useless inline
	attribute for sysfs helper function
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch

--nextPart5359142.Gy7LTUb6SJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 06 May 2016 10:34:34 Antonio Quartulli wrote:
> On Thu, May 05, 2016 at 10:17:18PM +0200, Sven Eckelmann wrote:
> > On Friday 06 May 2016 02:46:37 Antonio Quartulli wrote:
> > > the compiler can optimize functions within the same C file and therefore
> > > there is no need to make it explicit.
> > > 
> > > Remove the useless inline attribute for __batadv_store_uint_attr()
> > > 
> > > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > > ---
> > > 
> > >  net/batman-adv/sysfs.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > This is not about this particular patch but for the patch series.
> > 
> > Please check the attached test results of the daily build tests.
> 
> Sven,
> 
> 
> do you know how I can deal with:
> 
> ./net/batman-adv/types.h:1338: warning: No description found for parameter
> 'gw'
> 
> ?
> 
> There are also other objects similar to that in the bat_algo_ops (i.e.
> iface, neigh, ..), but the check complains about gw only ?

Kerneldoc cannot parse these kind of substructures. Just run:

   scripts/kernel-doc -html net/batman-adv/types.h > test.html
   chromium test.html

It just creates random noise from your kerneldoc input. So one way to deal 
with it is to create a substruct hacks parse functionality for kerneldoc or 
avoid these kind of anonymous-type substructs and use extra correctly typed 
structs.

You can contact Jonathan Corbet and inform him that these kinds of things are 
not "correctly" parsed (and don't use dirty hacks to creat kerneldoc-sections 
like struct sockaddr_caif used for its union kerneldoc). Maybe with a small 
example.

Kind regards,
	Sven 
--nextPart5359142.Gy7LTUb6SJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXLEZ8AAoJEF2HCgfBJntGZ9UQANfqVK8tYSdXWPecgoZkWhKO
KDACXKkY9HK1VyxPCV8evwlPaPjC+nsAOXeE343Z0CfkSFt1d6icaRg7i3XK7yqc
NYa7zYCEejdLJH07ziWakWcTxJVNRk13QX+5MDoGU4H+O5oKoE/Mj8T79bCX+bmx
4IX+mn9iggXJn0Ex5qMG9zNegaxBoPSV6/MMXpGlcN+kRHlov+p0CS23IeoVFTl7
2lzgBH3knzT7tyteRRUxLnZswVtSP+7zLhs0GaWWHDyBGkXFxOYJ585Hkzy3Gc2o
QcEUDYgE4zTSPdwZ7qGy8a1wRRNu0Vt2lppWrRvpiJNz0h5JT4LXI7pR2a62dQAA
oW62YAScVpcAfzJ4fGy5rsEEJKH1sCX5i6MlOBIwAMeA6V6PYXmIDTGPpEfpL9U/
QZhOQtKX3OCTysCza2nhZvqiykTrGTs34lWuwGqL1j8DxbI2ZLtnlpL5sqe/AmgR
RCpuJsa11Sxvjn1p+4cNUcn5g/Rs04ZUpnBp7WwfzSC40rg4ZCt/qrH9RTpZ/BDP
7LzenLl9mnrI3st0xAXCuXF5XDnveKOID0cw+nggqsTAn8IW8lI+wklRp3e6sPwQ
ZI/tTKtoQkFPUxTZ2lu3Cz+Sax4a1GkT47QN9iimkS8LPyJTKYM9DUvphUjD30wV
4Xhwq1TkyokTVJXsGrhz
=l0qF
-----END PGP SIGNATURE-----

--nextPart5359142.Gy7LTUb6SJ--

