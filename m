Return-Path: <linus.luessing@web.de>
Date: Wed, 10 Feb 2010 02:15:38 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100210011538.GA10612@Sellars>
References: <4B6F288E.8050406@muc.ccc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4B6F288E.8050406@muc.ccc.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

Hi Chris,

I hope it's okay that I'm attaching our chatlog here:
http://pastebin.org/89225 (being stored for a month).
And just to point out, the two captures on your router:
http://filebin.ca/hzoxmj (athX)
http://filebin.ca/xtwoa (bat0)
They seem to show quite well, that batman-adv and/or the kernel
seem to drop the arp replays which the router wants to put into
the bat0 interface as you described below.
I couldn't spot anything wrong in the second dump's arp-replays
though.

Anyone else seen this "protocol 4305 is buggy, dev ath1" message
before? Could just find 6-10 years old posts on mailinglists to
this topic...

On Sun, Feb 07, 2010 at 09:54:38PM +0100, x@muc.ccc.de wrote:
> hi!
>=20
> as openwrt 8.09.2 still ships with an old batman-adv 0.1 module, i tried =
to compile a batman-adv 0.2 module.
> the compile worked, the module loads, originators see each other, but on =
the openwrt box on bat0 tx packets stays 0 while tx dropped obviously incre=
ases with each packet to be transmitted.
>=20
> the setup:
> laptop debian squeeze amd64 2.6.31.12 batman-adv 0.2
> laptop debian sid x86 2.6.32 batman-adv 0.2
> ap openwrt 8.09.2 ixp4xx/armeb (cambria) 2.6.26.8 batman-adv 0.2
>=20
> the facts:
> all bridges and iptables switched off.
> with plain ip on the wlan interfaces, pinging between all nodes works fin=
e (when within reach).
> all three nodes have the respective two other nodes listed as originators=
, and if all are within reach of each other, with originator=3Dnexthop.
> pinging via bat0 works between the two laptops.
> pinging the laptops via bat0 from the ap results in no packets seen on th=
e laptops' bat0.
> pinging the ap via bat0 from a laptop results in incoming arp-requests an=
d outgoing arp-replies seen on the ap's bat0 - but again, the arp-replies a=
ren't seen on the laptops' bat0 (nor on the laptops' wlan interfaces).
> on the ap's bat0, the tx packets counter stays at 0, while the tx dropped=
 counter seems to increase with each packet that should be sent over it.
>=20
> i enabled all logging (15) on the ap and the laptops, but found no hint i=
n there...
>=20
> the only interesting messages seem to be in dmesg, saying:
> protocol 4305 is buggy, dev ath1
>=20
> so to me it seems like all tx packets on bat0 on the ap are dropped, whil=
e everything else seems to work as it's supposed to.
>=20
> i then tried to compile the current (r1568) version from svn for the ap. =
again, the compile worked, but the ap just freezes immediately when i try t=
o load it.
I also had tried some Debian stable versions with a 2.6.26 kernel,
and you're right in one of the last maintenance patches, a bug has
been introduced for kernel versions < 2.6.29.=20
(I made another post with some call traces here:
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-February/002282.html)
>=20
> i thought about trying a newer kernel for the ap, but from openwrt there'=
s a special cambria kernel and i haven't found its config and also don't kn=
ow what patches might have been applied, so i haven't had much hope for any=
 helpful result along this path...
>=20
> regards,
>=20
> 	Chris
>=20

Cheers, Linus
