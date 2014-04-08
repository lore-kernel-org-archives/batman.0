Return-Path: <gui@altermundi.net>
Message-ID: <5344413D.6000003@altermundi.net>
Date: Tue, 08 Apr 2014 15:34:37 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <5344388B.7020907@altermundi.net>
In-Reply-To: <5344388B.7020907@altermundi.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] can batctl ping but not ping in 2014.1.0
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

On 04/08/2014 02:57 PM, Gui Iribarren wrote:
> Hello again friendly devs,
> here we are, after a long "running stable" hiatus, back into the 
> bleeding edge for a ride \o/
> 
> running a small cloud of recent openwrt trunk (r40361)
> (OT: kmod-ath9k is running suprisingly smooth! yay!!)
> with kmod-batman-adv - 3.10.34+2014.1.0-2
> 
> and, well... i have bat news :P
> 1) yesterday i saw something vaguely reminiscent to the old OGM starving 
> issue: in a line of 4 guinea-pig nodes that flow through a river of 
> DeltaLibre, the 4th node would get TQ=1 for the 1st node, and would not 
> even ping it (i can't remember the result of batctl ping, maybe it did), 
> even though the links were really solid (TQ>220 on every one-hop-link of 
> the chain)
> (the 3rd node was seeing the 1st with TQ>200, and could batctl ping / 
> ping perfectly)
> at that point i found out kmod-batman-adv was inadvertently compiled 
> without log support :( so that's as much as i can report for now, i'll 
> recompile with that enabled and follow up.
> 
> 2) this morning, in 2-node cloud testbed at home, uptime=22hs, The 
> Bizarre Behaviour showed up and is sharing breakfast with me.
> 
>     on one side, lying calmly on the floor...
> 
> root@rockm5:~# batctl o
> [B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: wlan0_adhoc.11/dc:9f:db:9c:37:54 
> (bat0 BATMAN_IV)]
>    Originator      last-seen (#/255)           Nexthop [outgoingIF]: 
> Potential nexthops ...
> 64:70:02:ed:f8:ea    0.770s   (255) 64:70:02:ed:f8:ea [wlan0_adhoc.11]: 
> 64:70:02:ed:f8:ea (255)
> 02:00:49:ed:f8:e8    0.320s   (255) 64:70:02:ed:f8:ea [wlan0_adhoc.11]: 
> 64:70:02:ed:f8:ea (255)
> root@rockm5:~# batctl if
> wlan0_adhoc.11: active
> 
>      2 meters away, a TL-WDR3600 lurks...
> 
> root@planit:~# batctl o
> [B.A.T.M.A.N. adv 2014.1.0, MainIF/MAC: eth0.1.11/02:00:49:ed:f8:e8 
> (bat0 BATMAN_IV)]
>    Originator      last-seen (#/255)           Nexthop [outgoingIF]: 
> Potential nexthops ...
> dc:9f:db:9c:37:54    0.360s   (255) dc:9f:db:9c:37:54 [wlan1_adhoc.11]: 
> dc:9f:db:9c:37:54 (255)
> root@planit:~# batctl if
> eth0.1.11: active
> wlan1_adhoc.11: active
> wlan0_adhoc.11: active
> 
> ### rockm5 global ip over br-lan: gave its last breath
> root@planit:~# ip -6 r get 2a00:1508:1:f804::9d:3754/64
> 2a00:1508:1:f804::9d:3754 from :: dev br-lan  src 
> 2a00:1508:1:f804::ed:f8e8  metric 0
> root@planit:~# ping 2a00:1508:1:f804::9d:3754
> PING 2a00:1508:1:f804::9d:3754 (2a00:1508:1:f804::9d:3754): 56 data bytes
> --- 2a00:1508:1:f804::9d:3754 ping statistics ---
> 4 packets transmitted, 0 packets received, 100% packet loss
> 
> ### rockm5 link-local over br-lan: feeding the daisies
> root@planit:~# ping6 fe80::de9f:dbff:fe9d:3754%br-lan
> PING fe80::de9f:dbff:fe9d:3754%br-lan(fe80::de9f:dbff:fe9d:3754) 56 data 
> bytes
> --- fe80::de9f:dbff:fe9d:3754%br-lan ping statistics ---
> 3 packets transmitted, 0 received, 100% packet loss, time 2001ms
> 
> ### lower level link-local works fine (avoiding batman-adv)
> root@planit:~# ping6 fe80::de9f:dbff:fe9c:3754%wlan1_adhoc.11
> PING fe80::de9f:dbff:fe9c:3754%wlan1_adhoc.11(fe80::de9f:dbff:fe9c:3754) 
> 56 data bytes
> 64 bytes from fe80::de9f:dbff:fe9c:3754: icmp_seq=1 ttl=64 time=2.70 ms
> 64 bytes from fe80::de9f:dbff:fe9c:3754: icmp_seq=2 ttl=64 time=1.39 ms
> --- fe80::de9f:dbff:fe9c:3754%wlan1_adhoc.11 ping statistics ---
> 2 packets transmitted, 2 received, 0% packet loss, time 1001ms
> rtt min/avg/max/mdev = 1.398/2.053/2.708/0.655 ms
> 
> ### batctl ping to rockm5 enjoys excellent health
> root@planit:~# batctl ping dc:9f:db:9c:37:54
> PING dc:9f:db:9c:37:54 (dc:9f:db:9c:37:54) 20(48) bytes of data
> 20 bytes from dc:9f:db:9c:37:54 icmp_seq=1 ttl=50 time=1.16 ms
> 20 bytes from dc:9f:db:9c:37:54 icmp_seq=2 ttl=50 time=0.90 ms
> 20 bytes from dc:9f:db:9c:37:54 icmp_seq=3 ttl=50 time=0.90 ms
> ^C--- dc:9f:db:9c:37:54 ping statistics ---
> 3 packets transmitted, 3 received, 0% packet loss
> rtt min/avg/max/mdev = 0.902/0.989/1.162/0.122 ms
> 
> 
> well, as said before, i have no "batctl l" output to show, but will 
> collect and write chapter two.
> With a bit of luck, what i described so far rings a bell on someone, and 
> can give an early insight
> (maybe it's due to the way we are using vlans?)

Mh... speaking of which, maybe there's something TT-fishy about vlans?

root@rockm5:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 2):
       Client         VID Flags    Last seen (CRC       )
 *     rockm5_br-lan   -1 [......]   3.220   (0xbfe4b7db)
 *       rockm5_bat0   -1 [.P....]   0.000   (0xbfe4b7db)
 *       rockm5_bat0    0 [.P....]   0.000   (0x453da959)
root@rockm5:~# batctl tg
Globally announced TT entries received via the mesh bat0
       Client         VID  (TTVN)       Originator      (Curr TTVN) (CRC       ) Flags
 *       planit_bat0   -1   (  2) via  planit_eth0.1.11     (  2)   (0x8f4039e4) [....]
 *       planit_bat0    0   (  2) via  planit_eth0.1.11     (  2)   (0x29283c0f) [....]


root@planit:~# batctl tl
Locally retrieved addresses (from bat0) announced via TT (TTVN: 2):
       Client         VID Flags    Last seen (CRC       )
 *       planit_bat0   -1 [.P....]   0.000   (0x8f4039e4)
 *       planit_bat0    0 [.P....]   0.000   (0x29283c0f)
root@planit:~# batctl tg
Globally announced TT entries received via the mesh bat0
       Client         VID  (TTVN)       Originator      (Curr TTVN) (CRC       ) Flags
 *     rockm5_br-lan   -1   (  2) via rockm5_wlan0_adhoc     (  2)   (0xbfe4b7db) [....]
 *       rockm5_bat0   -1   (  1) via rockm5_wlan0_adhoc     (  2)   (0xbfe4b7db) [....]
 *       rockm5_bat0    0   (  2) via rockm5_wlan0_adhoc     (  2)   (0x453da959) [....]

i understand vid -1 means "no tag"... but then, what's vid=0 then?

relevant bat-hosts
dc:9f:db:9d:37:54 rockm5_br-lan
96:65:b0:4c:6b:44 rockm5_bat0
dc:9f:db:9c:37:54 rockm5_wlan0_adhoc
92:5c:d9:b1:8f:df planit_bat0
02:00:49:ed:f8:e8 planit_eth0.1.11

> (maybe its because routing_algo = BATMAN_IV?)
> (maybe the rewritten code is designed to work this way? yay!)
> (maybe it's our ugly hacky ebtables droppings / anygw magic that are 
> interacting badly in some way? can describe them in detail next time)
> 
> i must say tho, that this was running fine yesterday, and it broke 
> spontaneously without any manual intervention or config change.
> 
> oh, BLA2 and DAT are disabled on all nodes.
> 
> thanks as always,
> and hope a giggle cheers up your day :)
> 
> gui
