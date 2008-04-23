Date: Tue, 22 Apr 2008 18:04:18 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Message-ID: <20080423000418.GA7368@apoderado.ometepe.net>
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<560c7c9a0804210557v2c94a553w5a2c8dd2efb8eead@mail.gmail.com>
	<20080421203002.GA4490@apoderado.ometepe.net>
	<200804221601.57318.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <200804221601.57318.axel@open-mesh.net>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2008 at 04:01:57PM +0200, Axel Neumann wrote:
> Hi Jan,
>=20
> On Montag 21 April 2008, Jan Hetges wrote:
> > On Mon, Apr 21, 2008 at 02:57:44PM +0200, Benjamin Henrion wrote:
> > > On Mon, Apr 21, 2008 at 2:39 PM, Jan Hetges <tran@ms20.net> wrote:
> > > >  what i recognized lately, on two nodes (the ones with more than
> > > >  one bmx interface), show alternativeNextHops, which are *NO*
> > > >  alternative. It seems there gets some 'information' lost between
> > > >  the two IFs. I suppose that's a known issue ;-),=20
> It is NOT a known issue (at least not to me) and if its a bug it should b=
e fixed.
so, let's fix it then ;-)
> > > Can you describe a little more extensively your network configuration?
> > x.x.0.0/24---x.x.0.1/x.x.3.1---x.x.3.0/24---x.x.3.160/x.x.4.1---x.x.4.0=
/24
> One general questions: do all your interfaces operate on the same frequen=
cy?
no
> Then, I am unsure about the netmasks you are using. The above line I=20
> understand that you are using x.x.3.0/24 and x.x.4.0/24 netmasks.=20
sorry, the /24 only specifys the netrange for the ssid it belongs to=20
> Generally, It is strongly recommended to always use the same netmask=20
> on ALL batman interfaces !
i know, you helped me fixing that :-)
and if you look again into my previous mail, i also wrote:
batman network x.x.0.0/20.
so, ALL batman broadcasting to x.x.15.255,=20

> But according to the debug output there is a direct link to x.x.4.165/24=
=20
> (which I guess has broadcast address of x.x.4.255) and therefore the two=
=20
> interfaces should not see each other!!??
there are direct links always only in the according /24 netrange,
because they are on different channels/ssids, so .3.160 and .4.1 cannot
"see" each other.=20
Note, NO .4.x node cannot see ANY .3.x node, even if they
would be on the same channel/ssid!
>Can you verify that (note that the=20
> "ifconfig dev ip/netmask" command is buggy and does not always produce=20
> corresponding netmask and broadcast addresses and that the interfaces MUS=
T be=20
> configured appropriately before the daemon is started. !!!)
i recognized the buggy ifconfig and ALWAYS set netmask and broadcast
addresses.
>=20
> > .0.1/.3.1 is one node with two radios, and .3.160/.4.1 the other one.
> > and, .3.160/.4.1 lists .4.162 as alternativeNextHop to .3.128.
> > where .3.1 and .3.137 can see .3.128, but .4.162 can not.=20
>=20
> An alternativeNextHop to a specific node must not necessarily be a direct=
 neighbor of=20
> that node. For example in the following scenario:
claro
>=20
> A---B---D
> |       |
> +---E---+
>=20
> >From As' point of view B and E may both be potential next hops towards D=
=2E But only E=20
> can directly see D.
>=20
> Is it possible to generate (almost simultaneously) -cbd8 logs from the in=
volved=20
> nodes, especially 3.1, 3.160, 4.162, 3.128.=20
attached, note that .3.137 is down due to power issues, and the link
between .3.140 and .3.160 is not usable, but you should see the issue.
>=20
> > So, there is a=20
> > real alternativeNextHop to .3.128 ... .3.137, which is listed after .4.=
162
> > on .3.160/.4.1. I attach the output of bmxd -cbd8.
>=20
> The attached debug log shows:
> 172.19.3.128    wlan0:bmx       172.19.3.1  80 (  97  1:01:20:33 15813   =
 0 100 1012 =20
> 18   2      1 )    172.19.4.162  67    172.19.3.140   2=20
right, but it SHOULD show .3.137, and NOT .4.162 at all. The ONLY link
between .4.x and .3.x IS .4.1/.3.160 (that's the reason for having a
repeater there :)
>=20
> At least this line does not show 3.137 listed after .4.162 on .3.160/.4.1
> Has it been truncated ??
i don't think so, i'll make some more logs when .3.137 is back up
>=20
> Looking forward to solve this...

cheers

  --Jan


--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIDn0ClTtvZdk47D4RAorIAKCmxwRi5owC6ORUoStX1baxwFDW/ACeJCK9
+yoq5dg0CWlQOqyHaD7Hl3s=
=uwIk
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
