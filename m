Return-Path: <linus.luessing@web.de>
Date: Mon, 9 Nov 2009 20:02:06 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20091109190206.GA2642@Linus-Debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Sender: linus.luessing@web.de
Subject: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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
To: B.A.T.M.A.N@lists.open-mesh.net


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thought it might be a good idea to continue the discussion about
MTU handling to a new thread on the mailinglist for sharing some
experiences we had with this here in L=C3=BCbeck already. Hope this is
fine with you guys :).

In our setup we first started with the default settings of using
wifi and ethernet links with the default MTU of 1500, ending up at
a MTU of 1476 on bat0. After discovering, that we could actually
increase the MTU on both the wifi and ethernet interfaces on our
Dlink DIR-300 routers running OpenWRT, we decided to give an MTU
of 1524 a try. In the beginning this was absolutely fine for our
test setups, as we had a quite homogeneous network. But as soon as
we were trying to connect some x86 desktop pcs running BATMAN-Adv
to the same network, things got quite complicated. Our experiences
were, that we are having 1GBit ethernet card in a laptop, that is
able to increase the MTU to 1524 on a recent 2.6.30 kernel. We
were trying about 5 random network cards we had available here in
our cellar and they all were not able to increase the MTU
(including my laptop's BCM5787M GB-ethernet card). So at the
moment I'm truely considering to also switch those Dlink routers
back to an MTU of 1500 for the sake of compatibility at least on
local area networks.

The motivation of using a higher MTU of 1524 at the beginning was
the rumour, that there might be some client devices (which we
would get into the network by bridging bat0 wifi wlan0 for
instance) not able to handle any MTU smaller than 1500. But in
fact it turned out, that in our days basically all devices are
able to do both IPv4 and IPv6 PMTU discovery on layer 3. So tests
showed, that if all BATMAN nodes are using an MTU of 1476 on bat0
(or the overlaying bridge) everything seems to work fine.

So now the question remains of what to do with links, where you
are only able to have links with an MTU of smaller than 1500?
Well, this usually is just the case when you are tunneling (over
the internet) where the standard MTU is mostly lower than 1500
because of the VPN overhead (+ pppoe). Luckily there might be a
nice workaround already: Since version 1.0.10 of the tinc VPN
daemon, which was released 3 weeks ago, it is handling packets
being too large for the PMTU (which tinc discovers on its own)
differently in switch mode (which is needed to transport
BATMAN-Adv ethernet frames). Usually you are choosing UDP mode
in tinc, any ethernet frame inside of this will then be
encapsulated in this. But if tinc discovers, that the packet will
be too big to fit through this link and the PMTU tinc discovered
for it, it will do TCP encapsulation instead to let the kernel
fragment the packet automatically.

As in a mesh network usually not an internet uplink but the wifi
is very likely being the bottleneck, the extra overhead on the
internet uplinks created by fragmentation might not be "harmful"
for the network average bandwidth. And as also the packet loss on
an internet uplink not running on its bandwidth limit is very,
very low, latencies shouldn't increase too much.

I'm going to test the usability of the current tinc version for
tranporting BATMAN-Adv packets soon, don't know if this "feature"
is working yet at all. But anyone else, please feel free to do
the same :).

Yes, and it would probably be nice to have "emergency"
fragmentation in BATMAN-Adv already, but as it had been mentioned
before, this is not trivial to implement. I also don't see a way
of how PMTU discovery might be done instead of fragmentation...
probably even tougher to do because of the dynamically changing
topology :).

Cheers, Linus

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJK+GcuAAoJEBKw7u43QNpf+EYP/ixvFoBVbxFIifOa5vwGfahl
g6wyuCuEvsK/r5zr5m9WIPXry5xWGUZ7JhOzcxEtgzSYeSHDa7nabpSO8fbYSUHw
2RVZgf6pUkfx+x67vTQbp+KLyaqWS0jjEHXST/bPwfarGINztyyK8KnUBDY4DVmP
EbAQirDXl+gmORkr8pFP7YUfqGtc2YVsxm6J+y7KwmfbqLv/2coSELjSkLLlIJ5m
7TDo91yHohw3BvZ7ZQCT/ivg5qPhdHbGxbbiLegHU8j5K98DxS6+ZtFzWFimJEST
Mx+JUNTDWf7oaj4X5sH1Q12gofU5alnRZGoJa8pKQAmuASRASkhVr3mUB9BLYMuz
rq5r22WqYZCo7VqViLbAghLZr+raZGK+Xg44RNS/XjaL2wjyHXXLdv3kQ/1O8eVv
cwcULwoJSdvHYKgs2elhITwptjEqGO8+ezFkgFJKjVCLF2Zn0u2e9GAUu0NYiY7x
JxefdDPefQ/Yzkmxtnldubo/VDjUFwnprNmBHEo7DEJfsrOtwKauxpno/sdoRT5b
udwrbuzZBWXjw3qLV/05fqH7Hl8OYitgM3WlySgkxIZlBDiHkbEX8Jlc4jjPvxKa
bYLx1LaGxDmLMi1ApqtaqlvAnQMP2BMgUrv8Oq3b/bjbihmt355x+McXUQ8G/yV5
RX3dS5VvjVseRwOAXPFK
=Crp5
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
