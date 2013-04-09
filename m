Return-Path: <ordex@autistici.org>
Date: Tue, 9 Apr 2013 13:28:43 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130409112843.GC3624@ritirata.org>
References: <CAP5XTDPvnsM_4Vd+y6DMSgLPEoRWGymi4drQKVeOyPuuVqU2gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline
In-Reply-To: <CAP5XTDPvnsM_4Vd+y6DMSgLPEoRWGymi4drQKVeOyPuuVqU2gQ@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] DAT - possible bug at incoming ARP request
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


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mihail,

On Tue, Apr 09, 2013 at 01:47:52PM +0300, Mihail Costea wrote:
> Hi,
>=20
> In the file distributed-arp-table.c, function
> batadv_dat_snoop_incoming_arp_request, after creation of ARP reply
> (skb_new =3D arp_create(...)) and testing if the creation was
> successful, shouldn't exist a call to skb_reset_mac_header(skb_new),
> just like in batadv_dat_snoop_outgoing_arp_request?
>=20
> I've done something similar for NDP and I think that this is the line
> that might generate a kernel panic (not sure yet, I might have to do
> more testing).
>=20
> As I said, I'm not sure yet, and maybe my code might generate it. But
> my question is why isn't here a skb_reset_mac_header as it is in the
> first function.
>=20

skb_reset_mac_header() is invoked in batadv_send_skb_packet() right before
accessing the ethernet header. This is where DAT needs it, no further acces=
ses
to the Ethernet header are done on its side.

I'd say that invocation at distributed-arp-table.c:843 can probably be avoi=
ded
(and there are
other similar cases in the rest of the code...)


skb_reset_mac_header() has to be invoked at the right moment in order to
correctly set the skb->mac_header pointer. In batman-adv we do this when
skb->data points at the beginning of the batman-adv header when we need to
access the Ethernet header for some reasons.

Be aware that some of the skb_* functions do invoke skb_reset_mac_header() =
on
their own (e.g. eth_type_trans).


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRY/trAAoJEADl0hg6qKeOlL8P/jHIn03Vo5cl0HvHWtC/pSY7
n3vOzXd/YCxlGkWP6tSS5sVgFlDCF5L+uesqulLdZFoB44hcEvDjRtnIVm3QWUa9
lbES2aTWEPwfGCbA9s9dEkfiqrFR0pCMNo8yBF01/IVeNFdYU3opxconDZnK8Lwr
TJ938HA6bgY/3EvrHWkl889NHLe7Zwe8G96SqpGA7M8ZXVPEGzX5etVAhuGxhCh2
6zQ5zrCJAiMcoCKCL2OfKpnqtzlQvfRmCFlW0VEfs9NwtgZcw2C2t5vHBEmk3+Hi
XB5cR1wA1GizDZVRhrBxMpKta5AF9v6Op/M9Jj0ihOYgLrDQY6KVSC4KA6uL3Aps
RzvaToKKVT74Im6lzHPzYyDgC8e0CzDx4kyIepTLSLZt81lspUXzIXnQ7c0QEjuz
bh7Uq6Nj0AvH+9CAvlv0X7qHUTVUWJFmnWRDC9ftfID0tgZw0bFCpOFl7emALAjj
4/3pnm3YMsXDkMd14PUHoKME/f+AmiX8VZRG1xApm4YaeOqFRNgxhugiSMWQqbTS
GabWwz4MDiJxfw3YkNf61bSa7o/c0X9K6im+bpjec66N85TE6QP6pcjfTAWXskqv
bAHvDZRw+vMKsqRXczjA1fW7PVHE/OYKf9Pe+UHpF/jg8+tNH0uqTS56IrfiD2kw
2sJSIkj6QVwXYJTZOaIZ
=sefx
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
