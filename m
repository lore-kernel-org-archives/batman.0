Return-Path: <Jake.Harris@zf.com>
From: <Jake.Harris@zf.com>
Date: Mon, 12 Nov 2018 14:29:07 +0000
Message-ID: <B99A1AB9A294834C8DF94185A5E9D18101784D2A0E@NRTV96002.america.zf-world.com>
References: <B99A1AB9A294834C8DF94185A5E9D18101784CE751@NRTV96002.america.zf-world.com>
 <3126005.3y7xrHjZEe@prime>
 <B99A1AB9A294834C8DF94185A5E9D18101784D0848@NRTV96002.america.zf-world.com>
 <3795505.rC9BEUj0Hg@prime>
In-Reply-To: <3795505.rC9BEUj0Hg@prime>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: sw@simonwunderlich.de
Cc: b.a.t.m.a.n@lists.open-mesh.org

My apologies bringing this back but I'm still having trouble with this. Eac=
h of my 50 nodes sends a 100 byte packet via broadcast every 30 seconds, ev=
en if coincidently they all transmit it at the same time that's only 5kB of=
 data to move, much under the 1MB (default I believe?) bandwidth for multic=
ast. Unless there's a large amount of broadcast traffic outside of my pytho=
n program I don't see this being the culprit.

The storms tend to start when connection to a few nodes gets flakey, so I c=
an see the reset protection setting being helpful, how do I set BATADV_RESE=
T_PROTECTION_MS? Is this an environment variable or do I set it with batctl=
?

Thanks again for your help, I believe this has a good chance of remedying t=
he issue.

-----Original Message-----
From: Simon Wunderlich <sw@simonwunderlich.de>
Sent: Monday, October 22, 2018 14:17
To: Harris Jake LPR <Jake.Harris@zf.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: [B.A.T.M.A.N.] broadcast storms

* PGP Signed by an unknown key

Hello Jake,

I've checked your pcap files. I couldn't find a culprit directly, but it se=
ems like you are having so many repetitions / the network is getting so ove=
rloaded that broadcasts stay in the queues of your WiFi driver for longer t=
han 30 seconds (possibly in different devices, accumulated). At this point,=
 batman- adv assumes that the device has rebooted and the sequence number i=
s validly re-used, thus circumventing the broadcast duplicate check.

You could increase the define of BATADV_RESET_PROTECTION_MS to something hi=
gher like 120000 (120 seconds) and see if that helps. But the "right" way w=
ould be to avoid those deep queues in the first place.

Do you set a multicast rate higher than the default 1 MBit/s? If not, that'=
s worth a try. :) If you are using iw, there is a "mcast-rate" parameter, a=
nd there is something equivalent in wpa_supplicant.

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
> > Old Signed by an unknown key
>
> Hi Jake,
>
> could you make some pcap dumps on the wlan device where batman runs,
> and provide that to us? Just the the full tcpdump (tcpdump -s 2000 -w
> /tmp/my.pcap wlan0, assuming that wlan0 is your interface), not batctl
> dump? Then we can check sequence numbers etc in wireshark.
>
> Do you have some of your mesh nodes connected and bridged to Ethernet?
> If yes, you should check the bridge loop avoidance which could also be
> causing this effect, if you don't have it enabled and use such a topology=
:
>
> https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidan
> ce-II
>
> Cheers,
>      Simon
>
> On Monday, October 22, 2018 1:07:29 PM CEST Jake.Harris@zf.com wrote:
> > I'm sure a similar question to this has been answered, but I am new
> > to this mailing list format and don't know an efficient way to
> > search https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/
> >
> > I'm having problems with broadcast messages effectively echoing
> > around the network of 50ish nodes. I attached a few seconds of the
> > batctl tcpdump output. I can't seem to find a pattern to what causes
> > this, it tends to happen once every two or three weeks, the storm
> > causes problems with the batman program where during the storm nodes
> > drop all their neighbors (batctl n shows an empty list)
> > indefinitely, which I have worked around that issue via a batch
> > script that reloads batman if the neighbor list is empty. Reloading
> > successfully reconnects to the network but the storm still persists.
> >
> > The only way I've found to fix this is to reboot all the nodes at
> > the same time such that the whole network is down to kill the echos.
> >
> > I believe I had this problem much more frequently (every 4 days or
> > so) a while ago on the same network when using discrete tcp
> > destinations for the nodes to communicate, the storm frequency was
> > reduced to what it is now by using broadcast packets and reducing
> > the communication rate from 12 seconds to once every 40 seconds.
> >
> > Rebooting the nodes that are responsible for the echoing messages
> > has no effect, I rebooted 192.168.1.230 before running tcpdump that
> > is attached and as it shows packets from 230 continued to bounce
> > around while the node was powered off and after it rejoined the
> > network. It doesn't appear broadcast uses a time-to-live parameter
> > to limit the hops the packets will make.
> >
> > I'm at a loss for a way to remedy this, there seems to only be
> > multicast optimizations.
>
> * Unknown Key
> * 0x42929EA1


* Unknown Key
* 0x42929EA1
