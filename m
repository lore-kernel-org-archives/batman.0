Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Fri, 2 Apr 2010 14:27:02 +0200
References: <201004020054.08840.clemens-john@gmx.de>
	<201004021217.05045.clemens-john@gmx.de>
	<20100402115032.GA4984@Linus-Debian>
In-Reply-To: <20100402115032.GA4984@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2057487.X6bv7gkHTG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004021427.08585.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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

--nextPart2057487.X6bv7gkHTG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 02 April 2010 13:50:32 Linus L=FCssing wrote:
> > I use Fonera and Dlink Dir300 wich have a atheros chip inside.
>=20
> Ah, great, those Dlink routers are the ones I'm using here too :).

hehe

> > Yes the vpn network is created over lan.
> > The VPN is created by an central openvpn server in tap mode and ping
> > inside the vpn works without batman.
> > The VPN is used to connect several mesh clouds which can=B4t sea each o=
ther
> > wireless.
> > Ping from one Mesh device to another meshdevice on the other side of the
> > vpn tunnel works. I think because they are both in the 10.18.1.0/24
> > network.
> >=20
> > But the devices which are connected to the vpn network have a ip from
> > 10.18.0.0/24 and should also be reachable from the 10.18.1.0/24 (wlan)
> > network and this doesnt work so far.
>=20
> Yes, you're right, if a host has a /24 subnet and wants to be able
> to reach another host on a different /24 subnet, then they need an
> extra (default) route entry in their routing table. In your setup,
> why aren't you just using a /16 subnet instead if you want them to
> reach each other over direct links without any routing?

I don=B4t exactly know why we are using different subnets, because I=B4m no=
t verry=20
familiar with networks.
But I think it is, because we have different projects in our network with=20
different vpn/24 subnets and wlan/24 subnets which should all be able to be=
=20
connected to a bigger network.
Olsr did this routing entrys by default I think. What can I do to make batm=
an=20
do this automatically too or is this just completely the wrong way?

How are you doing this and how is this done in other networks?

> > I can ping the mac adresses inside the vpn from the wlan network with
> > batctl but not with normal ipv4 ping.
> >=20
> > > From the configuration now, it looks like you're having another
> > > batman-adv on the other side of the vpn as you've assigned tap0 to
> > > batman. So keep in mind that the recipient on the other side of the
> > > tunnel will get batman-adv ethernet frames only which encapsulate the
> > > payload - there has to be a batman-adv on the other side to unwrap the
> > > IP packets again.
> > > And if there is a batman-adv on the other side of the tunnel, make
> > > sure the vpn itself is transporting whole ethernet frames and not
> > > only ip packets (in tinc this is "switched" mode for instance or
> > > in OpenVPN having "dev tap" and not "dev tun").
> >=20
> > Yes the setup is like you describe it.
>=20
> Ups, ok, sooo, you want the complex stuff :)? Just want to note,
> that this has not extensively been tested yet, I had just tried it
> here with a friend and this test for one tunnel worked unexpectetly
> good. However, we don't know yet if there might occure some
> undesired things in larger scales. But if you are up to an
> adventure and want to share your experiences with this, great :).
>=20
> I think I'll better write a little description and article in our
> wiki about how our test setup looks like as there seem to be some more
> people getting interested in it.

It would be great if you would send me the link when the article is ready.

> And I also want to point out, that establishing such vpn inter
> cloud links with the routers themselves has the following
> downside: With tinc + those DIR300 routers, we measured a maximum
> total throughput of 300kB/s which might be or might not be what
> you are looking for. This is because VPN software is copying the
> data from kernel to userspace and back a couple of times. Haven't
> measured anything with OpenVPN though, but as far as I know they
> are also doing this copying (there is no kernel module for OpenVPN
> afaik).
>=20
> Cheers, Linus

Tanks, Floh1111

--nextPart2057487.X6bv7gkHTG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAku14pcACgkQZgdHbA22lqN/bwCfSI1cAaeOFi9mx2h9/EtQYejn
hGgAn2S2YRShflHJw/7Z9PNmXcv//Q5I
=/rWz
-----END PGP SIGNATURE-----

--nextPart2057487.X6bv7gkHTG--
