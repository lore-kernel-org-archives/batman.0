Return-Path: <linus.luessing@web.de>
Date: Fri, 11 Dec 2009 14:33:54 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091211133353.GA2708@Linus-Debian>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
	<20091209063411.GJ29768@lunn.ch>
	<618743.16485.qm@web111609.mail.gq1.yahoo.com>
	<200912092142.07700.onelektra@gmx.net>
	<375210.41936.qm@web111602.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <375210.41936.qm@web111602.mail.gq1.yahoo.com>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer only
 mesh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi George,

if you are really talking about "and is simply a client talking to other cl=
ients" as you said before, then IPv6 autoconf is the way to go as Andrew me=
ntioned before.
> Are any freifunk networks purely peer-to-peer, without any "server" or "c=
ore" nodes ?
>=20
> That is, are any freifunk networks using ipv6 autoconf, or zeroconf ?
Here in L=C3=BCbeck we are currently experimenting with such an IPv6-mesh-o=
nly network. Because of BTM-Adv a completely adhoc ip-assignment is possibl=
e as long as your mac adresses in your network are unique (as they should b=
e). If it were just for communications inside of the mesh without any routi=
ng from this mesh to hosts outside of the mesh, you can even use the automa=
tically assigned link-local adresses - this is working out of the box in mo=
st current operating systems.

So basically our intention is to not have the mesh network as an uplink dir=
ectly to the internet but more as a dedicated metropolitan area network, a =
switched "LAN". In this MAN everyone shall be free to set up VPNs for their=
 internet gateway / to their home network. Of course this is a trade-off ab=
out usability on the other hand as setting up a VPN is not a trivial task f=
or "common" people... but don't know what your specific goal is. Could you =
expain your intention a little further maybe?

We were also running in some trouble with those link-local adresses, not al=
l applications seem to support this properly. Therefore we were assigning a=
dditional ipv6 unique local addresses with the help of radvd (and limited t=
his to the local wifi/ethernet clients on one router with the help of ebtab=
les). (this should also be possible with dhcpv6 instead of using radvd thou=
gh, I guess)


I'm not aware of any routing protocol supporting dynamic, decentral ipv4+6 =
internet gatewaying over a ipv6-only mesh network yet. Though there are dis=
cussions about how this could be achieved on the BATMAN-Adv side as well. I=
'm also curious about what the Berlin Freifunk guys are up to with NIIT, go=
tta have a look at the workshop/discussion during the 26c3. Has anyone hear=
d of IVI (or totd) yet? I think this should make routing packets between th=
e ipv4 and ipv6 stack possible.

Cheers, Linus

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLIkpBAAoJEBKw7u43QNpfwikP/007SOWA16vidYJUUpxCDjHM
2pKU2gesluND/vbfD7XGrPcMQPZsIY+MFi71L2xm+yfYOmvYASytTKXP8nmAP3PL
B5Gd52Qt5dDzDIsjH1iQJWsCMcv8H03Y/CpkDTAwafm6/+oChbPr+6E3NMb7F1Ge
GwPrTRyXVsEQhTl9EQygkWlvG1vmym5zBdATtG57Vw8D9CqCIDk7LIhISyqA9k96
vHW3s58bUYKGimjpgncSn35G+ByJsvO5rSrJr/zCNwTt7B9flCaNcfuW8F2Z71ee
XjOXJKGSK7jh/ZTEGqfQaXXN1u2/k0hZUezHGcphTKK9jAZgsut+8p9wWPv8auhk
T50HtOuSd/z7EXkdGBKTC9TR7CIWS58GPi8XK9reM/LLAjMkXSTtgTb5LiMCKn94
EHYuCyi+zFWolnwCRycemFXCHBEdilyzO5EuqDCvI0ihWVhDqqyD8Nf+8DQ4eqTY
unckZkaT2tawt1Gj8DjbxnkZcNuyzjU/yqw/Q16gM2RafEZwxThMee2mXmWHtFcW
HT2I4GyeKUrd4KQq/3QRpIrPna+/0bkmB6HrdpICg8/gz8BYq5HgK+ZkIcJ/izrs
iG2QDSJ9n1In9SQgEDSI5ezdeP6OteGjejR9WHjko8XlWUZMBdZAFW0iIi4dEKn5
M3A/iS8l5CZLiWqP1i65
=2Zcu
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
