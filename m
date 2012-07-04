Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 4 Jul 2012 15:49:57 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120704134957.GA10222@pandem0nium>
References: <CAHD-aqKoP3NDSWNHv=vOUCF_ANTRkVWGyXq-v=WC8iRPHJkdhQ@mail.gmail.com>
	<20120704091225.GA10142@pandem0nium>
	<CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <CAHD-aqKo=uzeu6_oc4BXj2WRWObMADyWCHp0sNFn8cJDX8sdjA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] BLAII + gw_mode, DHCP sometimes gets dropped
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 04, 2012 at 09:43:13AM -0300, Guido Iribarren wrote:
> On Wed, Jul 4, 2012 at 6:12 AM, Simon Wunderlich
> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> > Hello Guido,
> >
> > On Tue, Jul 03, 2012 at 05:07:17PM -0300, Guido Iribarren wrote:
> >> Hello there again,
> >> I have observed a problem since updating to 2012.2 and enabled BLAII
> >>
> >> I'm compiling logs to understand what's happening, but as always,
> >> reading logs only gets me more lost :(
> >> So here i am again begging for help
> >
> > There are some debug levels for BLA as well, and you can now get the
> > claimlist with batctl (which is basically the list of clients a gateway
> > feels responsible for) - this may help for debugging. But first,
> > we should clarify some more details for your setup.
> Yes, I've seen the cl command, but didn't completely understand how to
> interpret it. For example, right now I see the clients claimed in the
> cl of mesh nodes, and even the same client claimed in different nodes.
>=20

> ( when I say mesh nodes, and in the rest of the email, i'm referring
> to http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-II#Defi=
nitions
> )
>=20
> i.e. sample mesh-nodes:
> root@charly:~# batctl cl
> Claims announced for the mesh bat0 (orig            charly, group id 6412)
>    Client               VID      Originator        [o] (CRC )
>  * 00:25:d3:f5:93:76 on    -1 by            charly [x] (77f9)
>  * f8d1113b6e66_eth0 on    -1 by            charly [x] (77f9)
>=20
> root@hquilla:~# batctl cl
> Claims announced for the mesh bat0 (orig           hquilla, group id 82cb)
>    Client               VID      Originator        [o] (CRC )
>  * 00:25:d3:f5:93:76 on    -1 by           hquilla [x] (c72e)
>  * 00:24:81:4b:ea:6d on    -1 by           hquilla [x] (c72e)
>=20
> maybe that's fine because they have different group ids? (??)

Yup. They are not interconnected via Ethernet, so they are in different
backbones and have a different group id.

If there are other gatways on the backbone with claims, you should see them
in the claim list as well.

> is there any documentation on the cl output?

Yup, you can find it here:

http://www.open-mesh.org/wiki/batman-adv/Understand-your-batman-adv-network

> as far i could interpret, CRC "identifies" a particular version of a tabl=
e,

yup.

> [o] =3D [x] means "this is claimed by myself"

yup.

> group id identifies different backbones (like in this case:)
> http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance-Testcases#=
Two-LANs-connected-by-one-mesh
>=20

yup.

> and VID, is always set to -1 :P
> oh, maaaaybe it's vlan id (?) since i'm not using VLANs

it means you have no VLAN here.

>=20
> >>
> >> the setup is the same I described in yesterday's attachment, but
> >> what's not pictured is an ethernet cable between colmena-casa and
> >> f8d11504758.
> >> f8d11504758 is the only router that connects to the internet (through
> >> WAN cable), and it's also the only one that has dnsmasq running and
> >> gw_mode=3Dserver.
> >> All the other nodes have gw_mode=3Dclient
> >>
> >> All of the nodes have bridge_loop_avoidance=3D1
> >> (even though there are no other utp connections, so it could in fact
> >> be enabled only on colmena-casa and f8d11504758)
> >>
> >> with this setup, dhcp requests from the mesh sometimes get "lost",
> >> either they don't reach f8d11504758 or the reply doesn't get out
> >
> > Questions:
> >  * which node runs the DHCP server? colmena-casa, f8d11504758 or someth=
ing else?
> Only the node f8d11504758 runs a DHCP server (dnsmasq) on its interface b=
r-lan
> no other dhcp server is running on the network
>=20

OK.

> >  * at which point is DHCP getting lost? is the DISCOVER/REQUEST from th=
e client
> >    getting lost, or the reply from the server?
>=20
> Well, I just managed to get a clarifying tcpdump!
> hquilla sent a select (REQUEST) that reached the wlan0-2 (mesh)
> interface of f8d11504758 and it was silently dropped (didn't appear on
> a batctl td of bat0)
> this repeated several times, until a lucky REQUEST managed to pass
> through, was sniffed at bat0, and got a reply from dnsmasq
>=20
> I couldn't see any difference between the unlucky and lucky REQUESTs
> or DISCOVERs,
> but running a "batctl cl -w1" did the trick:
> when the client is currently claimed by f8d11504758 as in
>  *      hquilla_eth0 on    -1 by      f8d11504758 [x] (d38b)
>=20
> both the REQUESTs and DISCOVERs reach dnsmasq fine
>=20
> but if the client is currently claimed by colmena-casa as in
>  *      hquilla_eth0 on    -1 by      colmena-casa [ ] (3d7f)
> these discover/requests get dropped by batman when they arrive through wl=
an0-2
>=20

Ah, this helps. If the client is claimed by colmena-case, the request
should go from hquilla to colmena-casa via mesh, and from colmena-casa to
f8d11504758 via LAN.=20

I guess the problem is the interaction between BLA and the gateway feature.=
 The DHCP
request is sent via unicast to f8d11504758, but the destination address is =
still
broadcast. The bla implementation in f8d11504758 will then think that colme=
na-casa=20
also has received the broadcast (but it didn't), and therefore drop it.

I'll send a patch for that soon ...

> >
> > So DHCP is only having problems when gw-mode is turned on colmena-casa
> > and f8d11504758?
>=20
> gw-mode is activated in all mesh nodes, not only in colmena-casa and
> f8d11504758
> it's set to client on every node except f8d11504758, which has gw_mode=3D=
server
>=20
> As far as i can recall, disabling gw_mode=3Dclient in every mesh node,
> solved the problem.
> But now that i found out about this "batctl td" thing, i'm in doubt
> about the validity of the previous statement :(
> i should check again and report.
>=20

That would at least match to the hypothesis. :)

[removed the rest of the text. will send the patch soon ...]

Cheers,
	Simon

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk/0SgUACgkQrzg/fFk7axZeWQCgk63bBkJES868GmsVjmKRAZZw
EhcAn0WJ99WzF+zJTEJYWUxJjebq5uDh
=rmTN
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
