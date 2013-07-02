Return-Path: <ordex@autistici.org>
Date: Tue, 2 Jul 2013 09:25:31 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130702072531.GA2325@ritirata.org>
References: <CAHQ_bghvU1=AR=+Kk4XvAZoWTjyVT6u74MnkgM_Y+4hcUR9MxA@mail.gmail.com>
 <CAHQ_bgj6EoSPVW7iiYcf3KMCUX+shpPSNThxjTY_Qa+vtNw0xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <CAHQ_bgj6EoSPVW7iiYcf3KMCUX+shpPSNThxjTY_Qa+vtNw0xQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] ttcrc value
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 11:28:48AM +0530, ajeet singh wrote:
> Hello all,
> We are getting the same value of ttcrc always even after restarting the n=
odes.
>=20
> Please check the bellow TCPDUMP log,
>=20
> Log 1
> 09:05:17.118462 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
> f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
> 50, v 14, flags [...F.], length 26
> 09:05:17.118764 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
> f4:7b:5e:88:7d:a0, seq 2246235905, tq 255, ttvn 1, ttcrc 15939, ttl
> 50, v 14, flags [...F.], length 26
>=20
> Log 2 ( After restart)
>  00:12:29.480397 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
> aa:aa:03:00:00:00, seq 2864163091, tq 255, ttvn 1, ttcrc 15939, ttl
> 2, v 14, flags [.....], length 26
>  00:12:29.520254 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
> aa:aa:03:00:00:00, seq 31648486, tq 255, ttvn 1, ttcrc 15939, ttl 50,
> v 14, flags [...F.], length 26
>  00:12:32.488390 BAT f6:7b:5e:88:7d:a0: OGM IV via neigh
> aa:aa:03:00:00:00, seq 2864163092, tq 255, ttvn 1, ttcrc 15939, ttl
> 2, v 14, flags [.....], length 26
>  00:12:32.536432 BAT f4:7b:5e:88:7d:a0: OGM IV via neigh
> aa:aa:03:00:00:00, seq 31648487, tq 255, ttvn 1, ttcrc 15939, ttl 50,
> v 14, flags [...F.], length 26
>=20
>=20
>  Is it normal operation?

The TTCRC is computed based _only_ on the address addresses listed in the l=
ocal
table. There is no randomness involved, therefore, if the addresses in the =
table
are always the same, then also the TTCRC will stay the same.

Is this the case?

cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR0oBrAAoJEADl0hg6qKeOkX8P/j2esBFWpH+U0SpLoqFmdPcB
Mg3+3iEamNnQlPi/dqoCu0KkiT+aAkATMTQLYCvAPlHKat56xPjYmu1eB5MTCRhZ
qSwtb0xM27b4BxYS9oVaHlPvGOHxEGh/rAECJ/4dMx1Fpa5u2tZEgLICPnVqB9ic
TSGto5W3PeXEvGcD6I6CXXIcVFDMEM9FVOe3rTIlnn0S9vgbc7nal5CrneaVO81X
cusRpoD3iUfqzD4LbtElMBeMFr/HDIy0CrzfSzl1OAMIchn0KjgT+bsM0UUz5gYH
Xn3WJ1RtVw4z5nIEN4X2RJ8GaBTBBaIDws0WCCO4tQFSG6RDIsuM6znTO9yfcTHc
GPK3sSe2dlHCFo3tAokdoNl0PAtPmWghbPaZpgFQMEcEMXkIV/am66Kz2E2xy3Uu
29EIovj04T1ZiYZpT89rrEWyK94L3org/wxE1H+F7Mg8D6bExZwsyh7YfhJcvSJb
u6vs/BkndQ+P0NClhQcO5F3JnajGIthuCwTADHMn3ytWQzjWiJbLLpNc0oXv1/IU
OaKBOvkB7J+LixELrCtukiflFiozdi6s/zRfAnncGWfLWUO/rxirQdgRe5vySCit
MH6oCkmXVkDZd5e9HDxNetFm9kq/be5OzM3FyfTXhkbZVWqVfWo7lPkrZcbEsf8X
U6TRSq/r2g7tmRf61PyB
=/+Kh
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
