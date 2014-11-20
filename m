Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416486149.2747.9.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Thu, 20 Nov 2014 13:22:29 +0100
In-Reply-To: <546DC214.6050908@hundeboll.net>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-Rg4dr0f6YL7wG7CwKrUc"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
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
To: b.a.t.m.a.n@lists.open-mesh.org


--=-Rg4dr0f6YL7wG7CwKrUc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin

/usr/src/linux/net/batman-adv/fragmentation.c is patched. I'm sorry I
oversaw your attachment. the new module is running, the size differs

# lsmod
[ =E2=80=A6 ]
batman_adv            147774  0 # old
batman_adv            148030  0 # new
[ =E2=80=A6 ]


Batman-adv runs with

# batctl if
fastd0: active

# batctl it
5000

# batctl ap
disabled

# batctl bl
enabled
# batctl dat
enabled

# batctl ag
enabled

# batctl b
disabled

# batctl f
enabled

# batctl nc
enabled

# batctl mark
0x00000000/0x00000000

# batctl mm
enabled

batctl ll
Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such
file or directory [ =E2=80=A6 ]

batctl gw
server (announced bw: 100.0/100.0 MBit)

this are also the options while kernel panic.

Am Donnerstag, den 20.11.2014, 11:27 +0100 schrieb Martin Hundeb=C3=B8ll:
> On 2014-11-20 10:48, Philipp Psurek wrote:

[ =E2=80=A6 ]

> Yeah, most people compile out network coding. Has the bug disappeared=20
> after disabling NC ?

I can't tell for sure. nc is disabled for 20 hours. The Bug appeared
from 1 minute to 72 hours. It depends on our users. To reproduce the bug
nc is enabled again.

> > Am Donnerstag, den 20.11.2014, 09:32 +0100 schrieb Martin Hundeb=C3=B8l=
l:
> >> Thanks for you report. The bug is probably triggered by some bogus dat=
a
> >> in an incoming packet. I have created a small debug patch that will
> >> detect if this is the case, and print some debug info if so.
> >
> > Thank you for your work. I didn't find your Patch on
> > http://git.open-mesh.org/batman-adv.git
>=20
> It was attached to my previous mail :)

I'm so sorry ;-) my fault

> > I can not analyse the packages because the gateway is part of an ISP
> > infrastructure and there is data privacy. But if you're capable to fish
> > only the bogus data package during kernel panic with your patch there
> > shouldn't be any problems, I think.
>=20
> My debug patch should only print the header of the packet causing the=20
> panic, so no problems with privacy here. (But you should probably check=
=20
> the output before mailing it to a public list...)

OK, thanks for that

[ =E2=80=A6 ]

> I am running with NC on my machines in the lab and haven't seen this=20
> frag-issue before. I have seen a similar issue (wrong size value in the=
=20
> header) in another context though, but this wasn't due to either network=
=20
> coding or fragmentation.

Well, the lab is peaceful but in the free wild there are evil data
packages.

> Would you mind sending me your fastd config (without the key), so that I=
=20
> can try to reproduce this in my VMs?

Not at all. Here is the censored /etc/fastd/fastd.conf

#---8<---8<---8<---8<---8<---8<----
bind <my_publicIP>:<my_fastdPORT>;
include "secret.conf";
include peers from "peers/wupper";
include peers from "testpeers/wupper";
include peers from "servers/wupper";
interface "fastd0";
log level warn;
method "salsa2012+gmac";
#### doesn't have anything to do with the bug, also seen with fastd v14
#### not used yet but with the new firmware:
method "salsa2012+umac";
mtu 1426;

on up "
 ip link set address <MAC_ADDRESS> dev $INTERFACE
 ip link set up dev $INTERFACE
 modprobe batman-adv
 batctl if add fastd0
 batctl it 5000
 batctl bl enable
 batctl gw client
 ### gw will be changed later to server 100000/100000
 ip link set up dev bat0
 ip addr add 10.3.<IP>/16 broadcast 10.3.255.255 dev bat0
 ip addr add 10.3.<anotherIP>/16 broadcast 10.3.255.255 dev bat0
 ip addr add fda0:747e:ab29:e1ba:<IPv6_IP>/64 dev bat0
 ip route add 10.3.0.0/16 dev bat0 proto kernel scope link src
10.3.<wrong_IP*)>
 alfred -i bat0 -m > /dev/null 2>&1 &
 batadv-vis -i bat0 -s > /dev/null 2>&1 &
";
#---8<---8<---8<---8<---8<---8<----EOF

*) now I see there is a different IP. This IP does not belong to this
machine, and during kernel panic and now to no machine in the Batman
cloud.

wolke linux # /etc/init.d/fastd start fastd ...
RTNETLINK answers: Invalid argument
#### now I know why ;-) but to reproduce the bug I don't change it=20

then this commands are executed:
#---8<---8<---8<---8<---8<---8<----
ip tunnel add tun-ffw-w07 mode ipip remote <remoteIP> local <myIP>
ip addr add <some_ISP_IP>/31 dev tun-ffw-w07
ip tunnel change tun-ffw-w07 ttl 64
ip link set mtu 1400 dev tun-ffw-w07
ip link set dev tun-ffw-w07 up

ip rule add from <some_ISP_IP>/31 table 16
ip rule add iif bat0 table 16
ip rule add from all to <some_ISP_IP_for_this_machine> lookup 16=20

ip route add default via <some_ISP_IP_on_the_other_side> \
	dev tun-ffw-w07 table 16
ip route add <some_ISP_IP>/31 dev tun-ffw-w07 table 16

# bat doesn't need any address, but the error occurs also with scope
# link
ip addr flush dev fastd0

iptables -t nat \
	-A POSTROUTING \
	-o tun-ffw-w07 ! -s <some_ISP_IP>/31 \
	-j SNAT --to <some_ISP_IP_for_this_machine>
iptables -A FORWARD -p tcp \
	--tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
# yes, I know =E2=80=A6 but some services in the net do not like IMCP
# http://lartc.org/howto/lartc.cookbook.mtu-mss.html

sysctl -w net.ipv4.ip_forward=3D1
sysctl -w net.ipv4.conf.default.rp_filter=3D0
sysctl -w net.ipv4.conf.all.rp_filter=3D0

/etc/local.d/kdump.start
/etc/init.d/dhcpd restart
/etc/init.d/vnstatd restart
/etc/init.d/named restart
/etc/init.d/apache2 restart
batctl gw server 100000/100000
#---8<---8<---8<---8<---8<---8<----EOF

Now we have to wait till =E2=80=9Cprime time=E2=80=9D or weekend. I always =
hoped:
=E2=80=9Cplease don't crush=E2=80=9D but now it's different ;-) I hope afte=
r that you
can reproduce the bug and fix it.

Best regards

Philipp
________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93

--=-Rg4dr0f6YL7wG7CwKrUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUbd0FAAoJENpWdD1eHU4JYm8P/RxTvP8Iu0PL2msWNPU9UvXA
AhFnvQ7I1vTWMvr68SrVyypT/8jl3tHjtXiCBdtbQ409S/llPO0YnS5uIORvd/93
Mz+2W95DKDv/ZsvsgxB2ayR4QfcEU99kCfZXg/Jsw9sjbi6mRGlyJgOqW6vEy1RZ
gAaZju+gljlqu2/xxktuEci0JejpSKzVJOhgZC4kTGL5hn5+xAgDA/VOYOkClSqm
daXWPsk2bWghzF5mT9/BR+E4VsCQogsEOSODmb2mqTl8iecI9bydTbJjKnzGSV94
TChhISYHgPEvYHB/eJSSbmMVuCReOUkQDBbeLsHfeXjEvF87JLLo3XxjEOUy4A28
8++DRGRzQlWBt9s6qmaS8ZgNph0HRl51FgKxVUc+I69vD5/ulqs1/Yz8kJ4p88N7
z1nhRDevE1g2h2AZXQBWju/x5STDTGDn6JvlswDr6sSelw5U5vw8Xb44XtVZUKl9
y69G8IYm+p0Yfn3HPY4fMd8v19sk9lJgvCknmVrsIeLCvf7Tn6SP7lq+IDhZL968
MIwQcP/HbdUcyVSw8QV3k0o/2XaN3vdq9Q4rsghI8rGscEpv9hIpeVa7LxlZuVEZ
i6brlgYvpCSDBRd+ItF98/uzq8fA5iwYFyjuL4fGM+F+fZ+oqTWY+PGv3wmMDIuT
UMi4jU4GF3LUFF0voBmJ
=1nxK
-----END PGP SIGNATURE-----

--=-Rg4dr0f6YL7wG7CwKrUc--

