Return-Path: <ordex@autistici.org>
Date: Thu, 29 Nov 2012 00:56:20 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20121128235620.GG32479@ritirata.org>
References: <CALDpWg5UxkqP2_f-waB===fDPHg6vC0xf8=oxVx7aH5XvXd6uQ@mail.gmail.com>
 <CALDpWg7F3MNsy5gtcP=pcd0R_tFUmCTsyZ-K9bYMnCf0-YmArQ@mail.gmail.com>
 <CALDpWg6BczTcB3g=njyTfTHGuuKODB8AkxrLguOyH8Y3nMB5yA@mail.gmail.com>
 <CALDpWg7qErZ=kEp8hE__tYw0oWpfLVrR2V_c3hCQ3wx33oaE1w@mail.gmail.com>
 <CALDpWg6aGx+6eKwhbYUaNKeaMhiwPUWwgKVj7Smw6+9HrmZ1gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <CALDpWg6aGx+6eKwhbYUaNKeaMhiwPUWwgKVj7Smw6+9HrmZ1gA@mail.gmail.com>
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


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

if your destination node has some clients or bat0 is bridged, yes (this is =
the
common case).

Otherwise you can look into the global translation table and get the only M=
AC
address corresponding to that node.


Cheers,

On Wed, Nov 28, 2012 at 06:48:55PM -0500, liu muye wrote:
> So, if I understood correctly. The best way to do is to run command
> "ifconfig bat0" on both sides and fill in the HWAddr info accordingly.
>=20
> Thanks
>=20
> On Wed, Nov 28, 2012 at 6:29 PM, liu muye <lmy19901031@gmail.com> wrote:
> > OK, Thanks for the clarification. Just wonder if there is any way to
> > get the MAC address of bat0 on other end.
> >
> > For example: I got node A and node C. I want to send data packet from
> > node A to node C. The MAC address of bat0 in nodeA is the source. Just
> > wandering if there is a way to get the MAC address of bat0 in node C
> > without physically show up in front of node C and run these commands.
> >
> > Thank you so much
> >
> >
> >
> > On Wed, Nov 28, 2012 at 6:09 PM, liu muye <lmy19901031@gmail.com> wrote:
> >> Besides, when do batctl ping. I am using the MAC address of ah0. I can
> >> ping other node.
> >> If the MAC address is wrong, I think I cannot even ping another node,
> >> or traceroute to another node.
> >>
> >> Thanks
> >>
> >> On Wed, Nov 28, 2012 at 6:02 PM, liu muye <lmy19901031@gmail.com> wrot=
e:
> >>> One follow up question:
> >>>
> >>> When I do batctl o. It shows the MAC address of my network interface.
> >>> In my case, is ah0.
> >>> Not sure what to do in order to show the MAC address of the bat0.
> >>>
> >>> Thanks
> >>> Muye Liu
> >>>
> >>> On Tue, Nov 27, 2012 at 11:15 PM, liu muye <lmy19901031@gmail.com> wr=
ote:
> >>>> Hello:
> >>>>
> >>>> This is Muye again. I have encountered another problem recently when=
 I
> >>>> am using B.A.T.M.A.N to do the socket programming.
> >>>>
> >>>> Currently, I have three nodes. Namely, node A, node B, and node C. T=
he
> >>>> testing environment is a hall way in our department.
> >>>>
> >>>> I put node A in one end of the hall way, node C in another end of the
> >>>> hall way. Node B is in the middle of the hall way.
> >>>>
> >>>> I can ping node C from node A and vice versa. In node A, I can
> >>>> traceroute to node C. The traceroute shows it needs to go through no=
de
> >>>> B.
> >>>>
> >>>> However, when I send packet from node A to node C. Node C does not
> >>>> receive anything. But if I send packet from node A to node B, node B
> >>>> can receive that packet.
> >>>> Not sure what happened.  The link shown below is the program I used =
to
> >>>> send packet. Both source and destination are MAC address.
> >>>>
> >>>> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/201112=
06/52f060cb/attachment.c
> >>>>
> >>>> I greatly appreciate any suggestion, comment, and help.
> >>>>
> >>>> Thanks

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlC2pKQACgkQpGgxIkP9cwe7DwCdEO4TvzAGcAXo8M7h1K+bfEX7
F34AnRT/qanVOJ4qdEMSt0hl50gM/C5O
=7HPP
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
