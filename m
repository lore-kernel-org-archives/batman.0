Return-Path: <ordex@autistici.org>
Date: Thu, 29 Nov 2012 00:35:06 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121128233506.GF32479@ritirata.org>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg7F3MNsy5gtcP=pcd0R_tFUmCTsyZ-K9bYMnCf0-YmArQ@mail.gmail.com>
 <CALDpWg6BczTcB3g=njyTfTHGuuKODB8AkxrLguOyH8Y3nMB5yA@mail.gmail.com>
 <CALDpWg7qErZ=kEp8hE__tYw0oWpfLVrR2V_c3hCQ3wx33oaE1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <CALDpWg7qErZ=kEp8hE__tYw0oWpfLVrR2V_c3hCQ3wx33oaE1w@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv: Raw Socket Communication
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


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2012 at 06:29:56PM -0500, liu muye wrote:
> OK, Thanks for the clarification. Just wonder if there is any way to
> get the MAC address of bat0 on other end.
>=20
> For example: I got node A and node C. I want to send data packet from
> node A to node C. The MAC address of bat0 in nodeA is the source. Just
> wandering if there is a way to get the MAC address of bat0 in node C
> without physically show up in front of node C and run these commands.

You can have a look at the global translation table.

As described on our wiki[1], there you find all the
_clients_ announced by each node in the network. The problem is that if a n=
ode
has other clients connected to the mesh through a bridge, than you will see
many entries corresponding to the same node and you will not be able to
distinguish bat0's macc address from other clients.

Cheers,

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Understand-your-batma=
n-adv-network#translation-tables

>=20
> Thank you so much
>=20
>=20
>=20
> On Wed, Nov 28, 2012 at 6:09 PM, liu muye <lmy19901031@gmail.com> wrote:
> > Besides, when do batctl ping. I am using the MAC address of ah0. I can
> > ping other node.
> > If the MAC address is wrong, I think I cannot even ping another node,
> > or traceroute to another node.
> >
> > Thanks
> >
> > On Wed, Nov 28, 2012 at 6:02 PM, liu muye <lmy19901031@gmail.com> wrote:
> >> One follow up question:
> >>
> >> When I do batctl o. It shows the MAC address of my network interface.
> >> In my case, is ah0.
> >> Not sure what to do in order to show the MAC address of the bat0.
> >>
> >> Thanks
> >> Muye Liu
> >>
> >> On Tue, Nov 27, 2012 at 11:15 PM, liu muye <lmy19901031@gmail.com> wro=
te:
> >>> Hello:
> >>>
> >>> This is Muye again. I have encountered another problem recently when I
> >>> am using B.A.T.M.A.N to do the socket programming.
> >>>
> >>> Currently, I have three nodes. Namely, node A, node B, and node C. The
> >>> testing environment is a hall way in our department.
> >>>
> >>> I put node A in one end of the hall way, node C in another end of the
> >>> hall way. Node B is in the middle of the hall way.
> >>>
> >>> I can ping node C from node A and vice versa. In node A, I can
> >>> traceroute to node C. The traceroute shows it needs to go through node
> >>> B.
> >>>
> >>> However, when I send packet from node A to node C. Node C does not
> >>> receive anything. But if I send packet from node A to node B, node B
> >>> can receive that packet.
> >>> Not sure what happened.  The link shown below is the program I used to
> >>> send packet. Both source and destination are MAC address.
> >>>
> >>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/2011120=
6/52f060cb/attachment.c
> >>>
> >>> I greatly appreciate any suggestion, comment, and help.
> >>>
> >>> Thanks

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlC2n6oACgkQpGgxIkP9cweyKwCglk8GrKQcNbuJJusUXQeySDN0
+eQAn1UrWANOSw6dD+QSACu5ZossAj4E
=K+X8
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
