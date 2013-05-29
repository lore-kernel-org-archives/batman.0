Return-Path: <ordex@autistici.org>
Date: Wed, 29 May 2013 17:43:53 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130529154352.GW3333@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
 <1368793673-27539-3-git-send-email-mihail.costea2005@gmail.com>
 <20130526140240.GO1679@ritirata.org>
 <CAP5XTDOc8iDYQNLbY9f1=07eifGWMZD2xYqvPF+VLxk4M5M43g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8KmZJhJMEENkOiL3"
Content-Disposition: inline
In-Reply-To: <CAP5XTDOc8iDYQNLbY9f1=07eifGWMZD2xYqvPF+VLxk4M5M43g@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 3/4] batman-adv: added necessary functions
 for NDP,
 like checking if a packet is valid or creating a Neighbor Advertisement
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


--8KmZJhJMEENkOiL3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2013 at 08:36:50AM -0700, Mihail Costea wrote:
> On 26 May 2013 07:02, Antonio Quartulli <ordex@autistici.org> wrote:
> > On Fri, May 17, 2013 at 03:27:51PM +0300, Mihail wrote:
> >> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
> >>
> >> Added functions needed for NDP snooping, like getting the IPv6 address=
es
> >> or getting the target HW address from an Neighbor Advertisement (NA).
> >> Also added functions to create NA for Neighbor
> >> Solicitations that have already the HW address in DAT.
> >>
> >> Problems: I have to generate router and override flags for NA. For now
> >> I don't now exactly how to get them. From what I've seen, batman could
> >> now which nodes are routers, but for override flag, we should find a
> >> mechanism to know if the node is proxy or has anycast address.
> >> For inspiration I have used the code at: <net/ipv6/ndisc.c>.
> >
> > What is the concept you have in mind?
> > Maybe you first explain a bit more about your idea so that we can help =
you in
> > find a way to implement that.
> >
> > You want to edit the router address and flags carried by the NA?
> >
>=20
> When creating the NA response for an HW address already contained in
> the DAT, I must set 3 flags: router, solicited and override.
>=20
> The solicited flag is 1 because I only answer to solicited NS.
>=20
> The router flag should be 1 only if the device for which we have the
> HW address is a router. From what I've seen there are some functions
> in batatv for finding routers, but I'll have to see if they can be
> used on the nodes connected to mesh-nodes. Or maybe there is another
> way to see if the device is a router.

I guess here you are looking for an IPv6 router, right? so a node which
advertised itself as it, correct? In this case in batman-adv there is nothi=
ng
which can help you because there is no IPv6 detection of any type..
How can we recognise if a node is advertising itself as router? maybe by
snooping other NDP messages?

>=20
> About the override flag, I don't really have an idea. I didn't
> understand very well how it was calculated in net/ipv6/ndisc.c so I
> set it to 1 by default (it should be 0 for proxy and anycast address).
>=20

mh..ok. We may want to better check this once more to avoid triggering any
strange behaviour in the network :)

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--8KmZJhJMEENkOiL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRpiI4AAoJEADl0hg6qKeOLVUQALWLfxeHNf9Wg3ENooZGC+LO
94V1gKbr1ZDwfPcXnSwqIU7f4xmhtVRgKrPN2lAS/kp5ZOKhLYJm0tXNQUyRG1Uw
+dxDQB2ZSWzPXxVx8FdHZHyp8FOBU3ZI6UUMCSvWkjf2ymZiEURkEIGvZSOHSB9j
YeY1JpQjGNqymR4DfyapMhKq+sLvxNqV/zkSl3soF0KYbnosVEm5BzKPKCapr5c4
x3BqiLpbii3Gnt57blQtindym+JRfqLQj4+xMgy6Hf3cs4Lky4iHNYdYuqViJncH
PqdXbtdmkQaiYqCJod52d7fmCXRk9UjCysuCWu6alnxvI4ip4g0srMzpnmdlvoIA
GZMQkchAQgh6kKw+erTJTB+Mgq+MG+5dmwGzQVN23TUnsvJAOVAiuP3H10n8jLqO
wDN1msXmQC81yjo8IQ420E1QKYVhHGJl/K9x4Kq28qe/q2sLfZ/adDRr0evwnpOJ
EuqJrArG1DbxckhgrOeKh9lFGGWnrP1RDIuQdtP2wdjLxATYKIbIKeMLV1EVNTPA
Lt+Kl/V9Y80+NNaduyhTJ92OIF1r9KFMLRG1fMJcOK5SL9aZSbf91LMKVQFMYhCI
T+jKz5ga/lPk7ROtHAVPHTMRXW64vjZRiAnMrZ61hI7vdVd2iSnQhMNol8fgoKyq
NnR7e9SnSAmDBZkY9BYH
=wYXj
-----END PGP SIGNATURE-----

--8KmZJhJMEENkOiL3--
