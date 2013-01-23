Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 05:11:37 +0800
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130123211137.GB10344@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix skb leak in
 batadv_dat_snoop_incoming_arp_reply()
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

very good catch!

On Wed, Jan 23, 2013 at 06:11:53PM +0100, Matthias Schiffer wrote:
> The callers of batadv_dat_snoop_incoming_arp_reply() assume the skb has b=
een
> freed when it returns true; fix this by calling kfree_skb before returnin=
g as
> it is done in batadv_dat_snoop_incoming_arp_request().
>=20
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

Acked-by: Antonio Quartulli <ordex@autistici.org>

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAFIJAAoJEADl0hg6qKeO87wP/3E9QqK3xP+F5r0d6d45/AV/
AOX/fMzn1+VZLbtKmAWRtpYgEeVkc4ZBR+aqx7db6Z32LRgjdrX2wv6oMWhTiwTg
FWfilJ7aBN07HxhZsFyNWl7HqZlsoXuUQdmcawngDZHYIRt9bDoOu/4KldIaTa55
tR3bx070xM5n16kHZLJvak65HKKK9mNSyP13hueFE89CZB8xhMSXpQqLFGORABCm
LNJC/+GGHwokiUOV4gnREPyRum/b4+MaOhg89dc1uPSyxbFdAaFebEp+0J5fIRfZ
WfQqZutIa2Pk+2KdP4cqUy6SEyaYNFJSWRn2OcNpNMZCZWkJWBdn78GELRV9MAJs
u7gLmTzdWw88cgQp4OykYu127vCcIRXZtDnJjfgx9nZ4UUtBH64i2osoMuRaIHQO
+UbhnP2eBQTClF/abPEbpv23XSOGz54V6IgIDpae6oko5PpMvKnVfdLx4LLfjilb
pXlSiT9KpEz9f3UYe0MP/DqM/qfDUjjCNpHiTSOJny85D30gnQgjiHjqniXS43Km
Kr7298lvgvkJe4fp9vt1d4EaMZF+Fe0pJH2LHxJpvU6rn3ZpcP65FOyiJdFx9Qj8
jvT9ivefLEXBFolIcMzok+dijB0YJT0XsGwYxbXClzvHihnIj9hi7o9oTwSRsHqM
mbPsoM2IAJgpSdMy492g
=wmE3
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
