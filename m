Return-Path: <antonio@meshcoding.com>
Date: Wed, 16 Oct 2013 08:16:14 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20131016061614.GA2596@neomailbox.net>
References: <1379088490-2693-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <3449342.7k6WirsOky@diderot> <20131015192023.GN3873@neomailbox.net>
 <1779622.xWDEdjCAYf@diderot>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <1779622.xWDEdjCAYf@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: generalize batman-adv icmp
 packet handling
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


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2013 at 01:59:18PM +0800, Marek Lindner wrote:
> On Tuesday 15 October 2013 21:20:23 Antonio Quartulli wrote:
> > > Besides, if we make everything generic batadv_socket_packet->icmp_pac=
ket
> > > should not be hard-coded to batadv_icmp_packet_rr but the largest
> > > available
> > > ICMP packet type ?
> >=20
> > or we dynamically allocate a buffer of size 'len'? In this way we don't=
 need
> > to change icmp_packet each time (hopefully not so many but still..)  the
> > "largest available ICMP packet type" changes.
>=20
> Allocating a dynamic buffer does not solve the underlying issue. At some =
point=20
> we would want to check the packet size - either through sizeof(socket_pac=
ket-
> >icmp_packet) or a macro or whatever.=20
> Take a look at batadv_max_header_len() for an idea how to address the mat=
ter.
>=20

Right. Thanks for the clarification


Cheers,


--=20
Antonio Quartulli

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSXi8uAAoJEADl0hg6qKeORSAQAJSSNTfipK7/O0HakEFMggJh
0bjQptHtag4+zJIAhq06n1gtrCCwOsiC3pu9ERFYrbAw2v7Kls5WxZm228ZvdcRx
smzkZF/X5OzTn2dml9IF+hQqROXarFidQyj69/kL8KOWIWAXb20wurSKUXf7XB78
uw/lal4XcPx4VpKcyF7NBesafFtwUD4g3ft0Kv4obt6Fl2pd7CZBnywZzwC+w7mo
rj3UhJjrZj4pof6JC+MbvdfMO7eyQaqJW1ewf6xnDJqe+qOKGDg0HE6w8tsb2+yL
STcmMwfI1qvvjjyjCJbcaNmT2ZMndbEdVJ5DgDG9mz7jqm0d0fEqQ5PL94KOAz0I
xOvO9o4bnRMiLwu7G5Pw5wU/M+7q3LIljBEcaI/pQu8CjYQU3u4NDfDGfFNcksN6
MyGAcYRzrPNhZaUrTkYDxe5BTzu1hYJ9jb7fV9YUi/WOQYmSdFkhQgeykiQFrx4j
VfPETYNKeASLuZkR6OF4KvDauENdKagqZbTwFdzCYAEl+qK+g3eX/K+yspKWivhH
VaMnjVT1P4DB9BRr0FK3OkhY5z9tna6uChTZ+CBOlrn9ME70zF08sGsotR//nm2z
glOEG1ayb308jxXmtR18MFJSnj/8Xh3Lyau6X+nyneqrcgwBM2JjQ9imXc8MvFfU
8XWBJkrn6DMI1BCPeOwh
=Jcfo
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
