Return-Path: <ordex@autistici.org>
Date: Thu, 24 Jan 2013 05:55:31 +0800
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130123215531.GE10344@ritirata.org>
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <4b41fb1f387acd24ecab6e4e47b2126b6dbddb5a.1358961079.git.mschiffer@universe-factory.net>
 <20130123210730.GA10344@ritirata.org>
 <51005884.7090106@universe-factory.net>
 <51005B89.6050506@universe-factory.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <51005B89.6050506@universe-factory.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: filter out invalid DAT
 entries
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
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2013 at 10:52:09PM +0100, Matthias Schiffer wrote:
> On 01/23/2013 10:39 PM, Matthias Schiffer wrote:
> > ipv4_is_zeronet() checks if the first byte of the address is zero, to my
> > knowledge there is no special funtion for checking for the unspecified
> > address, as the case is trivial and independent of byte ordering.
> >=20
> > It might make sense though to check for different types of addresses
> > that are invalid for ARP (zeronet, loopback, multicast, etc.), but I
> > wanted to keep the patch as simple as possible. If you think these
> > should be filtered as well, I'll prepare a v2.
> >=20
> > Matthias
>=20
> Oh, I shouldn't top post. Well, continuing here now...
>=20
> I just noticed that batadv_arp_get_type() already checks for loopback
> and multicast addresses, so adding ipv4_is_zeronet() should be enough.
> I'd keep that in batadv_dat_entry_add() though as the source of ARP
> replies with 0.0.0.0 destination is still valid and can be should to the
> DAT.

mh I would not split these checks if they are all logically connected.
Better to leave the patch as it is, imho.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRAFxTAAoJEADl0hg6qKeOFQYQAJyv31oq1CFBOTAF/CQovU1Y
1vNEp6x8uct9WKeqKXCzx9DzxIeB6f8GolhCzPftZmm8J4Z7jWturBbYGd92vstg
4BevXK3NNMeuCY8tO3cDKvpoHzXTMfFI59tvs+m9kMGrHD/wV/WWZhtb9x3yH4od
ft0VfY2xn08+fjDT8YxMMSctNrQiVFY8wsYr2IVDdqIerOcIgj5mXOgvCApNPSgW
1MSydaSSqQFPWnvwageUr6hqkiG+viG79icfjzTY2tsVHyEsgix0Jyd5p6u51RJZ
LqpqKsHVYXoIMFtqyEXFeJa2PnYeWQYgbTS9lh1gIYKZLLz9wn3MebZeew74p2Jo
U1sYNvxJ34dUd0XhHarYtiZyoP9qzl1c0oq1XDD4vj0VUzZuxR5EUz4RqIvgbktM
PJm5aSBA4P/8OeiTnapYIKxZtOHT8IyotWMtI1m7ItzvBrr0hGZuzo+7tbIpG3S+
MWaDjByBKbQJGZtIVbBbqt/mGVkNgwKZ03pljH8c3RS8eH8LMnR3obuNa7+sKG/P
9VvCI/SBni9rARahsYdRsADHh1bUtDabEy0dbGJOWyQnReiYaO6CsVzVxgwJS1gB
FsqjxuoW/McIOH7iro+KX9ACNDwmg8c++dvA5hcl65pL9L8eAvSnEwU6YdNuRuOe
WzEobVVdZcYLzd6+826J
=oKxg
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
