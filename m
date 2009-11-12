Return-Path: <linus.luessing@web.de>
Date: Thu, 12 Nov 2009 01:51:49 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091112005149.GA2879@Linus-Debian>
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <200911101834.41970.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > The motivation of using a higher MTU of 1524 at the beginning was
> > the rumour, that there might be some client devices (which we
> > would get into the network by bridging bat0 wifi wlan0 for
> > instance) not able to handle any MTU smaller than 1500. But in
> > fact it turned out, that in our days basically all devices are
> > able to do both IPv4 and IPv6 PMTU discovery on layer 3. So tests
> > showed, that if all BATMAN nodes are using an MTU of 1476 on bat0
> > (or the overlaying bridge) everything seems to work fine.
>=20
> Sorry, I can't follow you here. If the whole network is a switch environm=
ent=20
> how could the clients perform a working PMTU ? Sure, all clients are able=
 to=20
> do PMTU (I don't think somebody doubted that) but it won't work.  :)
> Client sends 1500 bytes -> router receives the frame (no IP!) and drops t=
he=20
> packet. Where should the "fragmentation needed" packet come from ? That o=
nly=20
> works if you route packets instead of switching them.
Ah, wait, I forgot one thing: It worked for our hotspots because
the coovachili internet gateway had an MTU equal to the PMTU all
the way through the mesh. But you are right, we are probably
having some trouble when having too mesh clients which are bridged
to each other and have an MTU set to 1500...

I'm wondering what you think of how tinc is handling this at the
moment in switch mode: It just "fakes" an ICMPv4/6 message with
the address of the destination if such a hop is getting an
IP-packet bigger than the link MTU. This might sound like a good
idea at first sight, but the disadvantage is, that you're getting
trouble in IPSec-only networks (which are quite rare at the
moment, yes :) ).

>=20
> > Usually you are choosing UDP mode in tinc, any ethernet frame inside of=
 this
> > will then be encapsulated in this. But if tinc discovers, that the pack=
et
> > will be too big to fit through this link and the PMTU tinc discovered f=
or it,
> > it will do TCP encapsulation instead to let the kernel fragment the pac=
ket
> > automatically.
>=20
> That is nice but only works because tinc uses IP addresses (unlike batman-
> adv). AFAIK you use tinc to connect internet endpoints, hence your packet=
=20
> probably looks like this:=20
> [ETHER][IP][UDP/TCP][BATMAN-HDR][PAYLOAD]
> whereas the packets sent by batman-adv look like this:
> [ETHER][BATMAN-HDR][PAYLOAD]
Nope, tinc is able to create a TUN (router mode) and TAP (switch
mode) network adapter, so it is able to actually transport the
original ethernet frame as well:
[ETHER][IP][UDP/TCP][ETHER][BATMAN-HDR][PAYLOAD]

> > As in a mesh network usually not an internet uplink but the wifi
> > is very likely being the bottleneck, the extra overhead on the
> > internet uplinks created by fragmentation might not be "harmful"
> > for the network average bandwidth. And as also the packet loss on
> > an internet uplink not running on its bandwidth limit is very,
> > very low, latencies shouldn't increase too much.
>=20
> I think you underestimate the performance impact. AFAIK IPv6 does not sup=
port=20
> the clasical IPv4 fragmentation anymore (intermediate routers won't fragm=
ent=20
> the packets but drop them).
Hmm, yes, true, IPv6 does not support fragmentation at all... so
this would/might just work over the crappy IPv4 at all and is not
only but also just a workaround to quickly squeeze some fragmented
packets over the ipv4 internet.

I also somehow liked Andrew's suggestion about header compression
with segmentation as a fallback mechanism. If this segmentation
would occure in rare situations only and transparent for the upper
layers, well, why not :).


Cheers, Linus

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJK+1wlAAoJEBKw7u43QNpfsBsQALOEitUoKo3n7zR6V1Xy1fqE
hZhse05Ad92qbQVySF1VpFQRbxjIbwHDFjO8u3+WygVrxZOwVsKslHl6yz8ckxyL
lR71Y2w7HwPrPKtPLoCJOsAyYnHJs5AM2PknSCUfw3CDE5KSxMf0rnFYflgKmjeW
I+PHK48KEQYJaKHzdT10Ehurg+u6tQCwhspsNifLxr/ikKXq6GrNZ0uH9ya1uBuZ
MVUbFggkyNDuZg7Tzo9piunuFbgafNdnfl7/ns6ePHjforzpHuu0r33Dtb+LjbvW
XsvG8boksH5Zme8x0VAdSmzjNhvziZfgqhd8CCQHHvdsXzZa5EtEyVnmtaSMmy/r
vqvI0coSnft8nqQhQU+lmtlEuuvBoLiyzyrJ/M97knuc8QKdaor0w1SL4z5L8bNo
3J7pmwt/ViTlYJs4WnMf581LNzhXYrI1UI1RLvsn2ycawB2lcQwbyS0JYu7As+Fa
QxKmBDMHvpYvjrCYa3TUl4hjz7fRIFjaCgh/7yj9zB7S4Pt0NY143Jg2OFzJpO4w
g0yEe7HocdYT9qv+l4nRM/n0G6Wrj9q6FyMGQC01qnrySWNRDP895vXonyYRsfbu
HjwVB1Ox4PxnzJBBYXcJsRr2Bm6VUUehARAQ1/9ahuT7haI8QpcAFarIDGuBZfXS
WxdGEDEI6i+ZMSj/5xLo
=Qeo3
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
