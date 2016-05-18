Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 May 2016 09:50:21 +0200
Message-ID: <487854669.Af666lYg74@bentobox>
In-Reply-To: <20160518021611.GG12056@prodigo.lan>
References: <3413869.lrcFurLlMu@bentobox>
 <1463506353-11676-2-git-send-email-sven.eckelmann@open-mesh.com>
 <20160518021611.GG12056@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1515565.rx3QyP3FPi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v9 2/2] batman-adv: throughput meter
	implementation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1515565.rx3QyP3FPi
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 18 May 2016 10:16:11 Antonio Quartulli wrote:
[...]
> one very last question (sorry for not spotting this earlier): if we don't handle
> the TP meter with the icmp_socket anymore, why do we tight the TP initialization
> to the socket initialization ?
> 
> Is there any reason to have it here ? Or we should move the
> batadv_tp_meter_init() call to somewhere else ?

It was basically just because it is still bound to the ICMP stuff (even when
it is not using the socket itself). But when thinking about it, then you are
right. This should be moved to the global initialization. Not all ICMP
handling is done in icmp_socket.c and thus this also doesn't have to be added
here. main.c (batadv_init) is a better place for it.

[...]
> > + * Return: 0 on success, <0 on error
> 
> you forgot the space between < and 0 ;P but if the rest is ok, I am sure Marek
> could add it :)

Can I just say that it is an copy+paste error from your comment in
bat_v_ogm.c ;)

Kind regards,
	Sven
--nextPart1515565.rx3QyP3FPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXPB69AAoJEF2HCgfBJntGfZoP/3FPFf+kApaURmnvyB3jzs0M
kFV/RYxo0GMwdBDw/AlBXoELoLCziegxX2MzdqdXUNNuD1qV/n4N3PWHpAVUjb4J
pB4U8Z3lNmL6a1JwiJ5gkT1SHuSRVkcO3VteojP7uXSjeWEy6Ypjj1KGESJuLjmu
GF77/6NoLDq+oIJZML5kEVhv2Y+Udsf7za+vo8+ZL5Ea0zus3/OaldsaZZBXWf2u
nrcxS8HILygjUByW+svyndByIZBQhJMks776drwNAx2Pn206YjQx+vV7rQsIu8OM
zfvOwQN1qW52MimI00u7thTszVdKVyjn8M0v8f7JsqFPcigD0RfJJPXeOBMrxPjl
QSHilNMMSlf93HZySDI4NqvxI7yoFy31jwQ7vCZwnIrQvY+Milj6kipsQqJkLniA
lQ3p2nUi51sFZ6NBHmUSVdAv0t8aQW/hu8eqMHphFZztpW1bqyIddwee2Dkdzj85
ivpSPWdnHoA4e7wazTcUz2WG8ihSbfsTBklLAVLXWJaLSr+RlPxExVunQO7D0V+0
Ak4E+eSes2h+oeRTcZxmVBO5T72mFCKAbibRfvxFGBuC7yE8UdhrywyGY4eqketd
eUpvO9tuGlBxYed8wQxvLfKZcRlV/Zlzx4QSQh/Ga2dkK3wX812Q5O39o9U+0Q6f
/nYwl8mboWpkPXqF5spO
=Vt8Z
-----END PGP SIGNATURE-----

--nextPart1515565.rx3QyP3FPi--

