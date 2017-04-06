Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 06 Apr 2017 09:04:50 +0200
Message-ID: <1626579.VOjpoqf3Fa@prime>
In-Reply-To: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
References: <9309484e-a9c2-0476-3ddf-a2d68a51c58e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1646283.ZOM3cDqW7A";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [batman-adv] Does batman-adv works perfectly?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Xuebing Wang <xbing6@gmail.com>

--nextPart1646283.ZOM3cDqW7A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Xuebing,

it sounds like you have WiFi driver issues. There are some effects like key 
cache corruption, deafness, and other effects known for the AR93xx series. To 
confirm, you can try to use IPv6 link local ping (ping6 fe80:...%wlan0) to your 
neighbors. If you can ping but batman can't (e.g. use batctl) it's a batman 
issue. If both pings don't get through, it's most likely a WiFi driver issue. 
In this case, a master or something doesn't help. :)

Cheers,
     Simon

On Thursday, April 6, 2017 10:32:29 AM CEST Xuebing Wang wrote:
> Hi community,
> 
> We have batman-adv working on OpenWRT Chaos Calmer.
> - Atheros ar9331 MIPS platform + built-in ath9k WiFi
> - batman-adv version 2016.1
> - routing_algos = BATMAN_IV
> - Wireless interface MTU = 1532, adhoc network encryption "psk2-ccmp"
> - bat0 interface MTU = 1500
> 
> We have batman-adv running on 10+ sites. For each site, there are 10-20
> nodes in the mesh network.
> 
> batman-adv runs almost perfectly (*almost*). Occasionally (occurrence
> rate is low), node drops off the batman-adv / adhoc mesh.
> - Sometimes, node can recover (re-joins the mesh network automatically),
> but not always.
> 
> Any suggestions? Does batman-adv works perfectly in the field (i.e.
> running for 1 year with 100+ nodes without any issues)?
> 
> What about I use one node as Master, and other nodes ping this Master
> every 10s (or 30 seconds) (to keep mesh from inactivity)? Does this help?
> 
> Thanks.
> Xuebing Wang


--nextPart1646283.ZOM3cDqW7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAljl6JIACgkQoSvjmEKS
nqEMFQ/7BoDHCbqNsCqO7Fwn0QSIo/Apkk/BCzKwCKWhJy+IVt/+KswIe11kWWiT
EyMxoByyCZNctYg7JFMDIzl6RfX5JYzS1X/BIrEzztCt67Fr/GPV0MtmdvdIObhM
Sfmua0y+FeLMsPtjsYpWJdNth13LK9A28kLwShRHfbSJWEmdcdZaVhlHM7/a82Br
0N2D2TqTip4sDpctHAey4+irdFluoOT25haetyHBHalFej85JwXntUWykh/WTYI9
2r+cQI3YE5OwdCmzA9CkkC9Uu7xpDDBmz15ng5yyrEIHhtmEejmiHF/YGlIS9q1X
WprRLQiuAP+zEjetJp5xIn59/VcHKB45KOOlxv7K9VJUbHb6f6PVULdmapbtB4N4
OOaKmwg7AfMIH8zEgC2YTWqO0UXFSpzElB4KyY4pFP2/85+TRR7Mj80agftkHiKZ
nMrXfx3zSvylawqcc9sBfk+3JnGbWPY8JaXi2F+D96J7QgayNUQ3/HRBR02KS1Mr
MYL/pfK9LL1Rcwc2f66Q8qPJxAaqahR2F5laDcWORciWVgmk/7CWXrp78Xxt8R0N
GBEdqckFhFaIH9OXuqhKeLvVGvd7/3bzyprwU1XW+y13tgHVcmVAdYSierYWR3jX
K/f1RkoH8nwc9nQRA3A4ypU6uSPanyoiyt8UCQTrdKVRo+MnuH0=
=lRDP
-----END PGP SIGNATURE-----

--nextPart1646283.ZOM3cDqW7A--

