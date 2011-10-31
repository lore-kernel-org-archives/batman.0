Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 31 Oct 2011 01:00:34 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111031000034.GA10726@pandem0nium>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-3-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201110310020.25024.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <201110310020.25024.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 02/11] batman-adv: add basic bridge loop
 avoidance code
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2011 at 12:20:24AM +0100, Marek Lindner wrote:
>=20
> Hi,
>=20
> >  * always become a backbone gw for a VLAN when there is traffic,
> >    even if there are no claims, to let at least let other backbone gw
> >    nodes that we are able to receive on that VLAN and avoid broadcast
> >    loops.
>=20
> could you give some more details on this change ? Why is it not necessary=
=20
> without VLANs ?

Actually it's also useful for cases without VLANs, e.g. if there has not
been any traffic yet. However if there is traffic it soon happens in both
directions and therefore claims are added and situation resolves automatica=
lly.

I had the situation that on some VLANs there were no traffic at all for som=
e time
and when it suddenly started, the bla system did some weird things.

Cheers
	Simon

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk6t5SIACgkQrzg/fFk7axZDUgCg2d63fZJjc/KjOujosQZlCzVs
D3QAoKBngSpO5oOonjaeVSlrMdRVcw+K
=LHiR
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
