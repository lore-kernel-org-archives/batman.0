Return-Path: <laurent@wifibot.com>
Message-ID: <4E80E977.8090608@wifibot.com>
Date: Mon, 26 Sep 2011 23:07:03 +0200
From: laurent <laurent@wifibot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.2.0 hop somtimes does not work
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
To: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <ordex@autistici.org>

Hello,

I hope this time my email goes public ? just in case I put your email.

So I compiled all my node in debug with your patch:

ping from 192.168.1.105 for 192.168.1.103 not working
ping from 192.168.1.105 for 192.168.1.102 working
ping from 192.168.1.102 for 192.168.1.103 working

my test nodes are like this now: 192.168.1.105 -> 192.168.1.102 ->
192.168.1.103

00:15:6D:AB:59:E0 -> 00:15:6d:ad:d3:2b -> 00:15:6d:a3:15:2e

There is the log of the first node (192.168.1.105) , the log for
192.168.1.103 is in the end of the email

root@OpenWrt:~# batctl ll 4
root@OpenWrt:~# batctl log
[       526] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       526] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       526] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       526] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       526] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       528] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       528] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       528] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       528] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       528] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       528] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       528] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       528] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       528] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       528] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       528] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       528] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       528] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       528] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       529] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       529] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       529] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       529] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       529] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       530] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       530] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       530] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       530] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       530] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       530] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       530] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       530] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       530] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       530] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       530] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       530] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       530] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       530] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       531] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       531] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       531] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       531] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       531] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       531] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       531] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       531] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       531] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       531] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       531] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       531] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       531] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       531] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       532] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       532] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       532] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       532] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       532] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       532] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       532] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       533] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       533] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       534] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       534] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       535] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       535] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       535] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       535] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       535] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       535] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       535] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       535] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       535] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       535] Received TT_RESPONSE from 00:15:6d:a3:15:2e for ttvn 2
t_size: 2 [F]
[       535] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       535] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e): originator time out
[       535] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       535] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:a3:15:2e)
[       536] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       536] Sending TT_REQUEST to 00:15:6d:a3:15:2e via
00:15:6d:ad:d3:2b [F]
[       537] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)
[       538] TT inconsistency for 00:15:6d:a3:15:2e. Need to retrieve
the correct information (ttvn: 2 last_ttvn: 2 crc: 12524 last_crc: 49213
num_changes: 0)















batctl ll 1


q: 202, asym_penalty: 255, total tq: 190
[       643] update_originator(): Searching and updating originator
entry of received packet
[       643] Updating existing last-hop neighbor of originator
[       643] Drop packet: duplicate packet received
[       643] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1569, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       643] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3663, ttvn 2, crc 15204, changes 0, td 241, TTL
49, V 14, IDF 1)
[       643] updating last_seqno: old 3662, new 3663
[       643] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 50, real recv = 63, local tq: 202,
asym_penalty: 255, total tq: 190
[       643] update_originator(): Searching and updating originator
entry of received packet
[       643] Updating existing last-hop neighbor of originator
[       643] Forwarding packet: rebroadcast originator packet
[       643] Forwarding packet: tq_orig: 190, tq_avg: 190, tq_forw: 182,
ttl_orig: 48, ttl_forw: 48
[       643] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3663, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       643] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 780, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       643] updating last_seqno: old 779, new 780
[       643] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 50, real recv = 63, local tq: 202,
asym_penalty: 255, total tq: 202
[       643] update_originator(): Searching and updating originator
entry of received packet
[       643] Updating existing last-hop neighbor of originator
[       643] Forwarding packet: tq_orig: 202, tq_avg: 198, tq_forw: 194,
ttl_orig: 49, ttl_forw: 49
[       643] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       643] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
899, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       644] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 780, ttvn 2, crc 36959, changes 0, td 237, TTL
49, V 14, IDF 1)
[       644] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 21, real recv = 29, local tq: 184,
asym_penalty: 214, total tq: 143
[       644] update_originator(): Searching and updating originator
entry of received packet
[       644] Updating existing last-hop neighbor of originator
[       644] Drop packet: duplicate packet received
[       644] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 780,
TQ 194, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       644] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 899, ttvn 6, crc 36550, changes 0, td 229, TTL
49, V 14, IDF 1)
[       644] Drop packet: originator packet from myself (via neighbor)
[       644] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1570, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       644] updating last_seqno: old 1569, new 1570
[       644] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:a3:0f:32 => own_bcast = 21, real recv = 29, local tq: 184,
asym_penalty: 214, total tq: 148
[       644] update_originator(): Searching and updating originator
entry of received packet
[       644] Updating existing last-hop neighbor of originator
[       644] Forwarding packet: rebroadcast originator packet
[       644] Forwarding packet: tq_orig: 148, tq_avg: 190, tq_forw: 182,
ttl_orig: 48, ttl_forw: 48
[       644] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1570, ttvn 2, crc 12524, changes 0, td 241, TTL
49, V 14, IDF 1)
[       644] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 50, real recv = 63, local tq: 202,
asym_penalty: 255, total tq: 190
[       644] update_originator(): Searching and updating originator
entry of received packet
[       644] Updating existing last-hop neighbor of originator
[       644] Drop packet: duplicate packet received
[       644] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1570, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       644] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3664, ttvn 2, crc 15204, changes 0, td 245, TTL
49, V 14, IDF 1)
[       644] updating last_seqno: old 3663, new 3664
[       644] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 50, real recv = 63, local tq: 202,
asym_penalty: 255, total tq: 194
[       644] update_originator(): Searching and updating originator
entry of received packet
[       644] Updating existing last-hop neighbor of originator
[       644] Forwarding packet: rebroadcast originator packet
[       644] Forwarding packet: tq_orig: 194, tq_avg: 191, tq_forw: 186,
ttl_orig: 48, ttl_forw: 48
[       644] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3664, TQ 186, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       644] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
900, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       644] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 781, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       644] updating last_seqno: old 780, new 781
[       644] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 49, real recv = 63, local tq: 198,
asym_penalty: 255, total tq: 198
[       644] update_originator(): Searching and updating originator
entry of received packet
[       644] Updating existing last-hop neighbor of originator
[       644] Forwarding packet: tq_orig: 198, tq_avg: 198, tq_forw: 190,
ttl_orig: 49, ttl_forw: 49
[       644] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       645] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 781,
TQ 190, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       645] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1571, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       645] updating last_seqno: old 1570, new 1571
[       645] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:a3:0f:32 => own_bcast = 21, real recv = 28, local tq: 191,
asym_penalty: 210, total tq: 151
[       645] update_originator(): Searching and updating originator
entry of received packet
[       645] Updating existing last-hop neighbor of originator
[       645] Forwarding packet: rebroadcast originator packet
[       645] Forwarding packet: tq_orig: 151, tq_avg: 190, tq_forw: 182,
ttl_orig: 48, ttl_forw: 48
[       645] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1571, ttvn 2, crc 12524, changes 0, td 241, TTL
49, V 14, IDF 1)
[       645] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 49, real recv = 63, local tq: 198,
asym_penalty: 255, total tq: 187
[       645] update_originator(): Searching and updating originator
entry of received packet
[       645] Updating existing last-hop neighbor of originator
[       645] Drop packet: duplicate packet received
[       645] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1571, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       645] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3665, ttvn 2, crc 15204, changes 0, td 245, TTL
49, V 14, IDF 1)
[       645] updating last_seqno: old 3664, new 3665
[       645] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 49, real recv = 63, local tq: 198,
asym_penalty: 255, total tq: 190
[       645] update_originator(): Searching and updating originator
entry of received packet
[       645] Updating existing last-hop neighbor of originator
[       645] Forwarding packet: rebroadcast originator packet
[       645] Forwarding packet: tq_orig: 190, tq_avg: 190, tq_forw: 182,
ttl_orig: 48, ttl_forw: 48
[       645] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3665, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       645] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 782, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       645] updating last_seqno: old 781, new 782
[       645] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 49, real recv = 63, local tq: 198,
asym_penalty: 255, total tq: 198
[       645] update_originator(): Searching and updating originator
entry of received packet
[       645] Updating existing last-hop neighbor of originator
[       645] Forwarding packet: tq_orig: 198, tq_avg: 198, tq_forw: 190,
ttl_orig: 49, ttl_forw: 49
[       645] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       645] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
901, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       646] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 782,
TQ 190, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       646] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 901, ttvn 6, crc 36550, changes 0, td 234, TTL
49, V 14, IDF 1)
[       646] Drop packet: originator packet from myself (via neighbor)
[       646] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1572, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       646] updating last_seqno: old 1571, new 1572
[       646] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:a3:0f:32 => own_bcast = 20, real recv = 28, local tq: 182,
asym_penalty: 210, total tq: 144
[       646] update_originator(): Searching and updating originator
entry of received packet
[       646] Updating existing last-hop neighbor of originator
[       646] Forwarding packet: rebroadcast originator packet
[       646] Forwarding packet: tq_orig: 144, tq_avg: 188, tq_forw: 180,
ttl_orig: 48, ttl_forw: 48
[       646] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1572, TQ 180, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       646] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3666, ttvn 2, crc 15204, changes 0, td 245, TTL
49, V 14, IDF 1)
[       646] updating last_seqno: old 3665, new 3666
[       646] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 49, real recv = 63, local tq: 198,
asym_penalty: 255, total tq: 190
[       646] update_originator(): Searching and updating originator
entry of received packet
[       646] Updating existing last-hop neighbor of originator
[       646] Forwarding packet: rebroadcast originator packet
[       646] Forwarding packet: tq_orig: 190, tq_avg: 190, tq_forw: 182,
ttl_orig: 48, ttl_forw: 48
[       646] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3666, TQ 182, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       646] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 783, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)






batctl ll 2


root@OpenWrt:~# batctl ll 2
root@OpenWrt:~# batctl log
:0f:32, seqno 3742, ttvn 2, crc 15204, changes 0, td 245, TTL 49, V 14,
IDF 1)
[       721] updating last_seqno: old 3741, new 3742
[       721] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 202
[       721] update_originator(): Searching and updating originator
entry of received packet
[       721] Updating existing last-hop neighbor of originator
[       721] Forwarding packet: rebroadcast originator packet
[       721] Forwarding packet: tq_orig: 202, tq_avg: 202, tq_forw: 194,
ttl_orig: 48, ttl_forw: 48
[       721] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3742, TQ 194, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       722] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 859, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       722] updating last_seqno: old 858, new 859
[       722] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 211
[       722] update_originator(): Searching and updating originator
entry of received packet
[       722] Updating existing last-hop neighbor of originator
[       722] Forwarding packet: tq_orig: 211, tq_avg: 211, tq_forw: 202,
ttl_orig: 49, ttl_forw: 49
[       722] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       722] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
978, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       722] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 859,
TQ 202, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       722] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 978, ttvn 6, crc 36550, changes 0, td 245, TTL
49, V 14, IDF 1)
[       722] Drop packet: originator packet from myself (via neighbor)
[       722] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 978, ttvn 6, crc 36550, changes 0, td 231, TTL
48, V 14, IDF 1)
[       722] Drop packet: originator packet from myself (via neighbor)
[       722] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1649, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       722] updating last_seqno: old 1648, new 1649
[       722] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 202
[       722] update_originator(): Searching and updating originator
entry of received packet
[       722] Updating existing last-hop neighbor of originator
[       722] Forwarding packet: rebroadcast originator packet
[       722] Forwarding packet: tq_orig: 202, tq_avg: 202, tq_forw: 194,
ttl_orig: 48, ttl_forw: 48
[       722] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1649, TQ 194, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       722] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3743, ttvn 2, crc 15204, changes 0, td 255, TTL
50, V 14, IDF 0)
[       722] updating last_seqno: old 3742, new 3743
[       722] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 21, real recv = 31, local tq: 172,
asym_penalty: 221, total tq: 149
[       722] update_originator(): Searching and updating originator
entry of received packet
[       722] Updating existing last-hop neighbor of originator
[       722] Forwarding packet: tq_orig: 149, tq_avg: 202, tq_forw: 194,
ttl_orig: 49, ttl_forw: 48
[       722] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       722] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3743, TQ 194, TTL 48, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       722] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3743, ttvn 2, crc 15204, changes 0, td 245, TTL
49, V 14, IDF 1)
[       722] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 202
[       722] update_originator(): Searching and updating originator
entry of received packet
[       722] Updating existing last-hop neighbor of originator
[       722] Drop packet: duplicate packet received
[       723] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 860, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       723] updating last_seqno: old 859, new 860
[       723] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 211
[       723] update_originator(): Searching and updating originator
entry of received packet
[       723] Updating existing last-hop neighbor of originator
[       723] Forwarding packet: tq_orig: 211, tq_avg: 211, tq_forw: 202,
ttl_orig: 49, ttl_forw: 49
[       723] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       723] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
979, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       723] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 860,
TQ 202, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       723] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 979, ttvn 6, crc 36550, changes 0, td 245, TTL
49, V 14, IDF 1)
[       723] Drop packet: originator packet from myself (via neighbor)
[       723] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 979, ttvn 6, crc 36550, changes 0, td 233, TTL
48, V 14, IDF 1)
[       723] Drop packet: originator packet from myself (via neighbor)
[       723] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1650, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       723] updating last_seqno: old 1649, new 1650
[       723] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 53, real recv = 64, local tq: 211,
asym_penalty: 255, total tq: 202
[       723] update_originator(): Searching and updating originator
entry of received packet
[       723] Updating existing last-hop neighbor of originator
[       723] Forwarding packet: rebroadcast originator packet
[       723] Forwarding packet: tq_orig: 202, tq_avg: 202, tq_forw: 194,
ttl_orig: 48, ttl_forw: 48
[       723] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1650, TQ 194, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       723] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3744, ttvn 2, crc 15204, changes 0, td 255, TTL
50, V 14, IDF 0)
[       723] updating last_seqno: old 3743, new 3744
[       723] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 21, real recv = 32, local tq: 167,
asym_penalty: 224, total tq: 146
[       723] update_originator(): Searching and updating originator
entry of received packet
[       723] Updating existing last-hop neighbor of originator
[       723] Forwarding packet: tq_orig: 146, tq_avg: 202, tq_forw: 194,
ttl_orig: 49, ttl_forw: 48
[       723] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       723] log_level: Changing from: 1 to: 2


batctl ll 3


[       825] update_originator(): Searching and updating originator
entry of received packet
[       825] Updating existing last-hop neighbor of originator
[       825] Drop packet: duplicate packet received
[       826] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
1083, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       826] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1083, ttvn 6, crc 36550, changes 0, td 206, TTL
49, V 14, IDF 1)
[       826] Drop packet: originator packet from myself (via neighbor)
[       826] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1083, ttvn 6, crc 36550, changes 0, td 201, TTL
48, V 14, IDF 1)
[       826] Drop packet: originator packet from myself (via neighbor)
[       826] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:0f:32, seqno 1754, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 0)
[       826] updating last_seqno: old 1753, new 1754
[       826] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 64, local tq: 231,
asym_penalty: 255, total tq: 221
[       826] update_originator(): Searching and updating originator
entry of received packet
[       826] Updating existing last-hop neighbor of originator
[       826] Forwarding packet: rebroadcast originator packet
[       826] Forwarding packet: tq_orig: 221, tq_avg: 221, tq_forw: 212,
ttl_orig: 48, ttl_forw: 48
[       827] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 965,
TQ 224, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       827] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 965, ttvn 2, crc 36959, changes 0, td 245, TTL
49, V 14, IDF 1)
[       827] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 24, real recv = 28, local tq: 218,
asym_penalty: 210, total tq: 172
[       827] update_originator(): Searching and updating originator
entry of received packet
[       827] Updating existing last-hop neighbor of originator
[       827] Drop packet: duplicate packet received
[       827] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1755, TQ 212, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       827] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3849, ttvn 2, crc 15204, changes 0, td 241, TTL
49, V 14, IDF 1)
[       827] updating last_seqno: old 3848, new 3849
[       827] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 221
[       827] update_originator(): Searching and updating originator
entry of received packet
[       827] Updating existing last-hop neighbor of originator
[       827] Forwarding packet: rebroadcast originator packet
[       827] Forwarding packet: tq_orig: 221, tq_avg: 219, tq_forw: 212,
ttl_orig: 48, ttl_forw: 48
[       827] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3849, TQ 212, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       827] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 966, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       827] updating last_seqno: old 965, new 966
[       827] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 234
[       827] update_originator(): Searching and updating originator
entry of received packet
[       827] Updating existing last-hop neighbor of originator
[       827] Forwarding packet: tq_orig: 234, tq_avg: 232, tq_forw: 224,
ttl_orig: 49, ttl_forw: 49
[       827] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       828] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 966,
TQ 224, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       828] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 966, ttvn 2, crc 36959, changes 0, td 245, TTL
49, V 14, IDF 1)
[       828] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 23, real recv = 27, local tq: 217,
asym_penalty: 206, total tq: 168
[       828] update_originator(): Searching and updating originator
entry of received packet
[       828] Updating existing last-hop neighbor of originator
[       828] Drop packet: duplicate packet received
[       828] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
1085, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       828] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1085, ttvn 6, crc 36550, changes 0, td 206, TTL
49, V 14, IDF 1)
[       828] Drop packet: originator packet from myself (via neighbor)
[       828] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1756, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       828] updating last_seqno: old 1755, new 1756
[       828] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:a3:0f:32 => own_bcast = 22, real recv = 27, local tq: 207,
asym_penalty: 206, total tq: 160
[       828] update_originator(): Searching and updating originator
entry of received packet
[       828] Updating existing last-hop neighbor of originator
[       828] Forwarding packet: rebroadcast originator packet
[       828] Forwarding packet: tq_orig: 160, tq_avg: 222, tq_forw: 213,
ttl_orig: 48, ttl_forw: 48
[       828] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:0f:32, seqno 1756, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 0)
[       828] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 224
[       828] update_originator(): Searching and updating originator
entry of received packet
[       828] Updating existing last-hop neighbor of originator
[       828] Drop packet: duplicate packet received
[       828] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1756, TQ 213, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       828] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3850, ttvn 2, crc 15204, changes 0, td 241, TTL
49, V 14, IDF 1)
[       828] updating last_seqno: old 3849, new 3850
[       828] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 221
[       828] update_originator(): Searching and updating originator
entry of received packet
[       828] Updating existing last-hop neighbor of originator
[       828] Forwarding packet: rebroadcast originator packet
[       828] Forwarding packet: tq_orig: 221, tq_avg: 219, tq_forw: 212,
ttl_orig: 48, ttl_forw: 48
[       828] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3850, TQ 212, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       828] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 967, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       828] updating last_seqno: old 966, new 967
[       828] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 234
[       828] update_originator(): Searching and updating originator
entry of received packet
[       828] Updating existing last-hop neighbor of originator
[       828] Forwarding packet: tq_orig: 234, tq_avg: 232, tq_forw: 224,
ttl_orig: 49, ttl_forw: 49
[       828] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       829] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 967,
TQ 224, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       829] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
1086, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       829] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1086, ttvn 6, crc 36550, changes 0, td 206, TTL
49, V 14, IDF 1)
[       829] Drop packet: originator packet from myself (via neighbor)
[       829] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1086, ttvn 6, crc 36550, changes 0, td 197, TTL
48, V 14, IDF 1)
[       829] Drop packet: originator packet from myself (via neighbor)
[       829] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 1757, ttvn 2, crc 12524, changes 0, td 245, TTL
49, V 14, IDF 1)
[       829] updating last_seqno: old 1756, new 1757
[       829] bidirectional: orig = 00:15:6d:a3:15:2e neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 224
[       829] update_originator(): Searching and updating originator
entry of received packet
[       829] Updating existing last-hop neighbor of originator
[       829] Forwarding packet: rebroadcast originator packet
[       829] Forwarding packet: tq_orig: 224, tq_avg: 224, tq_forw: 215,
ttl_orig: 48, ttl_forw: 48
[       829] Forwarding packet (originator 00:15:6d:a3:15:2e, seqno
1757, TQ 215, TTL 48, IDF off, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       829] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3851, ttvn 2, crc 15204, changes 0, td 255, TTL
50, V 14, IDF 0)
[       829] updating last_seqno: old 3850, new 3851
[       829] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 23, real recv = 28, local tq: 209,
asym_penalty: 210, total tq: 172
[       829] update_originator(): Searching and updating originator
entry of received packet
[       829] Updating existing last-hop neighbor of originator
[       829] Forwarding packet: tq_orig: 172, tq_avg: 220, tq_forw: 211,
ttl_orig: 49, ttl_forw: 48
[       829] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       829] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
3851, TQ 211, TTL 48, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       829] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 3851, ttvn 2, crc 15204, changes 0, td 241, TTL
49, V 14, IDF 1)
[       829] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 221
[       829] update_originator(): Searching and updating originator
entry of received packet
[       829] Updating existing last-hop neighbor of originator
[       829] Drop packet: duplicate packet received
[       829] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 968, ttvn 2, crc 36959, changes 0, td 255, TTL
50, V 14, IDF 0)
[       829] updating last_seqno: old 967, new 968
[       829] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 58, real recv = 63, local tq: 234,
asym_penalty: 255, total tq: 234
[       829] update_originator(): Searching and updating originator
entry of received packet
[       829] Updating existing last-hop neighbor of originator
[       829] Forwarding packet: tq_orig: 234, tq_avg: 233, tq_forw: 224,
ttl_orig: 49, ttl_forw: 49
[       829] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[       830] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno 968,
TQ 224, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:ab:59:e0]
[       830] Sending own packet (originator 00:15:6d:ab:59:e0, seqno
1087, TQ 255, TTL 50, IDF off, hvn 6) on interface ath0 [00:15:6d:ab:59:e0]
[       830] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:ab:59:e0] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 1087, ttvn 6, crc 36550, changes 0, td 206, TTL
49, V 14, IDF 1)
[       830] Drop packet: originator packet from myself (via neighbor)

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


log batctl ll 4 from 192.168.1.103

[      3588] Creating new global tt entry: 15:6d:a3:15:2e:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:59:e0:09:00 (via
00:15:6d:ab:59
[      3588] TT inconsistency for 00:15:6d:ab:59:e0. Need to retrieve
the correc
[      3588] Sending TT_REQUEST to 00:15:6d:ab:59:e0 via
00:15:6d:a3:0f:32 [F]
[      3588] Received TT_RESPONSE from 00:15:6d:ab:59:e0 for ttvn 9
t_size: 9 [F
[      3588] Deleting global tt entry 00:00:00:00:00:00 (via
00:15:6d:ab:59:e0):
[      3588] Deleting global tt entry 00:00:59:e0:09:00 (via
00:15:6d:ab:59:e0):
[      3588] Deleting global tt entry 00:01:00:00:00:00 (via
00:15:6d:ab:59:e0):
[      3588] Deleting global tt entry 15:6d:a3:15:2e:00 (via
00:15:6d:ab:59:e0):
[      3588] Deleting global tt entry 00:00:00:00:00:05 (via
00:15:6d:ab:59:e0):
[      3588] Creating new global tt entry: 00:01:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:00:00:00:05 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 15:6d:a3:15:2e:00 (via
00:15:6d:ab:59
[      3588] Creating new global tt entry: 00:00:59:e0:09:00 (via
00:15:6d:ab:59
[      3589] TT inconsistency for 00:15:6d:ab:59:e0. Need to retrieve
the correc
[      3589] Sending TT_REQUEST to 00:15:6d:ab:59:e0 via
00:15:6d:a3:0f:32 [F]
[      3589] Received TT_RESPONSE from 00:15:6d:ab:59:e0 for ttvn 9
t_size: 9 [F



batctl ll 3

[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6
[      3738] Drop packet: originator packet from myself (via neighbor)
[      3738] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6
[      3738] Drop packet: originator packet from myself (via neighbor)
[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6
[      3738] updating last_seqno: old 3237, new 3238
[      3738] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b =
[      3738] update_originator(): Searching and updating originator
entry of rec
[      3738] Updating existing last-hop neighbor of originator
[      3738] Forwarding packet: tq_orig: 247, tq_avg: 247, tq_forw: 237,
ttl_ori
[      3738] Forwarding packet: rebroadcast neighbor packet with direct
link fla
[      3739] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6
[      3739] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 =
[      3739] update_originator(): Searching and updating originator
entry of rec
[      3739] Updating existing last-hop neighbor of originator
[      3739] Drop packet: duplicate packet received
[      3739] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno
3238, TQ 237
[      3739] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6
[      3739] updating last_seqno: old 6121, new 6122
[      3739] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 =
[      3739] update_originator(): Searching and updating originator
entry of rec
[      3739] Updating existing last-hop neighbor of originator
[      3739] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245,
ttl_ori
- log3 46/580 7%
0 [00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6121, ttvn 2, crc 15204, changes 0, td 255, TTL
50, V 14, IDF 0)
[      3738] updating last_seqno: old 6120, new 6121
[      3738] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 255
[      3738] update_originator(): Searching and updating originator
entry of received packet
[      3738] Updating existing last-hop neighbor of originator
[      3738] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245,
ttl_orig: 49, ttl_forw: 49
[      3738] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      3738] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
6121, TQ 245, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6121, ttv
[      3738] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 62, real recv = 64, local tq: 247,
asym_penalty: 255, total tq: 237
[      3738] update_originator(): Searching and updating originator
entry of received packet
[      3738] Updating existing last-hop neighbor of originator
[      3738] Drop packet: duplicate packet received
[      3738] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 3356, ttv
[      3738] updating last_seqno: old 3355, new 3356
[      3738] bidirectional: orig = 00:15:6d:ab:59:e0 neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 186
[      3738] update_originator(): Searching and updating originator
entry of received packet
[      3738] Updating existing last-hop neighbor of originator
[      3738] Forwarding packet: rebroadcast originator packet
[      3738] Forwarding packet: tq_orig: 186, tq_avg: 191, tq_forw: 178,
ttl_orig: 47, ttl_forw: 47
[      3738] Forwarding packet (originator 00:15:6d:ab:59:e0, seqno
3356, TQ 178, TTL 47, IDF off, hvn 9) on interface ath0 [00:15:6d:a3:15:2e]
[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:a3:0f:32, seqno 3356, ttv
[      3738] Drop packet: ignoring all rebroadcast packets that may make
me loop (sender: 00:15:6d:ad:d3:2b)
[      3738] Sending own packet (originator 00:15:6d:a3:15:2e, seqno
4027, TQ 255, TTL 50, IDF off, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4027, ttv
[      3738] Drop packet: originator packet from myself (via neighbor)
[      3738] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4027, ttv
[      3738] Drop packet: originator packet from myself (via neighbor)
[      3738] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3238, ttv
[      3738] updating last_seqno: old 3237, new 3238
[      3738] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 62, real recv = 64, local tq: 247,
asym_penalty: 255, total tq: 247
[      3738] update_originator(): Searching and updating originator
entry of received packet
[      3738] Updating existing last-hop neighbor of originator
[      3738] Forwarding packet: tq_orig: 247, tq_avg: 247, tq_forw: 237,
ttl_orig: 49, ttl_forw: 49
[      3738] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      3739] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3238, ttv
[      3739] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 241
[      3739] update_originator(): Searching and updating originator
entry of received packet
[      3739] Updating existing last-hop neighbor of originator
[      3739] Drop packet: duplicate packet received
[      3739] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno
3238, TQ 237, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      3739] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6122, ttv
[      3739] updating last_seqno: old 6121, new 6122
[      3739] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 255
[      3739] update_originator(): Searching and updating originator
entry of received packet
- log3 1/580 0%


batctl ll 2

-
root@OpenWrt:/tmp# clear
root@OpenWrt:/tmp# vi log2
  3938] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4229, ttvn 2,
[      3938] Drop packet: originator packet from myself (via neighbor)
[      3938] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4229, ttv
[      3938] Drop packet: originator packet from myself (via neighbor)
[      3939] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6324, ttv
[      3939] updating last_seqno: old 6323, new 6324
[      3939] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 63, real recv = 63, local tq: 255,
asym_penalty: 255, total tq: 255
[      3939] update_originator(): Searching and updating originator
entry of received packet
[      3939] Updating existing last-hop neighbor of originator
[      3939] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245,
ttl_orig: 49, ttl_forw: 49
[      3939] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      3939] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
6324, TQ 245, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      3939] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6324, ttv
[      3939] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 63, real recv = 64, local tq: 251,
asym_penalty: 255, total tq: 241
[      3939] update_originator(): Searching and updating originator
entry of received packet
[      3939] Updating existing last-hop neighbor of originator
[      3939] Drop packet: duplicate packet received
[      3939] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3441, ttv
[      3939] updating last_seqno: old 3440, new 3441
[      3939] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 63, real recv = 64, local tq: 251,
asym_penalty: 255, total tq: 251
[      3939] update_originator(): Searching and updating originator
entry of received packet
[      3939] Updating existing last-hop neighbor of originator
[      3939] Forwarding packet: tq_orig: 251, tq_avg: 251, tq_forw: 241,
ttl_orig: 49, ttl_forw: 49
[      3939] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      3939] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3441, ttv
[      3939] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 63, real recv = 63, local tq: 255,
asym_penalty: 255, total tq: 245
[      3939] update_originator(): Searching and updating originator
entry of received packet
[      3939] Updating existing last-hop neighbor of originator
[      3939] Drop packet: duplicate packet received
[      3939] Forwarding packet (originator 00:15:6d:ad:d3:2b, seqno
3441, TQ 241, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      3939] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 3559, ttv
[      3939] updating last_seqno: old 3558, new 3559
[      3939] bidirectional: orig = 00:15:6d:ab:59:e0 neigh =
00:15:6d:ad:d3:2b => own_bcast = 63, real recv = 64, local tq: 251,
asym_penalty: 255, total tq: 241
[      3939] update_originator(): Searching and


batctl ll 1

root@OpenWrt:/tmp# clear
root@OpenWrt:/tmp# vi log1
riginator 00:15:6d:ad:d3:2b, seqno 3515, TQ 235, TTL 48, IDF on, hvn 2)
on interface ath0 [00:15:6d:a3:15:2e]
[      4012] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3515, ttv
[      4012] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 245
[      4012] update_originator(): Searching and updating originator
entry of received packet
[      4012] Updating existing last-hop neighbor of originator
[      4012] Drop packet: duplicate packet received
[      4012] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 3633, ttv
[      4012] updating last_seqno: old 3632, new 3633
[      4012] bidirectional: orig = 00:15:6d:ab:59:e0 neigh =
00:15:6d:ad:d3:2b => own_bcast = 60, real recv = 64, local tq: 239,
asym_penalty: 255, total tq: 196
[      4012] update_originator(): Searching and updating originator
entry of received packet
[      4012] Updating existing last-hop neighbor of originator
[      4012] Forwarding packet: rebroadcast originator packet
[      4012] Forwarding packet: tq_orig: 196, tq_avg: 206, tq_forw: 197,
ttl_orig: 48, ttl_forw: 47
[      4012] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 3633, ttv
[      4012] bidirectional: orig = 00:15:6d:ab:59:e0 neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 206
[      4012] update_originator(): Searching and updating originator
entry of received packet
[      4012] Updating existing last-hop neighbor of originator
[      4012] Drop packet: duplicate packet received
[      4013] Forwarding packet (originator 00:15:6d:ab:59:e0, seqno
3633, TQ 197, TTL 47, IDF off, hvn 9) on interface ath0 [00:15:6d:a3:15:2e]
[      4013] Sending own packet (originator 00:15:6d:a3:15:2e, seqno
4304, TQ 255, TTL 50, IDF off, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      4013] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4304, ttv
[      4013] Drop packet: originator packet from myself (via neighbor)
[      4013] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:15:2e, via prev OG:
00:15:6d:a3:15:2e, seqno 4304, ttv
[      4013] Drop packet: originator packet from myself (via neighbor)
[      4013] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6399, ttv
[      4013] updating last_seqno: old 6398, new 6399
[      4013] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:a3:0f:32 => own_bcast = 64, real recv = 64, local tq: 255,
asym_penalty: 255, total tq: 255
[      4013] update_originator(): Searching and updating originator
entry of received packet
[      4013] Updating existing last-hop neighbor of originator
[      4013] Forwarding packet: tq_orig: 255, tq_avg: 255, tq_forw: 245,
ttl_orig: 49, ttl_forw: 49
[      4013] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      4013] Forwarding packet (originator 00:15:6d:a3:0f:32, seqno
6399, TQ 245, TTL 49, IDF on, hvn 2) on interface ath0 [00:15:6d:a3:15:2e]
[      4013] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:a3:0f:32, via prev OG:
00:15:6d:a3:0f:32, seqno 6399, ttv
[      4013] bidirectional: orig = 00:15:6d:a3:0f:32 neigh =
00:15:6d:ad:d3:2b => own_bcast = 60, real recv = 64, local tq: 239,
asym_penalty: 255, total tq: 229
[      4013] update_originator(): Searching and updating originator
entry of received packet
[      4013] Updating existing last-hop neighbor of originator
[      4013] Drop packet: duplicate packet received
[      4013] Received BATMAN packet via NB: 00:15:6d:ad:d3:2b, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ad:d3:2b, via prev OG:
00:15:6d:ad:d3:2b, seqno 3516, ttv
[      4013] updating last_seqno: old 3515, new 3516
[      4013] bidirectional: orig = 00:15:6d:ad:d3:2b neigh =
00:15:6d:ad:d3:2b => own_bcast = 60, real recv = 64, local tq: 239,
asym_penalty: 255, total tq: 239
[      4013] update_originator(): Searching and updating originator
entry of received packet
[      4013] Updating existing last-hop neighbor of originator
[      4013] Forwarding packet: tq_orig: 239, tq_avg: 245, tq_forw: 235,
ttl_orig: 49, ttl_forw: 48
[      4013] Forwarding packet: rebroadcast neighbor packet with direct
link flag
[      4013] Received BATMAN packet via NB: 00:15:6d:a3:0f:32, IF: ath0
[00:15:6d:a3:15:2e] (from OG: 00:15:6d:ab:59:e0, via prev OG:
00:15:6d:ab:59:e0, seqno 3634, ttv
- log1 15/479 3%




