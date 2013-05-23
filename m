Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 23 May 2013 23:21:05 +0200
Message-Id: <1369344072-23916-1-git-send-email-siwu@hrz.tu-chemnitz.de>
Subject: [B.A.T.M.A.N.] [RFC 0/7] add network wide multi interface
	optimization
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
Cc: Simon Wunderlich <simon@open-mesh.com>

From: Simon Wunderlich <simon@open-mesh.com>

This patchset adds the network wide multi interface optimization as
proposed in our wiki [1] for BATMAN IV. The main purpose is to do
interface alternating and bonding by considering multi interface
capabilities globally and not just for the (next) link, otherwise
non-optimal links may be chosen.

This patchset needs to change a lot of core data structures and
routing, please review it carefully. It is based on the current master
plus the "batman-adv: forward late OGMs from best next hop" patch. A
local development branch exists on the public git repo [2].

Things to discuss from my end are:
 * are there any metric proposals for the wifi half duplex penalty? I've
   just used "half" for now, but this makes the TQ degrade very quickly
   over the links. 
 * Note also that this change will generally change the TQ propagation
   behaviour even for single interface networks, i.e. the TQ will degrade
   fast in any case in this networks after this change. This is inevitable
   if we want to mix single/multi interface devices
 * anything to consider for network coding?
 * this code was used in my virtual VMs only, I'd like to test it on
   multi-interface devices if the direction I go here can be confirmed. :)

As always, any comments are appreciated!

Thanks,
	Simon

[1] http://www.open-mesh.org/projects/batman-adv/wiki/network-wide-multi-link-optimization
[2] http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/simon/network-wide-multiif

Simon Wunderlich (7):
  batman-adv: remove useless find_router look up
  batman-adv: remove bonding and interface alternating
  batman-adv: split tq information in neigh_node struct
  batman-adv: split out router from orig_node
  batman-adv: add WiFi penalty
  batman-adv: consider outgoing interface in OGM sending
  batman-adv: add bonding again

 bat_iv_ogm.c            |  654 +++++++++++++++++++++++++++++++----------------
 distributed-arp-table.c |    3 +-
 gateway_client.c        |   78 ++++--
 hard-interface.c        |    2 +-
 hard-interface.h        |    1 +
 icmp_socket.c           |    2 +-
 network-coding.c        |    9 +-
 originator.c            |  324 ++++++++++++++++++++---
 originator.h            |   14 +-
 routing.c               |  413 ++++++++++--------------------
 routing.h               |   11 +-
 send.c                  |   42 ++-
 translation-table.c     |   14 +-
 types.h                 |   79 ++++--
 14 files changed, 1037 insertions(+), 609 deletions(-)

-- 
1.7.10.4

