Return-Path: <a@unstable.cc>
Date: Fri, 6 May 2016 10:34:34 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160506023434.GA16484@prodigo.lan>
References: <1462474003-25279-1-git-send-email-a@unstable.cc>
 <2675515.pbCZCtK98O@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <2675515.pbCZCtK98O@sven-edge>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, mareklindner@neomailbox.ch


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 10:17:18PM +0200, Sven Eckelmann wrote:
> On Friday 06 May 2016 02:46:37 Antonio Quartulli wrote:
> > the compiler can optimize functions within the same C file and therefore
> > there is no need to make it explicit.
> >=20
> > Remove the useless inline attribute for __batadv_store_uint_attr()
> >=20
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> >  net/batman-adv/sysfs.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> This is not about this particular patch but for the patch series.
>=20
> Please check the attached test results of the daily build tests.

Sven,


do you know how I can deal with:

=2E/net/batman-adv/types.h:1338: warning: No description found for paramete=
r 'gw'

?

There are also other objects similar to that in the bat_algo_ops (i.e. ifac=
e,
neigh, ..), but the check complains about gw only ?

>=20
> Kind regards,
> 	Sve





--=20
Antonio Quartulli

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXLAK6AAoJEJ4aZjxxc6bKwOoP/ixTp1WKASmtXPesJQeg6wJY
b+cZ5dHiKvkMWMwpOlUcm4dIp2rW/AO6w5luPEz2D8Vzki0CYKA0DKNCD3/d0ZNk
Jaf88NQJA7jEERUrvQtW1fty+SNUfBr/1nl4ws4qJCNSNGMnsqgJOeEuKYMbQlSg
YmBKwTv9x8AhzxWK5a8sW028rNU0dcl4ISyg2nsSxUXGQbX1sRfutXQK14/GsYr5
aIKgklqQ3+bqJFW+ixCzVLYfxJvSfNS2leLnsn+tWf9W8ZyRnQ5OevwmH5lnKZCW
nu5BNt2c9IcnrVOFUZhw/tbNIfOuTqWcO3cbsCTl0+BndBJZcb6IXccKdfz9n5ZD
kWd9wMry3oTPirDS609wYrAfEIZuEGTU/KbKGZfMjmCiowOrWwcRVm7lfJ7Wr/GM
eE4X5wpuCmWm/6OULcwcZ/9EBny7dA4EYcsXmG88JidjGIFCZiY28ZbisQWwRVBf
Tq2jbkr89JKayS7jUI00S+PYFUeCgoocS7v8sW1v8NB2lhNy1ZjVJ468Q+stQ7hn
hFVCU9xFqBBu8BxpSodw6iqSIox0SaUSo6n+6HgpYW8LnxQeAcHuW9xA1kHdDFWc
rV7fltiu4RG0VYMWBp48Jxcf7gyOD6PmVpqApSzONVG1lJCbdnkboK/Nb7bjJI+e
LTxqW69gu3ga2JbP1ctq
=y2Ga
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
