Return-Path: <marko.panger@agblab.com>
Message-ID: <4EDE1914.1030601@agblab.com>
Date: Tue, 06 Dec 2011 14:31:00 +0100
From: Marko Panger - AGB Lab <marko.panger@agblab.com>
MIME-Version: 1.0
References: <4EDDE473.5020008@agblab.com> <20111206110826.GC4848@ritirata.org>
In-Reply-To: <20111206110826.GC4848@ritirata.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] TT inconsistency problem (again)
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

Hi Antonio,

Its a bit difficult to provide you a cap file as this is a tightly 
embedded device (console only) and I would have to build wireshark for it.
I'm copy/pasting the required information from the batctl output for 
both nodes.

If this doesn't help I will try to manage to get wireshark running, but 
it will be tricky.

Here you go:

*** a3:0e - pinged node ***
 > batctl o
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: ra0/48:5d:60:b8:a3:0e (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
48:5d:60:b8:a2:b7    0.737s   (206) 48:5d:60:b8:a2:ff [       ra0]: 
48:5d:60:b8:a2:ff (206)
48:5d:60:b8:a2:d2    0.301s   (207) 48:5d:60:b8:a2:d2 [       ra0]: 
48:5d:60:b8:a2:ff (  0) 48:5d:60:b8:a2:f6 (185) 48:5d:60:b8:a2:d2 (207)
48:5d:60:b8:a2:ff    0.554s   (231) 48:5d:60:b8:a2:ff [       ra0]: 
48:5d:60:b8:a2:ff (231)
48:5d:60:b8:a2:f6    0.303s   (225) 48:5d:60:b8:a2:f6 [       ra0]: 
48:5d:60:b8:a2:ff (  0) 48:5d:60:b8:a2:d2 (193) 48:5d:60:b8:a2:f6 (225)

 > batctl td ra0
14:39:00.652217 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74341, tq 255, ttvn 1, ttcrc 19133, ttl 50, v 14, flags [..F.], 
length 26
14:39:00.754981 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74341, tq 236, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:39:00.795184 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75781, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 52
14:39:00.861530 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74341, tq 199, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:39:00.896005 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75781, tq 245, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:00.898495 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75781, tq 243, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:00.979211 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74267, tq 232, ttvn 1, ttcrc 22851, ttl 49, v 14, flags [D...], 
length 26
14:39:01.005184 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75781, tq 219, ttvn 1, ttcrc 53836, ttl 48, v 14, flags [....], 
length 26
14:39:01.082980 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74267, tq 214, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26
14:39:01.191677 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74267, tq 180, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:01.193434 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74267, tq 174, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:01.234976 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73719, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
Warning - packet contains unknown ether type: 0x0023
14:39:01.307481 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75714, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:39:01.335458 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73719, tq 216, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:01.338096 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73719, tq 208, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:01.340180 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 73719, tq 228, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
Warning - packet contains unknown ether type: 0x0023
14:39:01.410086 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75714, tq 200, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:01.410974 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75714, tq 223, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:01.520180 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75714, tq 199, ttvn 1, ttcrc 42909, ttl 48, v 14, flags [....], 
length 26
Warning - packet contains unknown ether type: 0x0024
14:39:01.632188 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74342, tq 255, ttvn 1, ttcrc 19133, ttl 50, v 14, flags [..F.], 
length 26
14:39:01.734978 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74342, tq 236, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:39:01.775105 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75782, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 26
14:39:01.882980 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75782, tq 245, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:01.883597 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75782, tq 243, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:01.962180 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74268, tq 232, ttvn 1, ttcrc 22851, ttl 49, v 14, flags [D...], 
length 26
14:39:01.962307 BAT 48:5d:60:b8:a3:0e > 48:5d:60:b8:a2:b7: TT request, 
ttvn 1, crc 17241, ttl 50, v 14, flags [Q.], length 19
14:39:01.987181 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75782, tq 215, ttvn 1, ttcrc 53836, ttl 48, v 14, flags [....], 
length 26
14:39:02.062980 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74268, tq 214, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26
14:39:02.163080 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74268, tq 174, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:02.163432 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74268, tq 184, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:02.214981 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73720, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
14:39:02.287409 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75715, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:39:02.320173 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 73720, tq 224, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:02.323054 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73720, tq 208, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:02.324411 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73720, tq 220, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:02.395984 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75715, tq 223, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:02.502172 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75715, tq 196, ttvn 1, ttcrc 42909, ttl 48, v 14, flags [....], 
length 26
Warning - packet contains unknown ether type: 0x0024
14:39:02.632172 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74343, tq 255, ttvn 1, ttcrc 19133, ttl 50, v 14, flags [..F.], 
length 26
14:39:02.632296 BAT 48:5d:60:b8:a3:0e > 48:5d:60:b8:a2:ff: TT request, 
ttvn 1, crc 48458, ttl 50, v 14, flags [Q.], length 19
14:39:02.738987 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74343, tq 236, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:39:02.775127 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75783, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 52
14:39:02.881976 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75783, tq 245, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:02.898072 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74343, tq 202, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:39:02.898549 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75783, tq 244, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:02.986092 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75783, tq 215, ttvn 1, ttcrc 53836, ttl 48, v 14, flags [....], 
length 26
14:39:03.194984 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73721, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
14:39:03.287378 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75716, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:39:03.302076 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73721, tq 213, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:03.387046 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75716, tq 204, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:03.390972 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75716, tq 223, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:03.409318 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73721, tq 218, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [....], 
length 26
14:39:03.494080 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75716, tq 196, ttvn 1, ttcrc 42909, ttl 48, v 14, flags [....], 
length 26
Warning - packet contains unknown ether type: 0x0024
14:39:03.612075 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74344, tq 255, ttvn 1, ttcrc 19133, ttl 50, v 14, flags [..F.], 
length 26
14:39:03.715988 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74344, tq 232, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:39:03.757579 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75784, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 52
14:39:03.818323 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74344, tq 202, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:39:03.857972 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75784, tq 245, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:03.866305 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75784, tq 244, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:39:03.936040 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74270, tq 228, ttvn 1, ttcrc 22851, ttl 49, v 14, flags [D...], 
length 26
14:39:03.958032 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75784, tq 211, ttvn 1, ttcrc 53836, ttl 48, v 14, flags [....], 
length 26
14:39:04.044974 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74270, tq 207, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26
14:39:04.149031 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74270, tq 172, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:04.152304 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74270, tq 181, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:39:04.174979 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73722, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
14:39:04.282022 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73722, tq 213, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:04.284278 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73722, tq 223, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:39:04.287260 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75717, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:39:04.387019 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75717, tq 204, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:04.390981 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75717, tq 228, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:39:04.492026 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 75717, tq 196, ttvn 1, ttcrc 42909, ttl 48, v 14, flags [....], 
length 26
Warning - packet contains unknown ether type: 0x0024
14:39:04.612044 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:ff, 
seq 74345, tq 255, ttvn 1, ttcrc 19133, ttl 50, v 14, flags [..F.], 
length 26

*** a2:f6 - the pinging node ***
 > batctl o
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: ra0/48:5d:60:b8:a3:0e (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
48:5d:60:b8:a2:b7    0.737s   (206) 48:5d:60:b8:a2:ff [       ra0]: 
48:5d:60:b8:a2:ff (206)
48:5d:60:b8:a2:d2    0.301s   (207) 48:5d:60:b8:a2:d2 [       ra0]: 
48:5d:60:b8:a2:ff (  0) 48:5d:60:b8:a2:f6 (185) 48:5d:60:b8:a2:d2 (207)
48:5d:60:b8:a2:ff    0.554s   (231) 48:5d:60:b8:a2:ff [       ra0]: 
48:5d:60:b8:a2:ff (231)
48:5d:60:b8:a2:f6    0.303s   (225) 48:5d:60:b8:a2:f6 [       ra0]: 
48:5d:60:b8:a2:ff (  0) 48:5d:60:b8:a2:d2 (193) 48:5d:60:b8:a2:f6 (225)

 > batctl td ra0
[B.A.T.M.A.N. adv 2011.4.0, MainIF/MAC: ra0/48:5d:60:b8:a2:f6 (bat0)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
48:5d:60:b8:a2:b7    0.678s   (109) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (  0) 48:5d:60:b8:a3:0e (109)
48:5d:60:b8:a3:0e    0.236s   (229) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (221) 48:5d:60:b8:a3:0e (229)
48:5d:60:b8:a2:d2    0.129s   (255) 48:5d:60:b8:a2:d2 [       ra0]: 
48:5d:60:b8:a3:0e (215) 48:5d:60:b8:a2:d2 (255)
48:5d:60:b8:a2:ff    0.350s   (123) 48:5d:60:b8:a3:0e [       ra0]: 
48:5d:60:b8:a2:d2 (  0) 48:5d:60:b8:a3:0e (123)

 > batctl td ra0
14:36:49.041049 BAT 48:5d:60:b8:a2:f6 > 48:5d:60:b8:a3:0e: ICMP echo 
request, id 0, seq 349, ttl 50, v 14, length 20
14:36:49.130824 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75787, tq 232, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:49.132475 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75787, tq 245, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:49.255485 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74415, tq 245, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:36:49.358633 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74415, tq 207, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:49.362841 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74415, tq 222, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:49.521508 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74341, tq 222, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26
14:36:49.621615 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74341, tq 187, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:36:49.626827 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74341, tq 198, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:36:49.701512 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73793, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
14:36:49.804611 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73793, tq 216, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:36:49.808848 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73793, tq 228, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:36:50.027648 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75788, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:36:50.042210 BAT 48:5d:60:b8:a2:f6 > 48:5d:60:b8:a3:0e: ICMP echo 
request, id 0, seq 350, ttl 50, v 14, length 20
14:36:50.132975 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75788, tq 245, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:50.136869 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75788, tq 228, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:50.236540 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74416, tq 245, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:36:50.337854 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74416, tq 219, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:50.341625 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74416, tq 207, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:50.479864 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75856, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 26
14:36:50.515565 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74342, tq 222, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26
14:36:50.584567 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75856, tq 245, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:36:50.587612 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75856, tq 232, ttvn 1, ttcrc 53836, ttl 49, v 14, flags [D...], 
length 26
14:36:50.616881 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74342, tq 198, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:36:50.623613 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74342, tq 187, ttvn 1, ttcrc 22851, ttl 47, v 14, flags [....], 
length 26
14:36:50.681581 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 73794, tq 255, ttvn 1, ttcrc 17841, ttl 50, v 14, flags [..F.], 
length 26
14:36:50.780881 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 73794, tq 232, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:36:50.785631 BAT 48:5d:60:b8:a3:0e: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 73794, tq 216, ttvn 1, ttcrc 17841, ttl 49, v 14, flags [D...], 
length 26
14:36:51.027651 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 75789, tq 255, ttvn 1, ttcrc 42909, ttl 50, v 14, flags [..F.], 
length 26
14:36:51.043367 BAT 48:5d:60:b8:a2:f6 > 48:5d:60:b8:a3:0e: ICMP echo 
request, id 0, seq 351, ttl 50, v 14, length 20
14:36:51.128909 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75789, tq 232, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:51.134918 BAT 48:5d:60:b8:a2:f6: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 75789, tq 240, ttvn 1, ttcrc 42909, ttl 49, v 14, flags [D...], 
length 26
14:36:51.216608 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74417, tq 245, ttvn 1, ttcrc 19133, ttl 49, v 14, flags [D...], 
length 26
14:36:51.317910 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 74417, tq 222, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:51.318637 BAT 48:5d:60:b8:a2:ff: OGM via neigh 48:5d:60:b8:a2:f6, 
seq 74417, tq 207, ttvn 1, ttcrc 19133, ttl 48, v 14, flags [....], 
length 26
14:36:51.479922 BAT 48:5d:60:b8:a2:d2: OGM via neigh 48:5d:60:b8:a2:d2, 
seq 75857, tq 255, ttvn 1, ttcrc 53836, ttl 50, v 14, flags [..F.], 
length 26
14:36:51.498638 BAT 48:5d:60:b8:a2:b7: OGM via neigh 48:5d:60:b8:a3:0e, 
seq 74343, tq 222, ttvn 1, ttcrc 22851, ttl 48, v 14, flags [....], 
length 26


Note that while the logs were produced the:
'batctl ping 48:5d:60:b8:a3:0e' command was running.

Marko
On 12/6/2011 12:09 PM, Antonio Quartulli wrote:
> Hello Marko,
>
> thank you for reporting the issue and for the high quantity (and quality) of
> information you are giving us.
>
> On Tue, Dec 06, 2011 at 10:46:27AM +0100, Marko Panger - AGB Lab wrote:
>> [root@gtam00119 ~]# batctl ping 48:5d:60:b8:a3:0e
>> PING 48:5d:60:b8:a3:0e (48:5d:60:b8:a3:0e) 20(48) bytes of data
>> Reply from host 48:5d:60:b8:a3:0e timed out
>> Reply from host 48:5d:60:b8:a3:0e timed out
>> Reply from host 48:5d:60:b8:a3:0e timed out
>> Reply from host 48:5d:60:b8:a3:0e timed out
> Starting from this point I would say that the problem is "before" the TT
> mechanism. batctl ping do not relies on the TTs as it directly use originator
> (node) addresses. Usually, in this cases, the problem is in the connection
> between nodes (most likely on the layer below).
>
>> And this is the output from 'batctl ll tt routes' from he node that is
>> being pinged (see above):
>>
> [CUT]
>
> > From the log it is possible to see that the node is not receiving any TT_REPLY
> message (which should solve the inconsistency being reported). This suggests us
> that the previous statement is probably true ("the problem is 'before" the TT
> mechanism").
>
>
> Would you mind providing us the output of "batctl o" after the reboot on the
> node where you take the tt log?
> Moreover, could you please attach the output of "batctl td WIFI_IFACE" either on
> the unreachable node and on another one (maybe a2:f6?)
>
> Cheers,
>
>
