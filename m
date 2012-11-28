Return-Path: <ordex@autistici.org>
Date: Thu, 29 Nov 2012 00:18:24 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121128231824.GE32479@ritirata.org>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg7F3MNsy5gtcP=pcd0R_tFUmCTsyZ-K9bYMnCf0-YmArQ@mail.gmail.com>
 <CALDpWg6BczTcB3g=njyTfTHGuuKODB8AkxrLguOyH8Y3nMB5yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <CALDpWg6BczTcB3g=njyTfTHGuuKODB8AkxrLguOyH8Y3nMB5yA@mail.gmail.com>
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


--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Something is not correct in your reasoning:

batctl ping/traceroute is a debug mechanism in which you make two _nodes_
communicate with each other, therefore here you use the node identifier whi=
ch is
the MAC address that you can also read in batctl o output.

When you want to send _payload data_ over bat0 (and this is what your progr=
am is
trying to do), then you are acting as _client_
and your source mac address is not your ah0's address anymore but it is the=
 one
associated to your bat0. To see it just run "ifconfig bat0" and and look at=
 the
HWAddr info.

Cheers,

On Wed, Nov 28, 2012 at 06:09:48PM -0500, liu muye wrote:
> Besides, when do batctl ping. I am using the MAC address of ah0. I can
> ping other node.
> If the MAC address is wrong, I think I cannot even ping another node,
> or traceroute to another node.
>=20
> Thanks
>=20
> On Wed, Nov 28, 2012 at 6:02 PM, liu muye <lmy19901031@gmail.com> wrote:
> > One follow up question:
> >
> > When I do batctl o. It shows the MAC address of my network interface.
> > In my case, is ah0.
> > Not sure what to do in order to show the MAC address of the bat0.
> >
> > Thanks
> > Muye Liu
> >
> > On Tue, Nov 27, 2012 at 11:15 PM, liu muye <lmy19901031@gmail.com> wrot=
e:
> >> Hello:
> >>
> >> This is Muye again. I have encountered another problem recently when I
> >> am using B.A.T.M.A.N to do the socket programming.
> >>
> >> Currently, I have three nodes. Namely, node A, node B, and node C. The
> >> testing environment is a hall way in our department.
> >>
> >> I put node A in one end of the hall way, node C in another end of the
> >> hall way. Node B is in the middle of the hall way.
> >>
> >> I can ping node C from node A and vice versa. In node A, I can
> >> traceroute to node C. The traceroute shows it needs to go through node
> >> B.
> >>
> >> However, when I send packet from node A to node C. Node C does not
> >> receive anything. But if I send packet from node A to node B, node B
> >> can receive that packet.
> >> Not sure what happened.  The link shown below is the program I used to
> >> send packet. Both source and destination are MAC address.
> >>
> >> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/20111206=
/52f060cb/attachment.c
> >>
> >> I greatly appreciate any suggestion, comment, and help.
> >>
> >> Thanks

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlC2m8AACgkQpGgxIkP9cwfEhQCeIAeiZqZ/YvhCLhfEkUj4Zu+0
cj0An0M1xXoF0UwK7dSx5oHDCQ5Z8T3r
=31Iw
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
