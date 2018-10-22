Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 22 Oct 2018 20:17:18 +0200
Message-ID: <3795505.rC9BEUj0Hg@prime>
In-Reply-To: <B99A1AB9A294834C8DF94185A5E9D18101784D0848@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
 <3126005.3y7xrHjZEe@prime>
 <B99A1AB9A294834C8DF94185A5E9D18101784D0848@NRTV96002.america.zf-world.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2802252.tTjxyp59UE";
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
To: Jake.Harris@zf.com
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2802252.tTjxyp59UE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Jake,

I've checked your pcap files. I couldn't find a culprit directly, but it seems 
like you are having so many repetitions / the network is getting so overloaded 
that broadcasts stay in the queues of your WiFi driver for longer than 30 
seconds (possibly in different devices, accumulated). At this point, batman-
adv assumes that the device has rebooted and the sequence number is validly 
re-used, thus circumventing the broadcast duplicate check.

You could increase the define of BATADV_RESET_PROTECTION_MS to something 
higher like 120000 (120 seconds) and see if that helps. But the "right" way 
would be to avoid those deep queues in the first place.

Do you set a multicast rate higher than the default 1 MBit/s? If not, that's 
worth a try. :) If you are using iw, there is a "mcast-rate" parameter, and 
there is something equivalent in wpa_supplicant.

Cheers,
     Simon

On Monday, October 22, 2018 5:27:28 PM CEST Jake.Harris@zf.com wrote:
> Generated this via:
>    sudo tcpdump -s 2000 -w /media/pi/KINGSTON/my.pcap -i
>  wlx681ca2083fa4
> 
>  message after ^c
>    12090 packets captured
>    12251 packets received by filter
>    0 packets dropped by kernel
>    27 packets dropped by interface
> 
> -----Original Message-----
> From: Simon Wunderlich <sw@simonwunderlich.de>
> Sent: Monday, October 22, 2018 10:27
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: Harris Jake LPR <Jake.Harris@zf.com>
> Subject: Re: [B.A.T.M.A.N.] broadcast storms
> 
> * PGP Signed by an unknown key
> 
> Hi Jake,
> 
> could you make some pcap dumps on the wlan device where batman runs, and
> provide that to us? Just the the full tcpdump (tcpdump -s 2000 -w
> /tmp/my.pcap wlan0, assuming that wlan0 is your interface), not batctl
> dump? Then we can check sequence numbers etc in wireshark.
> 
> Do you have some of your mesh nodes connected and bridged to Ethernet? If
> yes, you should check the bridge loop avoidance which could also be causing
> this effect, if you don't have it enabled and use such a topology:
> 
> https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-II
> 
> Cheers,
>      Simon
> 
> On Monday, October 22, 2018 1:07:29 PM CEST Jake.Harris@zf.com wrote:
> > I'm sure a similar question to this has been answered, but I am new to
> > this mailing list format and don't know an efficient way to search
> > https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/
> > 
> > I'm having problems with broadcast messages effectively echoing around
> > the network of 50ish nodes. I attached a few seconds of the batctl
> > tcpdump output. I can't seem to find a pattern to what causes this, it
> > tends to happen once every two or three weeks, the storm causes
> > problems with the batman program where during the storm nodes drop all
> > their neighbors (batctl n shows an empty list) indefinitely, which I
> > have worked around that issue via a batch script that reloads batman
> > if the neighbor list is empty. Reloading successfully reconnects to
> > the network but the storm still persists.
> > 
> > The only way I've found to fix this is to reboot all the nodes at the
> > same time such that the whole network is down to kill the echos.
> > 
> > I believe I had this problem much more frequently (every 4 days or so)
> > a while ago on the same network when using discrete tcp destinations
> > for the nodes to communicate, the storm frequency was reduced to what
> > it is now by using broadcast packets and reducing the communication
> > rate from 12 seconds to once every 40 seconds.
> > 
> > Rebooting the nodes that are responsible for the echoing messages has
> > no effect, I rebooted 192.168.1.230 before running tcpdump that is
> > attached and as it shows packets from 230 continued to bounce around
> > while the node was powered off and after it rejoined the network. It
> > doesn't appear broadcast uses a time-to-live parameter to limit the
> > hops the packets will make.
> > 
> > I'm at a loss for a way to remedy this, there seems to only be
> > multicast optimizations.
> 
> * Unknown Key
> * 0x42929EA1


--nextPart2802252.tTjxyp59UE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlvOFC4ACgkQoSvjmEKS
nqEJQxAAwGjaJBDiYNxDmE3khaB8T+5P1cQXYxmXLcfvVIDy35T+zh+94PvnJpOS
Ku0tr1i5/xQoBmx2r6JpyjHEdeuUpFsJFB5kKFG7E8gxvJuodZtJ4joowReCG4Iq
n68UoZH7vnMl1+Aa88gJrSJkW5FeaqRlR5Ik2BGkGl8Lehs4UFdRONkhHCPDsNls
O3Eo7h4QY53JOf67PprmG0EIMGQMQ4mHac/RLiEFu0ZMpKMqjbaJYiO43JJ8tAVi
Fmq4c1bkqy50hgdGgsg0mUZKfVeP3OPOyjQPncIVT6CXlbuWe/LlaX8LfobjfOoc
bTtz/TyqpkGnShdpqho42USxBEOARCibsHJT2XWDi8WDaV93clITS6HDcXeIJO0t
J7+w9wHsG29B5sz0J81kxzuudCLA3GuzI/Ovnb7xAMTryCkvOFrpmNW4n5sG5kcC
LE1fq46cADOzsmjPYTkqSN2tUUTErKM+AzazOOmv9otMmYhrbEhaDXIpm3cArKsF
pn2t7xwa6b15ubP2z0xzpUVKd/kzaLoJGqI+7qncJlpfGKyq55bttbxb4577P/ci
WcqknCUzacUESuZu4/Xgdtff2aSPGeN8hZUJgSfPXQXXG75/3ND+yzmNveinIyRc
ZpD6PCcvRUFP2NReLiRoZb0hHQJGNMsz1YGHJNETGpQ8dcC2VHE=
=mLFW
-----END PGP SIGNATURE-----

--nextPart2802252.tTjxyp59UE--

