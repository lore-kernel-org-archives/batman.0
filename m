Return-Path: <martin@hundeboll.net>
Message-ID: <53271F2E.6030307@hundeboll.net>
Date: Mon, 17 Mar 2014 09:13:34 -0700
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1395062574-28291-1-git-send-email-antonio@meshcoding.com>
 <1395062574-28291-3-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395062574-28291-3-git-send-email-antonio@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3EPENN9sfLieI2RAO1MqXnwh81fB65K9K"
Subject: Re: [B.A.T.M.A.N.] [PATCH next 03/11] batman-adv: fix multicast
	kerneldoc
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3EPENN9sfLieI2RAO1MqXnwh81fB65K9K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Antonio,

On 2014-03-17 06:22, Antonio Quartulli wrote:
> The kerneldoc should always use the third person singular in
> the long function description.
> Moreover it should always try use up to 80 chars per line.
>=20
> Introduced by 86cb16e5ec1e2d75821006e8f4abbec66fb741ac
> ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support")=

>=20
> Cc: Linus L=C3=BCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/multicast.c b/multicast.c
> index af3fe49..0e8bea8 100644
> --- a/multicast.c
> +++ b/multicast.c
> @@ -256,11 +256,11 @@ out:
>   * @skb: the IPv4 packet to check
>   * @is_unsnoopable: stores whether the destination is snoopable
>   *
> - * Check whether the given IPv4 packet has the potential to
> - * be forwarded with a mode more optimal than classic flooding.
> + * Checks whether the given IPv4 packet has the potential to be forwar=
ded with a
> + * mode more optimal than classic flooding.
>   *
> - * If so then return 0. Otherwise -EINVAL is returned or -ENOMEM if we=
 are
> - * out of memory.
> + * If so then returns 0. Otherwise -EINVAL is returned or -ENOMEM if w=
e are out
> + * of memory.
>   */

The commit message says you wanted to use third person singular, but
your change keeps the "we are out of memory" ?


--=20
Kind Regards
Martin Hundeb=C3=B8ll
Frederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net


--3EPENN9sfLieI2RAO1MqXnwh81fB65K9K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCgAGBQJTJx8yAAoJEI7EM4tTnYEZg6gP/3KAXi2JJ68+cAlZQE1AeKNl
ZNlA8yijJ/3h0Yu1xvU1d7pf1HVcKuFt3FhrLJ7Dx932ucPVLrMEqOE3U1P9YQF7
hEOiQUox1ozL/qUOOGfX2gnAQGVZSj2JHCSdiw6pE58S3ea5xWCqAmm9T0lDDgSc
0768i/cg3NIDotPcZy2t66q8oq/8r+29XmTYNMNUuGfepu/NH35W7W5kYhBlPoY5
iUEKeIWy0d/Pkn2d9jJqDZ2IUCCmDLi6JPjAhquGgs3LoztE2021B6NEcqx4LgXP
KT0GwhFD4MaIx3+lBMLOYVtBf2GZCxN8aEMkCzeHtdin8HLy+KtixAuCDMrxtnv1
x14RnLNc0gz3eE6036L8f/VCDdyNacYmhhbHE2IJT3nVOPncHFrm/iGQ0iVQ3oW8
oY1nEusFU0UdBvipV7/Y9bIGuh+9mYc1ZFtU3vg2/UjtkEryp93vwOVYu5P4yQFG
hM2L8uF6lwnCjwRLKplgN//2ts6f7MXp5lna/W73WyybSz7CVnaVs4nsSraxTSat
nn/SitHzDKzXJ3ucl2bKsYTZCO6ocnKTasOf+gSJGTnTg5N9et10SNhXAPA3UUo6
VRepEGR4A5NHtEinRkudK9od6ccbyUwfIqmibZodgSbUTJfZDHpe7CcamnHwoN90
aFWG1OL2NZY/m87gm5zw
=6q+3
-----END PGP SIGNATURE-----

--3EPENN9sfLieI2RAO1MqXnwh81fB65K9K--
