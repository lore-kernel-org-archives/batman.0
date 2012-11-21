Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 21 Nov 2012 22:21:23 +0100
Message-ID: <3122527.LRLpTyPT9y@sven-laptop.home.narfation.org>
In-Reply-To: <CALDpWg5_cWwXu3NxMcXcSnMc5PWk_qF2uder7HA=4+huiWY3Tg@mail.gmail.com>
References: <CALDpWg4kZSisvbA4DFdZSDgt0OzYgH8-dNDJE3HUm8xxeCPMeg@mail.gmail.com>
 <1920966.iU3YQxcXDK@sven-laptop.home.narfation.org>
 <CALDpWg5_cWwXu3NxMcXcSnMc5PWk_qF2uder7HA=4+huiWY3Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19339972.o82zUMH35o";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batman-adv: node socket communication
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
To: liu muye <lmy19901031@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart19339972.o82zUMH35o
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Wednesday 21 November 2012 16:08:37 liu muye wrote:
> Thank you so much for your suggestions. Yes, we are using batman-adv. The
> one running as a kernel module.
> Just a few quick follow up questions.
> 
> Our goal is to build an ad hoc mesh network. Each node may not have IP
> address. I can use batctl ping functionality to ping my peer with MAC
> address. Just wondering if I can send data packet to my peers with MAC
> address.

Of course. This is the raw socket stuff I've mentioned before. Just bind a raw
socket to your bat0 device and sent ethernet frames between your nodes (mac
address as source/destionation). An easy example is rawsend [1].

But it is propably easier to use an actual transport protocol for communication.

> I have noticed the packet.h file in the batctl source code contains several
> C structures. One of  them is
> 
> struct batadv_unicast_packet {
>     struct batadv_header header;
>     uint8_t  ttvn; /* destination translation table version number */
>     uint8_t  dest[ETH_ALEN];
> } __packed;
> 
> To send my data packet, I have to use this C structure. Is that correct?
> and where to look up the value for ttvn?

No, this is internal stuff used for the tunneling. Don't try to create packets
from userspace with this format as you would have to implement a complete
batman-adv replacement. And you still would have to create a valid ethernet
packet followed by the unicast header anyway. So better use raw sockets
when you just want to sent ethernet frames between bat0 devices of different
nodes.

Kind regards,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/20111206/52f060cb/attachment.c
    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-December/005865.html


--nextPart19339972.o82zUMH35o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQrUXTAAoJEF2HCgfBJntGDvcP/1xt4jUkLCvMPAyaQCM32Dlt
oL9PJKGjoZEdKcOsShtroD64WTvoO73Tltm8VxZqs+gvWdncceSPeGZIscOD9uUO
sKiz65KDmofV1oeEMfeQpu7HmSsWhel+PyqsKy6RPimd6mSwTq3C2NItzxDrDisG
VAoaElZh/s9gIvxUaIrAer/zLdGtbzOsmGLLQGgg/Ux3XD5U6Cvc/NgVw/odo4qK
mHM8A2ocBUU+p5K6+4qz6siMpcX5Y43lALfcn9/pp9JmEmWzKX1myuzX3tShZLw3
riC7uMWnFOw27//eGO+xYzGZIYgL5Dxp8LGeAzHxDQSKJdcHZNKJ0HJpexbDtttK
R19NWjoENS65fcM30PElyRisnkw+KLl1f9wxdlB7NAOLaSXDU/OeoVKxPjRm/OkO
Y9TmhjEDurkhVmjf42eAzrHfzq3+6Ix0SFlAgeTag6MUCYdyhUXAvVm1Ub0Ruewp
LMW7GZ8RcyAU6Etqi69KjWdA2+QTgH5Qs3gDsWLTdC4eiwXwqawRtFGU5yrFhaVL
+SjQ6jxuCu0zEVtvsvTNodNrauFkf1NXQVDjjnuhccMdexkx0b7GxWb5GLQ3IjKe
IqOv+3ii/ZohhcUWvhsFIKizObkBJWlFUqctaLmd9PHIs6KaH4Ba9rnrBNuQBH+L
CrrhYYlXJIhp0sXTVE8D
=CuZF
-----END PGP SIGNATURE-----

--nextPart19339972.o82zUMH35o--

