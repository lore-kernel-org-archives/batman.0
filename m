Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: Re: [PATCH maint v2 4/4] batman-adv: mcast: fix duplicate mcast packets from BLA backbone to mesh
Date: Wed, 09 Sep 2020 14:15:51 +0200
Message-ID: <3191833.Be6Uz4tNrB@prime>
In-Reply-To: <20200904182803.8428-5-linus.luessing@c0d3.blue>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue> <20200904182803.8428-5-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1682057.2v8p5POe7E"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>

 
--nextPart1682057.2v8p5POe7E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, September 4, 2020 8:28:03 PM CEST Linus L=FCssing wrote:
> @@ -1626,7 +1626,8 @@ bool batadv_bla_check_bcast_duplist(struct batadv_p=
riv
> *bat_priv, if (entry->crc !=3D crc)
>                         continue;
>=20
> -               if (batadv_compare_eth(entry->orig, bcast_packet->orig))
> +               if (!is_zero_ether_addr(entry->orig) &&
> +                   batadv_compare_eth(entry->orig, orig))
>                         continue;
>=20
>                 /* this entry seems to match: same crc, not too old,

Shouldn't this check also be skipped if the orig parameter is a zero mac=20
address? i.e.:

if (!is_zero_ether_addr(orig)) {
	if (!is_zero_ether_addr(entry->orig) && batadv_compare_eth(entry->orig,=20
orig))
		continue;
}

Whether orig is zero can probably be checked once before the loop and the=20
result cached in a bool variable.

A little comment may also be nice to explain this part a bit better.

The rest looks good.

Cheers,
      Simon
--nextPart1682057.2v8p5POe7E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAl9Yx3cACgkQoSvjmEKS
nqFGyA/+ONCpPfoirkxEiz/C2rz9AZ88JiU4mlru++VNu5mMFsC+ebfFuVDHNbt5
BHD8cukZwXjdSQPXsZHjtuMKkR23JZTXkBttLQp/8lqOIFqUN1tUmCnMSnftkx/M
K4usfJjVZxRT5piNL8pg5VMZ9yc3IIcITn5x+DWkd6TKFmanEOKAfLJczSyuoSeo
QahOyua1Ac3VOiMws5oEgTs6G1lxfWfJmg2itiL/QhUtykJQ4WZgUTOoz/64aMU0
enRQC6EtmZSXy0ioQgudL2ImFr2jNhHZUoU5vCjQpljxSRErYYc2E6LVPAIIbXpX
cVW8FjkfA4P95Ncf8tyrXbvQOzs1ZqtVQYGPTRQEgfhDp46PtWe2fX5emMvdPNGL
tj38RZFKS5lL83AXnTS0UIJ3pN5ft8PwYyvCFzSY0Qy0yhqJzoWGPbjPR1wQ95zD
+eBKp9YjDqgEE8Woh9XSvZzG068Cdp1BxW8SiNsmsAU5VOu/63GU78GJm7qv9uCT
OeR7cbgcJ8uvJRe6cdH/pWCr0+QntJE5+JnUE4/yweP4eb2hHziJWOjlQVvcnooS
c59VoMctHNMbH/R9peqPyyW4mwb+0aFwwvhhHXHAlSVHtZe7+B9xJ31rAr75pyZm
YgrZ50KyKG2IRpeZV9vbzvZienOvN9zekLV1I5q6SP1LylszuuE=
=bYD8
-----END PGP SIGNATURE-----

--nextPart1682057.2v8p5POe7E--


