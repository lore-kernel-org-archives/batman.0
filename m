Return-Path: <ordex@autistici.org>
Date: Mon, 2 Sep 2013 08:43:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130902064325.GE1871@ritirata.org>
References: <1378103705-23183-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Content-Disposition: inline
In-Reply-To: <1378103705-23183-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: limit local translation
 table max size
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
Cc: Marek Lindner <lindner_marek@yahoo.de>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2013 at 02:35:05PM +0800, Marek Lindner wrote:
> The local translation table size is limited by what can be
> transferred from one node to another via a full table request.
>=20
> The number of entries fitting into a full table request depend
> on whether the fragmentation is enabled or not. Therefore this
> patch introduces a max table size check and refuses to add
> more local clients when that size is reached. Moreover, if the
> max full table packet size changes (MTU change or fragmentation
> is disabled) the local table is downsized instantaneously.
>=20
> Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>


for the TT bit:

Acked-by: Antonio Quartulli <ordex@autistici.org>


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSJDONAAoJEADl0hg6qKeOEYcP/jfp5TDRmSkNWitqA9wmJGid
CDJN3zAR0GUqX3vVRvuQYDE4EO0NzAPniOQQrGkR2JnvJVZEFMmO2lpXfq+j1qgh
PhjxQkYCuvKSdMRCsQuAuTAUqyHRqrHm13MPirMhT2ssUon+yHtJY0PeD1sU3b3d
JlmJGbjHSMF9J/Tfztkc7xK48KZ8XA4PpkANEqIIBAa0OcoUpK7qh4okestwAOKc
46RODk8diHc0AUFjNuYB5+L6orrIW3/xcv9wLae6LXyTrXgqB4JWtBVL0OhbmmYj
qX7d6p7GYcL0OP6xeIB3nDYjkxj780EYNy3SJmdCDjHwt5Dyv8CEaalzDymXWwIF
nFT6rPr3zGP2XCRA3AQIp1aMSuLjK64AE/r7KuFZoOMiKMdMJlG2R/i442uOMPfL
5CfxJIQfzYzJaqIA+19vceja+bnA2py/q4jaawXEM5WutFK+uFiSUcUETMXBeAgf
sfiatWIYips18T/Y46eQJP7F9uYtzsLPLxHlAHVh5V+QzK5DPoYHs6VwjP2d5ynb
sfRttIaHSJ/A43K5KO4F8wNgUuygo+A3GDXwRErYzv6ARe55ts8CS1c8BuATuu0U
5LL3Z21+gHKcPk7E/aqowuOQnnqkq42c8CFGeQcCwHZGhbqpHgBdju/CtjzaFpMP
k4yTho1Fbz+CZ7QHYI7S
=UXVX
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
