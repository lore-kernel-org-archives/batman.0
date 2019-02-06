Return-Path: <beth.flippo@telegrid.com>
From: <beth.flippo@telegrid.com>
Date: Wed, 6 Feb 2019 11:56:00 -0500
Message-ID: <015501d4be3c$d64ad290$82e077b0$@telegrid.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: [B.A.T.M.A.N.] Alfred problem reading other nodes
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
Cc: s.pinsky@telegrid.com

Hi =96

I am having a problem getting alfred retrieve info from other nodes.=A0 =
I am
running openwrt and alfred 2018.0.

I am able to start the alfred server with no errors both from boot and =
the
command line.=20

root@OpenWrt:~# /etc/init.d/alfred restart
/etc/init.d/alfred: waiting 30 secs for br-lan address...
/etc/init.d/alfred: starting alfred
/etc/init.d/alfred: starting batadv-vis

I can see it with ps

4290 root=A0=A0=A0=A0=A0=A0 816 S=A0=A0=A0 /usr/sbin/alfred -i br-lan -m =
-b bat0

I can issue a set and then a receive and I see the value I set but only
locally.=A0 It does not get any info from the other nodes in my =
network.=A0 They
are all running alfred servers as master.

I have added a firewall rule to open the port.

If I have 2 nodes running alfred and I run =91tcpdump -i br-lan udp port
16962=92 - I see packets from the other node:

16:21:49.279086 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
UDP, length 4
16:21:51.907852 IP6 fe80::2d0:12ff:fe2e:f1bd.16962 > ip6-allnodes.16962:
UDP, length 4
16:21:59.282603 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
UDP, length 4
16:22:01.907227 IP6 fe80::2d0:12ff:fe2e:f1bd.16962 > ip6-allnodes.16962:
UDP, length 4
16:22:09.285498 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
UDP, length 4
16:22:11.919876 IP6 fe80::2d0:12ff:fe2e:f1bd.16962 > ip6-allnodes.16962:
UDP, length 4
16:22:19.288912 IP6 fe80::2d0:12ff:fe00:f0c7.16962 > ip6-allnodes.16962:
UDP, length 4
16:22:21.916609 IP6 fe80::2d0:12ff:fe2e:f1bd.16962 > ip6-allnodes.16962:
UDP, length 4

I think these might be the master announcements but when I issue an =
alfred
-r # - I do not see any new messages in the tcpdump.

Output of =91netstat -tunpl=92 shows alfred

4290/alfred
udp=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0 0 =
fe80::2d0:12ff:fe00:f0c7:16962
:::*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 4290/alfred

This is the output of =91ip a s br-lan=92

12: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state
UP group default qlen 1000
=A0 =A0=A0link/ether 00:d0:12:00:f0:c7 brd ff:ff:ff:ff:ff:ff
=A0=A0=A0 inet 192.168.2.91/24 brd 192.168.2.255 scope global br-lan
=A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
=A0=A0=A0 inet6 fd5b:763:2819::1/64 scope global noprefixroute
=A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
=A0=A0=A0 inet6 fe80::2d0:12ff:fe00:f0c7/64 scope link
=A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever

I=92ve rebuilt alfred, tried different versions from the repo, nothing =
works.=A0
I really would appreciate any help.
Beth
=A0



