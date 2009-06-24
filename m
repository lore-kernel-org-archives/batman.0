Return-Path: <linus.luessing@web.de>
Date: Wed, 24 Jun 2009 23:06:31 +0200
From: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>
Message-ID: <20090624210631.GA4522@Linus-Debian>
References: <20090624082845.GS19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20090624082845.GS19149@ma.tech.ascom.ch>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] originator tq_avg oscilations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> What ideas do you have for improving the algorithms. Depending on the
> scale of work needed i might have some time to do some coding.
I've been sending Simon and Marek some emails lately about some
ideas for dynamic originator intervals. Basically the idea was,
to not use any external devices like GPS (weather station, news
paper articles, fortune tellers, ...) for detecting the
dynamicness of the environment and changing the OGM-interval on
those pieces of information, but that the information about the
changes of the TQ-values over time should be sufficient to detect
changing conditions.

If you (or others) might be interested, I could translate those
ideas to English and post them on our wiki-page. I would love to
get some more feedback and enhancements to them.

Cheers, Linus

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBAgAGBQJKQpVXAAoJEBKw7u43QNpfzVQQAIZhpRREgpQNGUoOxbz5raUx
Ld3yuASqOQjv0foo4YO/nAxzAQFq4eTqtueVi3Nqv9ZWHdNUVwj6/diLPZais/mA
0bDPWG2DWsWZMLZYZ4tC5lRFR/sZHxugRIqKMllYc5SQGqDcBSFeIyzTisbmfe0S
d1qEqExUR/g/bzeyk8pZu/Z+WkyZq5B9NWwX0oP8s6QHL3S4KWfRquWQfbCGnVSw
pp3Fdd9mzeI4PMn7RGPhhEKjaIEgHBSA5QkbCVrk7iKIkEDxeWvfNgqht+GM/pdY
tG5DJGdIaQm+NEv5I18ZI5wROnX6ytwZC1WxlIHZ/wBQkFQ9tbju3d2sxT0NXRUD
7xDxhvvZArO+iWKAK2gAYbWx8syb49q6oto5d/bkLdF6S6NGkRNwdkPlV0mGojaK
C1y/iJp/Vz4IpkfaaAPS7UQbHFZ1eBfEMEs1yIb4eGfNE9PXA6Tp1AbQIo1KuJMK
y2IJmBb+s6yy66FY+tZDBji+Vk1NM4j7Yf2vFhCsEaXAqLmuhmRrbx9AcMz8g/z5
H/TWA4tVJStIj7SSLCSYRRNpjkeclCvEXSPAZCWh751IOVjyWbcUGOeg8MIcxoDJ
GaLT7YGk0hLpiAjEu87fy4uKG+oYZrpYCt2cl+sj943xguu1W/rAcarXrazsh3HY
USV6W1gaKeLV22H025ae
=Ts8G
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
