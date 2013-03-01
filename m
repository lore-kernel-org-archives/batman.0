Return-Path: <ordex@autistici.org>
Date: Fri, 1 Mar 2013 12:08:09 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130301110809.GC20607@ritirata.org>
References: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
In-Reply-To: <CAP5XTDP_8pCJA8uXpQoMNExiVaCvmBCmkKT_aDErk0qYk7-pmw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Implement DAT for IPv6
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


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2013 at 12:59:18PM +0200, Mihail Costea wrote:
> Hi,
>=20
> I've started implementing DAT for IPv6 and I have a few questions
> regarding the design.
> I've already implemented a snooping mechanism for Network Solicitation
> package, but now I have to add it to the ipv6 distributed table.
> I'm also a beginner in kernel programming so any help would be useful.
>=20
> From what I've seen there is a lot of code in distributed-arp-table.c
> that could be used for ipv6 distributed table.

yeah, I think that the table handling and DHT primitives can be reused for =
IPv6
(they were designed on purpose).

> A problem in using that code, from what I've seen, is the fact that
> <struct batadv_dat_entry > has a field for ip with only 32 bits
> (__be32).

Yes, here a way to generalise the structure is needed.

>=20
> So I was thinking to make it more general by:
> 1. transforming that into a pointer (unsigned char *ip) and add a
> field size which will represent the total size of the ip.
> The ip itself would be allocated dynamically.
> 2. use a union with both _be32 / struct in6_addr. In this case the
> problem is that if we use ipv4 then all the other space for struct
> in6_addr would be wasted.

correct. and for point 2) I think we waste a not negligible amount of memor=
y..

>=20
> The second problem from what I've seen in the code is that the
> batadv_priv->dat field is hardcoded.
> For ipv6 we would need a new field to memorize the table, but I don't
> think it's a really hard problem to solve in order to make it general.
>=20

I did not get the problem with the dat field?
Can't you use the same table to store both IPv4 and IPv6? The DHT is made to
store general data, so I think (with the suggestions you wrote above) that =
you
should be able to use one table only.

> This solution would be to avoid code duplicate. Off course, I could
> still write all the code in parallel just for IPv6, but I think that a
> common base would be useful.
>=20

Re-use code is definitely the way to go :) easy maintenance later, one sing=
le
point for bug-fixing and code has been tested already (so it should work[tm=
] as
expected :-))

> Thanks,

no worries :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRMIwZAAoJEADl0hg6qKeOl8YP/0BRlI2EmIFUQazvqXKH5/OY
AVxnwhHNLMsd4hCR4kObOhiXePWZkf+IVuhpFPoouW4eiVhZS+ekUmBtZDh0Jumv
HL6M3M7D0/SOpsUYNaAFXr2lyTZR5oL5prr9/2g0PCIQk4GC1dpdMxtOZ7jgTqh3
u00rKbK97pafkCcEugC7WscKZ5Iz67umZJUtGiADjI9k57A+1qxDa53KN//taoce
kgAcG8nWnzJfjbiQpRfI5NHYRehN+8/kUb3t55ZJ/bGkW8IRvouIoyk/oo/NKTYL
XI7fK0nPH+q3H9xpelkzSCmnl3Ruw1q5F6KGqLDRLpInlCdnpjB56gjW6oy1L6bd
TIoL49uK08sincx4rlNAADJmyJfGw0RPSNMUSekhX21ckNwmluclsrsIe/pH34cd
KmiIzUeYYvjgqyqNLIIYv5XvO7QH7dpygNdftslIg0uQmK2tSLI82yCLjOPyJPVi
sYuoE7AmLu7Gskr1A4J08/uz5Za4lmu22qxyUD5JMYPZOzB73Dotzt2F39gagoVP
RfU78g7QOiNyChbewnfFzTNlkc+1Ao5AjJoznANQJ0vuIjPi2pPgiJ7GWjn/7jxr
Mr/dhRfYWJopCecoja6dlvSoKPQr5OaXUmY981LoVy5tBkDB51V2/ChUfmXiqhow
/TUNMnaLkNSa72IMXB/6
=3I2V
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
