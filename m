Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 18 Feb 2014 11:07:27 +0800
Message-ID: <5259299.VfKMqLSZeT@diderot>
In-Reply-To: <1392675155-26954-1-git-send-email-linus.luessing@web.de>
References: <1392675155-26954-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1400738.uA3lMOCAyf";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: use ether_addr_copy instead
	of memcpy in multicast code
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


--nextPart1400738.uA3lMOCAyf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday 17 February 2014 23:12:35 Linus L=FCssing wrote:
> ether_addr_copy is supposed to be slightly more efficient for copying=

> mac addresses, so let's use it. This makes recent versions of checkpa=
tch
> happy, too.
>=20
> Reported-by: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
> ---
>  multicast.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

We need an introduced by line, so Antonio later knows what patches to s=
quash=20
before sending them to David.

Cheers,
Marek

--nextPart1400738.uA3lMOCAyf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTAs5yAAoJEFNVTo/uthzAKHgH/3qcD81YuBYr8aT9pyMYV7s6
pBq5hIey9EYHVyiQ70WjY1XtCS2EOtJYSkgIfSuWLfaz1ue66NLFibLasqOuNXJR
lxHtTunAS5Zzodo6eblu3+AqEblcEnsc4gyBHB3jVslnozMyhcXtnEJAVAwK+TNe
YdbvRKkANDvNRRLHlj4Q2295GdgEu9b2AHvqSAATpVQftyjvY7suI2z98fgNFlMi
WgPLGQMAU+VzMVor8XIgYWeYk3p2UEZ15SvxU3B7/SGf8r/cFp/OpKu/5UN/oPHl
K6ItUPVfXFWytv7jDzmBnLjHuJHYKyvcOda3CqxoIcoEOPJxEUjibkGVQdKCavo=
=1xI4
-----END PGP SIGNATURE-----

--nextPart1400738.uA3lMOCAyf--

