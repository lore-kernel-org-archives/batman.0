Return-Path: <jacobmarble@gmail.com>
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 16:22:40 -0600
Message-ID: <5161afcd0906181522x5f967b00t203ce685ef8d8937@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] originators says yes, batping says no
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

I have three nodes running OpenWrt r16484 (SVN) and batman-advanced
r1298.  All nodes show each other in originators.  batping gets host
unreachable for all relationships, and the host unreachable messages
come very quickly, maybe 1000/second.  Here is a log sample, log_level
4.  log_level 11 doesn't show anything.

The setup I'm using worked fine with r1176.  Using ahdemo.

[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:9e, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:9e, via old OG:
00:15:6d:a7:6a:9e, seqno 214, tq 255, TTL 50, V 7, IDF 0)
[  42949625] updating last_seqno: old 213, new 214
[  42949625] bidirectional: orig = 00:15:6d:a7:6a:9e neigh =
00:15:6d:a7:6a:9e => own_bcast = 64, real recv = 64, local tq: 255,
asym_penality: 255, total tq: 255
[  42949625] update_originator(): Searching and updating originator
entry of received packet
[  42949625] Updating existing last-hop neighbour of originator
[  42949625] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw:
250, ttl_orig: 49, ttl_forw: 49
[  42949625] Forwarding packet: rebroadcast neighbour packet with
direct link flag
[  42949625] Sending own packet (originator 00:15:6d:a7:6a:9c, seqno
216, TQ 255, TTL 50, IDF off) on interface ath0 [00:15:6d:a7:6a:9c]
[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:14, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:9e, via old OG:
00:15:6d:a7:6a:9e, seqno 214, tq 240, TTL 49, V 7, IDF 1)
[  42949625] bidirectional: orig = 00:15:6d:a7:6a:9e neigh =
00:15:6d:a7:6a:14 => own_bcast = 63, real recv = 64, local tq: 251,
asym_penality: 255, total tq: 236
[  42949625] update_originator(): Searching and updating originator
entry of received packet
[  42949625] Updating existing last-hop neighbour of originator
[  42949625] Drop packet: duplicate packet received
[  42949625] Forwarding packet (originator 00:15:6d:a7:6a:9e, seqno
214, TQ 240, TTL 49, IDF on) on interface ath0 [00:15:6d:a7:6a:9c]
[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:9e, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:9c, via old OG:
00:15:6d:a7:6a:9c, seqno 216, tq 236, TTL 49, V 7, IDF 1)
[  42949625] Drop packet: originator packet from myself (via neighbour)
[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:14, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:9c, via old OG:
00:15:6d:a7:6a:9c, seqno 216, tq 240, TTL 49, V 7, IDF 1)
[  42949625] Drop packet: originator packet from myself (via neighbour)
[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:14, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:14, via old OG:
00:15:6d:a7:6a:14, seqno 205, tq 255, TTL 50, V 7, IDF 0)
[  42949625] updating last_seqno: old 204, new 205
[  42949625] bidirectional: orig = 00:15:6d:a7:6a:14 neigh =
00:15:6d:a7:6a:14 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penality: 255, total tq: 255
[  42949625] update_originator(): Searching and updating originator
entry of received packet
[  42949625] Updating existing last-hop neighbour of originator
[  42949625] Forwarding packet: tq_orig: 255, tq_avg: 254, tq_forw:
250, ttl_orig: 49, ttl_forw: 49
[  42949625] Forwarding packet: rebroadcast neighbour packet with
direct link flag
[  42949625] Received BATMAN packet via NB: 00:15:6d:a7:6a:9e, IF:
ath0 [00:15:6d:a7:6a:9c] (from OG: 00:15:6d:a7:6a:14, via old OG:
00:15:6d:a7:6a:14, seqno 205, tq 240, TTL 49, V 7, IDF 1)
[  42949625] bidirectional: orig = 00:15:6d:a7:6a:14 neigh =
00:15:6d:a7:6a:9e => own_bcast = 64, real recv = 64, local tq: 255,
asym_penality: 255, total tq: 240
[  42949625] update_originator(): Searching and updating originator
entry of received packet
[  42949625] Updating existing last-hop neighbour of originator
[  42949625] Drop packet: duplicate packet received
[  42949625] Forwarding packet (originator 00:15:6d:a7:6a:14, seqno
205, TQ 240, TTL 49, IDF on) on interface ath0 [00:15:6d:a7:6a:9c]
