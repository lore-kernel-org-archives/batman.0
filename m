Return-Path: <are@lihas.de>
Date: Tue, 2 May 2017 13:35:02 +0200
From: Adrian Reyer <are@lihas.de>
Message-ID: <20170502113502.jjvlpqksmlhguxle@r2d3.s.lihas.de>
References: <1493216459.18414.3.camel@openmailbox.org>
 <1504855.vmUtePouqW@prime>
 <1493376248.28193.6.camel@openmailbox.org>
 <3080757.qWi1On8dnJ@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="on6epfasp3s4syxp"
Content-Disposition: inline
In-Reply-To: <3080757.qWi1On8dnJ@prime>
Subject: Re: [B.A.T.M.A.N.] how well does batman-adv scale
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


--on6epfasp3s4syxp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 02:23:16PM +0200, Simon Wunderlich wrote:
> On Friday, April 28, 2017 12:44:08 PM CEST fuumind wrote:
> > Ok, so clouds of a few hundred nodes would work reasonably well and at
> > the same time keep customization to a minimum.
> Yes
> > What makes OSPF a better candidate for interfacing between the clouds?
> > Does it keep a more limited routing table and thus minimize overhead
> > traffic? I haven't been able to figure it out good enough yet.
> Which technology is the best is beyond my knowledge.

We (Freifunk Stuttgart) use a setup similar to this.
A split in different Layer3 Routingdomains had been necessary, as the
batman-management traffic reached 1mbit/s at about 300 batman nodes.
Geographically we depend on vpn-links to servers for our network, so
we rarely have longer lines that could aggregate some information. The
local uplinks are often consumer internet lines als slow as 16mbit/s
down- and 1mbit/s upstream.
Our different batman-segments are distributed between several core
gateways. These gateway are linked together via a backbone vpn, no batman
there, just routing within that vpn.
Our first idea had been tinc vpn (meshing vpn) + OSPF, however, tinc
mesh and ospf don't play nice, we had a really unstable network. In my
eyes, ospf needs a stable network, some vpn between some internet
servers as a virtual switch is not good enough.
Atm we use tinc + tinc internal routing. This works well but is somewhat
unflexible when it comes to new networks.
In future we will try and convert to p2p vpn links (probably openvpn)
between the gateways and use bgp for the routing stuff.

Regards,
	Adrian
--=20
LiHAS - Adrian Reyer - Hessenwiesenstra=C3=9Fe 10 - D-70565 Stuttgart
Fon: +49 (7 11) 78 28 50 90 - Fax:  +49 (7 11) 78 28 50 91
Mail: lihas@lihas.de - Web: http://lihas.de
Linux, Netzwerke, Consulting & Support - USt-ID: DE 227 816 626 Stuttgart

--on6epfasp3s4syxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEoYEF06NCPUA1+BdmuHS31pP6XDYFAlkIbtwACgkQuHS31pP6
XDbhtwf/V2c3/4XdhKLxUdm4z3IKo2+OENo61KJ9mbSJYGGY4snSNNBMkRMrYmph
X4Sti+G+LIRF2g4L7gIwhCpQYbiSbBIgpvc9vZegsbbSRPmDh3P0p7pwtznEZtxH
beQbxUAl0VFiJslmeNm2CYth9lor3naYngtpQTz9gS4+wSA80ZPJeyaFWCp4rtvQ
QJKW/zM0ofxsX2IQ99hznWWZ2NGTJ72eAOxg1GK68okNDVjyL4QsF4iMQliNjCiK
wfQ+DEQC3ZwgjY6iESKBthVNKEZUyb5O6LWtIWEByPHd2T1h9WO+EIfPdAzHQSi9
KQFgZuY7kuIwPhW3hEB+MsqwYrvk7g==
=vPtt
-----END PGP SIGNATURE-----

--on6epfasp3s4syxp--
