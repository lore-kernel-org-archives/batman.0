Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Oct 2018 16:26:49 +0200
Message-ID: <3126005.3y7xrHjZEe@prime>
In-Reply-To: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3804838.mmorxGNhlB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] broadcast storms
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

--nextPart3804838.mmorxGNhlB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Jake,

could you make some pcap dumps on the wlan device where batman runs, and 
provide that to us? Just the the full tcpdump (tcpdump -s 2000 -w /tmp/my.pcap 
wlan0, assuming that wlan0 is your interface), not batctl dump? Then we can 
check sequence numbers etc in wireshark.

Do you have some of your mesh nodes connected and bridged to Ethernet? If yes, 
you should check the bridge loop avoidance which could also be causing this 
effect, if you don't have it enabled and use such a topology:

https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-II

Cheers,
     Simon

On Monday, October 22, 2018 1:07:29 PM CEST Jake.Harris@zf.com wrote:
> I'm sure a similar question to this has been answered, but I am new to this
> mailing list format and don't know an efficient way to search
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/
> 
> I'm having problems with broadcast messages effectively echoing around the
> network of 50ish nodes. I attached a few seconds of the batctl tcpdump
> output. I can't seem to find a pattern to what causes this, it tends to
> happen once every two or three weeks, the storm causes problems with the
> batman program where during the storm nodes drop all their neighbors
> (batctl n shows an empty list) indefinitely, which I have worked around
> that issue via a batch script that reloads batman if the neighbor list is
> empty. Reloading successfully reconnects to the network but the storm still
> persists.
> 
> The only way I've found to fix this is to reboot all the nodes at the same
> time such that the whole network is down to kill the echos.
> 
> I believe I had this problem much more frequently (every 4 days or so) a
> while ago on the same network when using discrete tcp destinations for the
> nodes to communicate, the storm frequency was reduced to what it is now by
> using broadcast packets and reducing the communication rate from 12 seconds
> to once every 40 seconds.
> 
> Rebooting the nodes that are responsible for the echoing messages has no
> effect, I rebooted 192.168.1.230 before running tcpdump that is attached
> and as it shows packets from 230 continued to bounce around while the node
> was powered off and after it rejoined the network. It doesn't appear
> broadcast uses a time-to-live parameter to limit the hops the packets will
> make.
> 
> I'm at a loss for a way to remedy this, there seems to only be multicast
> optimizations.


--nextPart3804838.mmorxGNhlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvN3ikACgkQoSvjmEKS
nqHBFhAAzmCjEDK/TiMS9GwwiXiB1fpZo7ZDpNQhUYafz1AJfBOLAYkQDDjPXgAx
0uL4dnPFUEDsKsFKq66PHsS5Bt52VaufsDOQaMBkaS9d5eGf7fzJpymxd544efo9
XKRsjRG4N2iKIgu+3LLm8CPXNxKvsdyP48vkotdeCRQE4Kmnqra4UrZkLC0ax1IT
2/Jf8gKOy/AneCeRLGPULxXDhTw8VgB28uB+m/7jaZLV9Sa0jwKaQyMN7oVoxw8K
jybQUCY4TbkwG4svCyiK+30f8VTHKbB0QzFxAQiQlQRLMaLPt8slxJny5LItMKJB
QvTBy9TG0uHfx48xWZOduAxR9VgPXikcIG6JkHUT2vheDCfj9BJQWKY48VtAXk/Z
+FzEwvZlJOdT6XbDMgbeFjXga8D1GhMENmdcbVYqmTejIgISNOBk47rHV0vPXTmk
EpsKCZ2wXVsiTcahC1Ym3RzVLW0f5Wbk/bPbPwMaZfni2K/M8X+XKDYheEYONdRv
zjWuZo+mPm2psdw6/pD+9WNMZERN6DtrOCoEFo26outPdqLpZiWP5bKYsGmPSGqr
PbbRJiBrP369HaK4Nf5qM2Z8p/edkqoG19A9uz+aRKMcKWdZd6j3Wd6ZuSkw6bQZ
XbIqwT8PLwBM5qKXF7Whl0Bl3UoMkIw7S9HXoZ9+qrNvQPbmiTQ=
=rJUN
-----END PGP SIGNATURE-----

--nextPart3804838.mmorxGNhlB--

