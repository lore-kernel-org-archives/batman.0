Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 07 May 2018 08:32:28 +0200
Message-ID: <2722022.Z6qn7ThOV8@bentobox>
In-Reply-To: <20180506195559.32602-1-me@irrelefant.net>
References: <20180506195559.32602-1-me@irrelefant.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2891995.nNjuQqpKoQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: mitigate issue when
 empty vlan is received
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
Cc: Leonardo =?ISO-8859-1?Q?M=F6rlein?= <me@irrelefant.net>, Antonio Quartulli <a@unstable.cc>

--nextPart2891995.nNjuQqpKoQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sonntag, 6. Mai 2018 21:55:59 CEST Leonardo M=F6rlein wrote:
> This patch is not a fix for the issue itself, but a fix for the
> other nodes, which are also influenced by the issue.
>=20
> - Some (affected) nodes send TT announcements for an empty vlan (for
>   now only seen with vlan_id =3D 0).
> - This behaviour is a bug! Batman-adv nodes must not send TT
>   announcements for empty vlans.
> - The receiving batman-adv can not handle incoming TT announcements
>   with empty vlans. (The crc check routine batadv_tt_global_check_crc()
>   fails.)
> - As the receiving node thinks, the crc is broken, it does a full
>   table request then.
> - The announcing node sends a TT full table to the receiving node
>   then, which also contains the empty vlan, so
>   *batadv_tt_global_check_crc()* fails again on the receiver side.
> - This causes a lot of unneeded TT traffic. In Freifunk Hannover we
>   decreased the amount of from ~20kpp/s to ~4kpp/s on our supernodes.
>   We have ~800 nodes, which are connected via vpn to one of six
>   supernodes. Those supernodes are connected with each other in a fully
>   connected mesh.

Can you attach a (small) pcap of actual traffic which show a packet which=20
triggers this behavior?

Thanks,
	Sven
--nextPart2891995.nNjuQqpKoQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrv8vwACgkQXYcKB8Em
e0bK6Q//THbbce2MVFFAUWlDbonix3ZZjy7Oi7/HYbnddr4YSHLTwlV+36+z4Gwu
/O3t6qz3rXkzTwtBawSwBZ8bbl7zH2acdoVbr9ntwd6vLCBmw11hdnGVkeWrhPuT
8NaXES+Cb7zHl3VEOmqVHCZBv+zgizW+urzy82WAU/1471C1FTIs2HPSQ+tcQ155
wDcyFheQsEiso6v8FlWkufVapho8N5JfDyTt6Q32SfE9H4oMEJU8Gd8JK9EhLFAs
LOkDHBlpBzfFG8FnCmKsqqIeUYZoqe3Dg4ARX4ND0pwpLcSLmc2nMim8NluHGoN4
9KV7/fBGsQjdzVt6vA1pv+6XEmng8p69GUL94m4WQP4+RK4gvOsMS2ZsSQIw7Ub9
acmthbA5aglBYIys4csj7jxb9jHuAtwoCGaNmovxVu61Zxvw3SKxZjHmpkgcFfFB
jew9Vq0gS/XkDs1FkyFKuzRC0orpwssSlfh8a71MqkkhD3S4XfkSYtlzKR2kuPbI
APVDQV9oXiD738nASsWlfSN1FbsfIYJbV7q/grHiiViJsbxjiII+6rqGyqR+9F/Y
atBwG0pfj1IMoeE/rPUIJ0bP6Y2N2k9fVsc5ro/BVYPskimezAl7dqTL3zbu7ODd
VI1wh5Pv4ZSHiyxNIXm0DTD4N17tJmuWJw7xUNeKkHMKyLH1Ww8=
=QQR/
-----END PGP SIGNATURE-----

--nextPart2891995.nNjuQqpKoQ--

