Return-Path: <ordex@autistici.org>
Date: Tue, 20 Nov 2012 10:24:21 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121120092421.GC3129@ritirata.org>
References: <CAG_HyLz9B9r=u5jSw8xy+4rfG9anB6vqK+ggMGSmRossMCx4CQ@mail.gmail.com>
 <75191138.5RcUHhBkvt@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <75191138.5RcUHhBkvt@bentobox>
Subject: Re: [B.A.T.M.A.N.] batman over 802.15.4 .
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
Cc: Randy Graham <surfbytes@gmail.com>


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 20, 2012 at 09:27:39AM +0100, Sven Eckelmann wrote:
> On Monday 19 November 2012 20:25:34 Randy Graham wrote:
> [...]
> > 1. Will batman-adv work over 802.15.4 ?
> [...]
> > 2. Can batman-adv work with either of these interfaces ?
> >=20
> > I tried configuring these interfaces using 'batctl' but it complains
> > that they are an unsupported type.
> > 'iwconfig' reports these interfaces as having 'no wireless extensions'
> > which I suspect is the issue.
>=20
> No, batman-adv works on 802.3 compatible interfaces (aka ARPHRD_ETHER) wh=
ich=20
> provide special mac behaviour. This has nothing to do with the wireless=
=20
> extensions (which are deprecated anyway).
>=20
> > Please let me know if running b.a.t.m.a.n. over 802.15.4 is feasible.
>=20
> 802.15.4 has the type ARPHRD_IEEE802154 for its fake hard interfaces. So =
you=20
> need an "ethernet emulation" layer on top of it to use it with batman-adv=
=2E I=20
> don't know whether the mac layer works well enough in theory to be used w=
ith=20
> batman-adv.


And other than these technical details, I would say that batman-adv is not a
very good protocol for 802.15.4/low-power wireless. It might need heavy
restructuring if you really want to use it in a deployment.

However, I'm pretty familiar with 802.15.4, therefore if you really want to=
 go
ahead, we can even discuss further what batman-adv would need and what would
not.

Regards,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlCrTEUACgkQpGgxIkP9cwdXOgCfXknU0sTq9QxOJE3Xs2sOj6Vz
lokAoJdWw573wxQkO/1dAxnDxUK3kPJU
=tcPW
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--
