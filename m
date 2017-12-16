Return-Path: <gui@altermundi.net>
From: Gui Iribarren <gui@altermundi.net>
Message-ID: <975dadcd-f5f4-15ab-7926-f7b4beedcdb9@altermundi.net>
Date: Sat, 16 Dec 2017 16:08:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] weird alfred problem
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

found this situation today, on a node that otherwise works normal
("alfred -r 64" normally returns around ~50 lines of output)

https://pastebin.com/7xkXUnsr

any idea what could lead to this state?
(after a reboot, everything was fine again)

(copypaste follows for reference)

root@giordano:~# uptime
 09:56:49 up 4 days, 21:49,  load average: 0.40, 0.13, 0.08
root@giordano:~# alfred -r 64
# returns immediately, tcpdump on br-lan doesn't see any packet out
root@giordano:~# alfred -r 64
root@giordano:~# ps |grep alfred
 1182 root      1044 S    /usr/sbin/alfred -i br-lan -b bat0

root@giordano:~# tcpdump -i br-lan  udp port 16962
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on br-lan, link-type EN10MB (Ethernet), capture size 262144 bytes
09:46:40.945074 IP6 fe80::c24a:ff:fefc:38df.16962 > ip6-allnodes.16962:
UDP, length 4
09:46:40.987477 IP6 fe80::c24a:ff:fefc:3a87.16962 > ip6-allnodes.16962:
UDP, length 4
[...]
i correctly see these two incoming announcements from the two masters in
the network (giordano is slave)

### Tested changing mode to Master, no luck
root@giordano:~# alfred -M master
root@giordano:~# alfred -r 64
### waited a minute or so, but never saw any outgoing announcement
### over br-lan (still seeing the other incoming announcements)

root@giordano:~# /etc/init.d/alfred restart
/etc/init.d/alfred: waiting 30 secs for br-lan address...
/etc/init.d/alfred: starting alfred
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
can't connect to unix socket: Connection refused
root@giordano:~# ps |grep alfred
30114 root      1184 S    grep alfred

root@giordano:~# netstat -tunpl
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address
State       PID/Program name
tcp        0      0 0.0.0.0:53              0.0.0.0:*
LISTEN      1726/dnsmasq
tcp        0      0 0.0.0.0:22              0.0.0.0:*
LISTEN      847/dropbear
tcp        0      0 127.0.0.1:5303          0.0.0.0:*
LISTEN      973/orangerpcd
tcp        0      0 :::12865                :::*
LISTEN      858/netserver
tcp        0      0 :::80                   :::*
LISTEN      856/lighttpd
tcp        0      0 :::53                   :::*
LISTEN      1726/dnsmasq
tcp        0      0 :::22                   :::*
LISTEN      847/dropbear
udp        0      0 0.0.0.0:53              0.0.0.0:*
       1726/dnsmasq
udp        0      0 0.0.0.0:67              0.0.0.0:*
       1726/dnsmasq
udp        0      0 :::53                   :::*
       1726/dnsmasq
udp        0      0 ff02::2:6240            :::*
       874/bmx6
udp        0      0 fe80::c24a:ff:fefc:4154:6240 :::*
            874/bmx6
udp        0      0 ff02::2:6240            :::*
       874/bmx6
udp        0      0 fe80::c24a:ff:fefc:4155:6240 :::*
            874/bmx6
udp        0      0 ff02::2:6240            :::*
       874/bmx6
udp        0      0 fe80::c24a:ff:fefc:4153:6240 :::*
            874/bmx6

root@giordano:~# alfred -i br-lan -b bat0 -d
can't bind: Address not available
Failed to open interfaces
root@giordano:~# alfred -i br-lan -b bat0 -d
can't bind: Address not available
Failed to open interfaces
root@giordano:~# alfred -i br-lan -b bat0 -d
can't bind: Address not available
Failed to open interfaces
root@giordano:~# alfred -i br-lan -b bat0 -d
can't bind: Address not available
Failed to open interfaces
root@giordano:~# alfred -i br-lan -b bat0 -d
can't bind: Address not available
Failed to open interfaces

root@giordano:~# ip a s br-lan
11: br-lan: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
state UP group default qlen 1000
    link/ether c2:4a:00:fc:41:54 brd ff:ff:ff:ff:ff:ff
    inet 10.5.0.31/21 brd 10.5.7.255 scope global br-lan
       valid_lft forever preferred_lft forever
    inet6 2801:1e8:2::5341:fc00/64 scope global
       valid_lft forever preferred_lft forever
    inet6 fe80::d4f4:2aff:feb8:ce2d/64 scope link
       valid_lft forever preferred_lft forever

root@giordano:~# uptime
 10:29:41 up 4 days, 22:22,  load average: 0.08, 0.14, 0.10
