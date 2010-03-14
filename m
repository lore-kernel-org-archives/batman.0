Return-Path: <batman@kevinsteen.net>
From: Kevin Steen <batman@kevinsteen.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 14 Mar 2010 00:35:50 +0000
Message-ID: <1268526950.4592.32.camel@rover>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Strange sequence numbers
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

I've been lurking on this list for a few weeks, but finally tried
compiling and running the batman-adv module from the svn sources.

It seems to work fine between my two test machines so far, but I noticed
some weird sequence numbers when doing a dump with 'batctl td'. In the
sequence below, I had 'rover' running and active on rover's eth0, then I
activated the eth1 interface on hilltop for a few seconds, then
de-activated it. 

It seems like when rover re-sends the OGM from hilltop, it gets the
sequence number wrong (1->256, 2->512, 3->768). Is this my lack of
understanding of how it should work, a bug in batctl's display or a bug
in batman-adv?

rover is kernel 2.6.31-20-generic (Ubuntu karmic),
hilltop is kernel 2.6.26-2-686 (Debian lenny)

$ ./batctl td eth1
23:37:22.022554 BAT rover-eth0: OGM via neigh rover-eth0, seqno 481, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:23.002547 BAT rover-eth0: OGM via neigh rover-eth0, seqno 482, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:23.982469 BAT rover-eth0: OGM via neigh rover-eth0, seqno 483, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:24.962417 BAT rover-eth0: OGM via neigh rover-eth0, seqno 484, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:25.962320 BAT rover-eth0: OGM via neigh rover-eth0, seqno 485, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:26.943490 BAT rover-eth0: OGM via neigh rover-eth0, seqno 486, tq   0, ttl 49, v 9, flags [D..], length 42
23:37:27.041437 BAT rover-eth0: OGM via neigh hilltop-eth1, seqno 486, tq   0, ttl 49, v 9, flags [D..], length 28
23:37:27.893422 BAT hilltop-eth1: OGM via neigh hilltop-eth1, seqno 1, tq 255, ttl 50, v 9, flags [..F], length 22
23:37:27.922233 BAT rover-eth0: OGM via neigh rover-eth0, seqno 487, tq   0, ttl 49, v 9, flags [D..], length 42
23:37:27.978267 BAT hilltop-eth1: OGM via neigh rover-eth0, seqno 256, tq  10, ttl 49, v 9, flags [D..], length 42
23:37:28.025425 BAT rover-eth0: OGM via neigh hilltop-eth1, seqno 487, tq   0, ttl 49, v 9, flags [D..], length 28
23:37:28.873428 BAT hilltop-eth1: OGM via neigh hilltop-eth1, seqno 2, tq 255, ttl 50, v 9, flags [..F], length 28
23:37:28.902203 BAT rover-eth0: OGM via neigh rover-eth0, seqno 488, tq  10, ttl 49, v 9, flags [D..], length 42
23:37:28.958188 BAT hilltop-eth1: OGM via neigh rover-eth0, seqno 512, tq  21, ttl 49, v 9, flags [D..], length 42
23:37:29.005443 BAT rover-eth0: OGM via neigh hilltop-eth1, seqno 488, tq  10, ttl 49, v 9, flags [D..], length 28
23:37:29.873428 BAT hilltop-eth1: OGM via neigh hilltop-eth1, seqno 3, tq 255, ttl 50, v 9, flags [..F], length 28
23:37:29.902152 BAT rover-eth0: OGM via neigh rover-eth0, seqno 489, tq  22, ttl 49, v 9, flags [D..], length 42
23:37:29.970180 BAT hilltop-eth1: OGM via neigh rover-eth0, seqno 768, tq  30, ttl 49, v 9, flags [D..], length 42
23:37:30.009433 BAT rover-eth0: OGM via neigh hilltop-eth1, seqno 489, tq  22, ttl 49, v 9, flags [D..], length 28
23:37:30.882142 BAT rover-eth0: OGM via neigh rover-eth0, seqno 490, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:31.882087 BAT rover-eth0: OGM via neigh rover-eth0, seqno 491, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:32.862046 BAT rover-eth0: OGM via neigh rover-eth0, seqno 492, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:33.861989 BAT rover-eth0: OGM via neigh rover-eth0, seqno 493, tq 255, ttl 50, v 9, flags [..F], length 42
23:37:34.861946 BAT rover-eth0: OGM via neigh rover-eth0, seqno 494, tq 255, ttl 50, v 9, flags [..F], length 42

-Kevin

