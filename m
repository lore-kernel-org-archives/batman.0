Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Sat, 7 May 2016 16:42:01 +0000
Message-ID: <1b43c9dff51e492397ca5202456d9d2f@Ek.usurf.usu.edu>
References: <44fbd783f3734573bf7121e8bb3819fe@Ek.usurf.usu.edu>
 <33aefc13-e1a0-cef5-74f1-d21d7112b7d3@universe-factory.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Alfred 2016.1 bind errors
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 05/07/2016 06:16 AM, Matthias Schiffer wrote:=0A=
> On 05/06/2016 10:45 PM, Jonathan Haws wrote:=0A=
>> I am trying to get familiar with the Alfred tools and downloaded version=
=0A=
>> 2016.1.  Unfortunately it didn't work - I couldn't get past a bind error=
:=0A=
>>=0A=
>> root@sierra1:~# ./alfred -m -i bat0=0A=
>> can't bind: Cannot assign requested address=0A=
>> Failed to open interfaces=0A=
>>=0A=
>> I had setup batman-adv with the commands:=0A=
>>=0A=
>> batctl if add eth0=0A=
>> ip link set up bat0 (eth0 was already up)=0A=
>>=0A=
>> I rolled back to 2015.0 (per a hint at=0A=
>> http://wiki.pinneberg.freifunk.net/alfred) and alfred started up just=0A=
>> fine instead of giving the error.  However it periodically gives the=0A=
>> following message:=0A=
>>=0A=
>> announce master ...=0A=
>> Error during sent: Cannot assign requested address=0A=
>>=0A=
>> I also tried alfred -m -i eth0 with the same results.=0A=
>>=0A=
>> Is there something wrong in my configuration?  Can anyone point me in=0A=
>> the right direction?  I've read through the Wiki for both batman-adv and=
=0A=
>> alfred and am out of ideas.=0A=
>>=0A=
>> I'm trying to prove this setup and get familiar with it in a virtual=0A=
>> environment, so I am using VirtualBox to setup a network of 4 nodes in=
=0A=
>> my mesh.  Should be simple enough, and batman-adv seems to work just=0A=
>> great - once its up and running, all nodes can communicate one with=0A=
>> another as expected.  Only issue is I am trying to get alfred to work=0A=
>> with batadv-vis to give me a graph to tell me it really is working right=
.=0A=
>>=0A=
>> Thoughts?=0A=
>> Thanks!=0A=
>> Jon=0A=
>>=0A=
>=0A=
> alfred explicitly binds to the link-local IPv6 address of the interface=
=0A=
> since version 2016.0. I suspect one of the following caveats might be you=
r=0A=
> problem:=0A=
>=0A=
> * The link-local IPv6 address must match the MAC address of the interface=
=0A=
> (here bat0) (derived by flipping the 2 bit of the first byte, and adding=
=0A=
> fe80 and fffe); this ususally breaks when the MAC address is changed afte=
r=0A=
> the interface is up=0A=
> * The link-local address must not be tentative when alfred is started=0A=
> (duplicate address detection must have finished; this usually means that=
=0A=
> the interface must be up for 3 seconds before alfred is started)=0A=
>=0A=
> I hope this helps...=0A=
=0A=
This does help.  I don't believe my system is configured to use IPv6 at =0A=
the moment, though the kernel appears to have the right configuration.=0A=
=0A=
root@sierra1:~# zcat /proc/config.gz | grep IPV6=0A=
CONFIG_IPV6=3Dy=0A=
CONFIG_IPV6_ROUTER_PREF=3Dy=0A=
# CONFIG_IPV6_ROUTE_INFO is not set=0A=
# CONFIG_IPV6_OPTIMISTIC_DAD is not set=0A=
# CONFIG_IPV6_MIP6 is not set=0A=
# CONFIG_IPV6_VTI is not set=0A=
CONFIG_IPV6_SIT=3Dy=0A=
# CONFIG_IPV6_SIT_6RD is not set=0A=
CONFIG_IPV6_NDISC_NODETYPE=3Dy=0A=
CONFIG_IPV6_TUNNEL=3Dm=0A=
# CONFIG_IPV6_GRE is not set=0A=
# CONFIG_IPV6_MULTIPLE_TABLES is not set=0A=
# CONFIG_IPV6_MROUTE is not set=0A=
# CONFIG_NF_DEFRAG_IPV6 is not set=0A=
# CONFIG_NF_CONNTRACK_IPV6 is not set=0A=
# CONFIG_NF_REJECT_IPV6 is not set=0A=
# CONFIG_NF_LOG_IPV6 is not set=0A=
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm=0A=
=0A=
=0A=
Am I missing a kernel configuration or just some missing configuration =0A=
on my network interfaces?=0A=
=0A=
root@sierra1:~# ip addr show=0A=
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN =0A=
group default=0A=
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00=0A=
     inet 127.0.0.1/8 scope host lo=0A=
        valid_lft forever preferred_lft forever=0A=
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
master bat0 state UP group default qlen 1000=0A=
     link/ether 08:00:27:09:a2:bc brd ff:ff:ff:ff:ff:ff=0A=
     inet 192.168.74.101/24 scope global eth0=0A=
        valid_lft forever preferred_lft forever=0A=
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
state UP group default qlen 1000=0A=
     link/ether 08:00:27:b5:50:cb brd ff:ff:ff:ff:ff:ff=0A=
     inet 192.168.73.101/24 scope global eth1=0A=
        valid_lft forever preferred_lft forever=0A=
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
state UP group default qlen 1000=0A=
     link/ether 08:00:27:30:0d:96 brd ff:ff:ff:ff:ff:ff=0A=
     inet 10.0.2.15/24 brd 10.0.2.255 scope global eth2=0A=
        valid_lft forever preferred_lft forever=0A=
5: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default=0A=
     link/sit 0.0.0.0 brd 0.0.0.0=0A=
6: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =0A=
UNKNOWN group default=0A=
     link/ether f2:52:c3:50:2e:d7 brd ff:ff:ff:ff:ff:ff=0A=
=0A=
=0A=
root@sierra1:~# ip link show=0A=
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode =
=0A=
DEFAULT group default=0A=
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00=0A=
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
master bat0 state UP mode DEFAULT group default qlen 1000=0A=
     link/ether 08:00:27:09:a2:bc brd ff:ff:ff:ff:ff:ff=0A=
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
state UP mode DEFAULT group default qlen 1000=0A=
     link/ether 08:00:27:b5:50:cb brd ff:ff:ff:ff:ff:ff=0A=
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast =0A=
state UP mode DEFAULT group default qlen 1000=0A=
     link/ether 08:00:27:30:0d:96 brd ff:ff:ff:ff:ff:ff=0A=
5: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group =0A=
default=0A=
     link/sit 0.0.0.0 brd 0.0.0.0=0A=
6: bat0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state =0A=
UNKNOWN mode DEFAULT group default=0A=
     link/ether f2:52:c3:50:2e:d7 brd ff:ff:ff:ff:ff:ff=0A=
=0A=
=0A=
=0A=
=0A=
