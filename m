Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Jan 2019 08:58:32 +0100
Message-ID: <5023487.B7GbudR6Oe@sven-edge>
In-Reply-To: <20190104022916.GI21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-20-sven@narfation.org> <20190104022916.GI21623@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21785035.0hmNaWmsS8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 19/19] batman-adv: Trigger genl
 notification on sysfs config change
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, jiri@mellanox.com

--nextPart21785035.0hmNaWmsS8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 4 January 2019 03.29.16 CET Linus L=FCssing wrote:
[...]
> I'm wondering, before it was quite easy to add new sysfs
> attributes with just a few lines thanks to macros. Now we
> need to add code in four more places in netlink.c whenever we introduce a
> new configuration option.
>=20
> Would it be possible (and maybe even reduce code size?) if the
> sysfs and netlink parts were wrapped into some (macro) functions and/or
> structs, to still be able to add options from a central place and with
> only a few lines?
>=20
> Or would that become too ugly? Or not worth the effort for the few
> options we have right now?

You only need a couple of lines to add netlink things. And we don't want sy=
sfs=20
anymore. So no need to add ugly hacks to add both netlink+sysfs with a "cou=
ple=20
of lines".

Kind regards,
	Sven
--nextPart21785035.0hmNaWmsS8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwvEigACgkQXYcKB8Em
e0ZVSRAAjLfRmzKQgn8aGDoA1RcOYFoDD0kzEJtYrOe5Pzrd46huaev/bv7U8r8h
faYjNjH44e2zKm9O6GNiCmIepZgoUWaJqkVGjvDDPdBaIjwvdBLMLGyMccpjXATc
wl8iBmdl85ElAxOdbhvVNgGq/zt0f8+MaI3Vdqd8XuLKh6MX3rdpkmmr78k/GJYh
ZYiOgrOK/0OL4lHBc0o5Bn5FyRgOlnf4EHJZQFcMCYHmAdQAeqXpNf60LABmvfok
DXPNa78Z5lUg6ixpBLdSMPMWDptHtLvkgh5i+PRPoOc6oui9gaQw/B7gx8uJkN3n
s/tWredCzjjy9C4FOgD9nKRPBA7+gQkp1BZxjH/+G/uH0s/wIismuh25cUxHfC1r
D1V50IhtMenSDsJuagrkzodB5Psk2ON6mQra8NUji1sSzRITg5Evo2tDnbaMAF15
eSnMh4PsOj/5V/tXO8F3N8yzj44u+iUcPE0RLkL60qnFGnvVczb/EQNvpj3fiK4L
ZpWFkXZL9KeeyOrmT1hnjFz7jxAH4y/zCLWQkkY5Po3NdBXehTHDXQ9+7dMM71uG
AG/qLSVN+Q84imRzpSOMYbLV7v3pYDTVHHU1WtPU2f9ew3cdwQKl8k0o8RS4ZR3c
YKmm/rHRKwG8w3I8H78DH9mzqL5aoqVy+E1MkbQkicCAFv/Fl1w=
=7ogC
-----END PGP SIGNATURE-----

--nextPart21785035.0hmNaWmsS8--



