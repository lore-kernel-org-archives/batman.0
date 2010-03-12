Return-Path: <linus.luessing@web.de>
Date: Fri, 12 Mar 2010 01:09:31 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100312000931.GB13786@Linus-Debian>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
	<201003112333.15318.sven.eckelmann@gmx.de>
	<201003120004.48753.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <201003120004.48753.sven.eckelmann@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sorry still does not seem to work :). Despite testing it on a
setup in batman itself I also tested it with a small c program
(which does not work as expected either):
-----
#include <stdio.h>
#include <stdint.h>

#define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
#define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))

int main() {
        uint8_t old =3D 0;
        uint8_t new =3D 1;
        if (!seq_after(new,old))
                printf("foobar\n");

        return 0;
}
-----
$ ./test
foobar
$

On Fri, Mar 12, 2010 at 12:04:47AM +0100, Sven Eckelmann wrote:
> Sven Eckelmann wrote:
> > That must be
> > #define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
> > #define seq_after(x,y) ((y - x) > 1 << 7 + 8 * (sizeof(x) - 1))
>=20
> Nearly correct but accidentally  deleted a =3D
>=20
> #define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) >=3D 1 << 7 + 8 * (sizeof(x) - 1))
>=20
> Best regards,
> 	Sven



--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLmYY6AAoJEBKw7u43QNpfnAQQAKQ5yWIUMWKLKtXwpgk3reZu
KmWJ14AROHq4jsBlfwb1yWDyWdbHTpDyVx0f5t2X7JC7p5v/ccqUJbpJlYTPScjz
SEPWqW2aPkGwvTrPge2C8fWp/hhMiXBrvVAyhdUU35S/1piiaXU5pZ3K+b9Omxg1
nX0+cWR92aHMlmt45riLanvE27PTqk4p5C2J1ijU5XUysUntxIpgPTiPDZQ0QFkP
eOBRPvhoqFnOnTs5PgqGRr/y/E80+CFcNyUWN2jrtp5ClmxbVjdB1Q1vNLIa9CRF
dnGtNcL8Kun9E4gHsFemUlr+B6dh+BczVQPBbx33MGe0Nr32A7xupwaZQW7IeP7h
TVEKhciuxX9quR+p+MYfQvxFsCyJAIeodf1nlUdpTt5z7g6yw4PhRNjO0/dViHEc
Kl7lERw6VqSnrEYVB1erXr56EptTgAtYH6XSRIiAawS/zgmGLsvzTat7WxpJAWiY
nZ65kuNK4N6yI6ZZB7Z0pf3HLvmQnyPK/7lEYevBxE1wroEI9fCeu6cyHvqmzLCF
oTwcOD1vzQonNeIjxN/E334Sh9Z633nowdyc6cB6fZTvPthIa0UivZNvYaid0Vn0
ig11wXdcLdmi4i9okITbzjFRNtohD6lrJb52/yUZHlyGpC6MCx4j6hUiqcgyluhP
11FCgsRomC0nVbhX4VwR
=BpV0
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
