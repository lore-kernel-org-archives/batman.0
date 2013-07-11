Return-Path: <ordex@autistici.org>
Date: Thu, 11 Jul 2013 19:53:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130711175353.GH1500@ritirata.org>
References: <1373564858-2248-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Content-Disposition: inline
In-Reply-To: <1373564858-2248-1-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: send GW_DEL event when the
 gw client mode is deselected
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@open-mesh.com>


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2013 at 07:47:38PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
>=20
> Whenever the GW client mode is deselected, a DEL event has
> to be sent in order to tell userspace that the current
> gateway has been lost. Send the uevent on state change only
> if a gateway was currently selected.
>=20
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>

Reported-by: Marek Lindner <lindner_marek@yahoo.de>

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJR3vExAAoJEADl0hg6qKeOq6gP/A2kodfpOrYl3EIlBYoqzzUB
u6XMvldt+rd38niYR1PT+VHrJ8TEkDTthP/PQbLBvuYbGoNhZU0QLPHD0jvvYAl2
HHXytYuKo5qHJds6Q9Rt5QhfrPPlT/z1MXl6Z3ptI1sWAP1bHVKnabiNDts9K0w8
Ptz6BD85SU4JXImCBNkufXwqCaqyvm7kihi9pfAKTPhWXzfkPsWqHhgNANLw6Ht3
DlYT5ra/KE2ESsAF+XGZtQbajSZKrxPWd7TBWo0MmDBbR268suPK9POdz9uN1oPl
3yjqKnd4jqv3Kl5ImXNPRUrJpewycYoEGboM0xURNhWgL8wuF3gjr/x6J+DpBVPM
hlvgUfdDMVSLN70iZb+9By5AB9bPi3O+ShhX6zCI9DKUGFJO+nwtrw0X+pEA9nQ6
gCH9A1QNL/EqUdgtc3naWZq49YgsrZFFmK5U+bsw82bgBso6H0n15BIwN8AUPdmp
iLSEYiB1gRvILwTLuEaE/rbKfm/YYGC+q0GPjWu5hCT5X0x+AWBGf7zBgx5aXscm
JuOqaqyhZ2K6KSIlsTSrbT9N9w8r3RD/VsYuLV7WTwrqhGfT/3kWocJHHlWech52
16TfA3KfVJ+hmeCEXDzyGWmj4zYBWicHPLvbsNMWpPizFfJ/RX+jqjd/GYXBu325
49YbRqivA6s2EUNn6pw6
=fpdo
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
