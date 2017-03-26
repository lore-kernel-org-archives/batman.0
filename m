Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 26 Mar 2017 11:14:20 +0200
Message-ID: <1914867.vhgrey3SkF@sven-edge>
In-Reply-To: <20170217101708.19336-5-linus.luessing@c0d3.blue>
References: <20170217101708.19336-1-linus.luessing@c0d3.blue>
 <20170217101708.19336-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4402413.6iYuhv8sdG";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 4/6] batman-adv: privatize forw_packet
	skb assignment
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

--nextPart4402413.6iYuhv8sdG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Freitag, 17. Februar 2017 11:17:06 CEST Linus L=FCssing wrote:
> An skb is assigned to a forw_packet only once, shortly after the
> forw_packet allocation.
>=20
> With this patch the assignment is moved into the this allocation
> function.
>=20
> Signed-off-by: Linus L=FCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/bat_iv_ogm.c | 17 +++++++++--------
>  net/batman-adv/send.c       | 21 ++++++++++++---------
>  net/batman-adv/send.h       |  3 ++-
>  3 files changed, 23 insertions(+), 18 deletions(-)

Added this patch as 61913abf08296a5ae20df1a8553b019be6f83824 [1]. Have added
it out of order to have at least the non-controversial "cleanup" patches
integrated. The other patches can therefore use the provided functionality
and you don't have to resent these patches anymore.

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/61913abf08296a5ae20df1a=
8553b019be6f83824
--nextPart4402413.6iYuhv8sdG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAljXhmwACgkQXYcKB8Em
e0bX2Q/8D+3+0pDJekv+rtPUpDNqUU69pfvKip6FTToA3sKzKl26nbEskZW9xbsE
DseBX8GlEDijj5IzRlgNl7Il3aoq4sB1+Q633xa6RZOwRz1ErmpQIvgD9eSKRgbN
QXjUFsonH2hJ1KDycXMVaCpaNOnk13ddUgKVNpfdEqE0t77tlPbwq1M25iJ7pEhO
D3m2zpkvsAh607BRvrP53Smpt0SerWigsfxXh1r23GnbZaLfRrLpbwjeFjKpJxJU
OR0hfVUokv/Bw6k1OwolGMmUx9VVbeziKEqXvQPn/hTSsjYBV+rRlaQ6zWOXrVNE
YOmE4vMC88uT3htka4cpboaSO3hXBt6NPrJpYd9S6wtnePwHuVbY/4sZ1kT7HR5m
krXJ7UCTbqqKnjl1Bgux1J/Yzy1seg73AE53wlpOllYQniT9DhjXEEb7NgHKApLA
9dF2OFA0bFUa0UOHByXpqHtZjPq+HykYnemOM/Y16cHn7xKCc4Xisf1/lpqfgH1U
9oEywmsGU0e82Q4KaiaIyIgBPzSVIiO9lsE+9xw1apDty8gd4QGuXPkmirCXgl0m
OCfMHZcJSvRUOvH50D4wTXRH/kY/Y+/EyCRafdrHb5xef+/z/LC3jhDSG7aoa9cJ
6Qgozxx5kVc+avyQg1cRM407T6datHNbFeq3wUrR26FYMezFdVQ=
=DJZ+
-----END PGP SIGNATURE-----

--nextPart4402413.6iYuhv8sdG--

