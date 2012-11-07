Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 7 Nov 2012 17:21:39 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20121107162139.GA3046@pandem0nium>
References: <CAJZtC_=Hjdiu=ZR3EiFuUaPCFu_BoDv9X=frQLqGg9hrSx7kQw@mail.gmail.com>
 <1940735.62JGhZVJKt@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <1940735.62JGhZVJKt@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] Broadcasting of GPS-coordinates?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rene, Sven,

On Sun, Nov 04, 2012 at 04:39:04PM +0100, Sven Eckelmann wrote:
> On Sunday 04 November 2012 16:32:00 Rene Bartsch wrote:
> > Does B.A.T.M.A.N support some kind of broadcasting node positions?
> >=20
> > The idea is to broadcast TX-Power/RX-Gain and the position of a node
> > determined by a GPS-device to create maps with network coverage.
>=20
> No, batman-adv and batmand don't support this kind of semantic data excha=
nge.=20
> But the new daemon alfred is (will be?) flexibible enough to do these kin=
d of=20
> things together with batman-adv. Maybe you can ask Simon and help him to=
=20
> create alfred.

Yep, we have received quite a few requests to transport arbitrary informati=
on
(node gps position, host name, neighbor information, client station list,=
=20
the weather forecast, etc ...). Actually we don't want that in batman-adv
to not bloat the kernel code, so we are currently in the process
to implement a userspace daemon to allow broadcasting this kind of data - in
a clever way, that is collect information on one (or a few) designated serv=
ers
and request from then.

This software is called A.L.F.R.E.D (Almighty Lightweight Fact Remote Excha=
nge Daemon),
and it's still in the middle of development[1] and will not be usable for p=
roductive
use right now. As soon as it is finished, we will move the vis server to it=
, and it
will be possible to use for custom purposes (like your tx-power/rx-gain/...=
 info).

I'd like to ask for a little bit more patience, we will announce a release =
as soon
as we consider it usable. :)

Thanks,
	Simon

[1] http://git.open-mesh.org/alfred.git

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlCaipMACgkQrzg/fFk7axbVDgCgz+e4N0tcXKqi+rTICsC5fkxq
YkYAoLLbizZ90teZ3DbyFaTjxhJYSkkW
=d2ly
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
