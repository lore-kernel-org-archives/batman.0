Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201008201327.21282.sven.eckelmann@gmx.de>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTim9xwEgYLwK0bOzzmKkLMK6aedMDvD+SjrnTXFe@mail.gmail.com>
	<AANLkTikG3x-LEQdndaZsnhQn0VAejEk=S0pe_c2cWXA3@mail.gmail.com>
	<201008201327.21282.sven.eckelmann@gmx.de>
Date: Mon, 23 Aug 2010 10:05:12 +0300
Message-ID: <AANLkTim2Ejkjc=63tVw7b6PsW7wUcjYVYTvsPSx-M=Pc@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,

Thanks so much for your=A0patience=A0with this matter and for holding my
hand though the process.

I have gone back to basics (i think trying to adapt my current olsr
platform over to this was the root cause of the issue) and now i am
able to retrieve webpages over the bat interface.

I'll briefly outline the steps i took to get batman working with
openwrt Kamikaze

*net router*

configure wan

vi /etc/config/network
config interface        wan
        option ifname   "eth1"
        option proto    dhcp

*the following should be done on both the net and mesh router*

set the ip address of eth0 to 192.168.1.1 (.2 on the mesh)

configure wireless cards in /etc/config/wireless so that they have the
same BSSID and channel.

opkg update
opkg install kmod-batman-advanced

reboot

bridge the eth0 and bat0 interfaces (may not be the best way)

Ensure that you can see the other node
cat /proc/net/batman-adv/originators

test pinging the internet

Thanks


On Fri, Aug 20, 2010 at 2:27 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
>
> On Friday 20 August 2010 11:58:32 David Beaumont wrote:
> > So large pings appear to be going over the batman interface.
>
> So, first you say that all packets go over the bat interface and that thi=
s
> part works fine. Now you say that large packets will also work... which i=
s no
> gain of information for the batman-adv related parts.
>
> > However still not getting any web traffic through
> >
> > root@Generic:~# echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc
> > git.open-mesh.net 80
> >
> > root@Generic:~# wget http://www.google.com
> > Connecting to www.google.com (74.125.39.104:80)
> >
> > What else can i provide to help track down the problem here :-(
>
> Create a real minimal setup. Minimal as possible. Get that working and th=
en at
> parts to it (iptables, bridges, ...) until it doesn't work anymore. Check=
 if
> that is real the part which makes the problem by reducing the complexity =
of
> other parts you already added.
>
> You already told us that it is not related to batman-adv and that the bri=
dge
> makes problems.
>
> Actually nobody understands here what you are currently try to archive wi=
th
> your setup and why all the iptables or maybe ebtables stuff/bridges/... i=
s
> needed to find a problem.
>
> And why have both mesh and net (for whatever they are used) a masquerade =
rule
> in postrouting?
>
>
> Simplest setup would be:
> =A0* net is a nat router; everything in iptables to accept:
> =A0 =A0iptables -F
> =A0 =A0iptables -t nat -F
> =A0 =A0iptables -t mangle -F
> =A0 =A0iptables -X
> =A0 =A0iptables -P INPUT ACCEPT
> =A0 =A0iptables -P FORWARD ACCEPT
> =A0 =A0iptables -P OUTPUT ACCEPT
> =A0 masquerade enabled
> =A0 =A0iptables -t nat -A POSTROUTING -o "${OUTIF}" -j MASQUERADE
> =A0* configure outif (the thing which has globally routable address)
> =A0* enable wired connection between net and mesh by adding them to the s=
ame
> =A0 subnet (eth0 on net 192.168.1.1, eth0 on mesh 192.168.1.2)
> =A0* Try to ping each other
> =A0* test if connection between net and internet works flawless
> =A0* test if connection between mesh and indirectly to the internet over =
net
> =A0 works flawless
> =A0* set mtu of eth0 on both sides to 1530
> =A0* check if `ping -M do -s 1500` works between both net and mesh
> =A0* remove ip addresses of eth0 on both ends (but keep devices up)
> =A0* add eth0 on both sides using `batctl if add` to bat0
> =A0* set mtu of bat0 to 1500 on both hosts
> =A0* give bat0 the same ips which were used before by eth0
> =A0* set bat0 up
> =A0* check if both hosts finds each other using `batctl o`
> =A0* try to ping other host
> =A0* try if internet works flawless indirectly from mesh over net
> =A0* remove ip from bat0 devices
> =A0* add bat0 to a bridge on both ends
> =A0* set ips which were used by bat0 to the bridge devices
> =A0* set mtu of bridge to 1500
> =A0* try to.... I think you can guess the next 1000 steps by yourself
>
> Regards,
> =A0 =A0 =A0 =A0Sven
