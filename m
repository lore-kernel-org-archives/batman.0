Return-Path: <martin@hundeboll.net>
From: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>
Date: Mon, 20 Aug 2012 13:48:07 +0200
Message-Id: <1345463292-19712-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 0/5] GSoC: New Fragmentation
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
Cc: =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@hundeboll.net>

Hi All,

This is a Request for Comments on my GSoC product: A new fragmentation implementation. The new fragmentation code supports more than two fragments and more than just one type of unicast packets. It works by checking the size of the packet after it is prepended with its own unicast-like header. If fragmentation is needed, each fragment is encapsulated with the fragmentation code. When merged at either an intermediate hop or the destination, the packet is delivered to its corresponding handler, which knows nothing about fragmentation.

A brief[1] and more technical[2] description of the new design is available on project-wiki.

[1] http://www.open-mesh.org/projects/open-mesh/wiki/gsoc2012-hundeboll-final-report
[2] http://www.open-mesh.org/projects/batman-adv/wiki/Fragmentation

The first patch provides a wrapper for the lookup of the best next-hop for unicast packets, which was essentially boiler plate code in several functions. Later this will ease the fragmentation code, which needs to know both the final destination and the next hop, and thus is called from within this wrapper.

The second patch removes the old fragmentation code, but leaves behind the creation of a configuration file in sysfs, used to disable/enable fragmentation.

The third patch provides support for processing received fragments. These are either:
* Forwarded if the size of the merged packet would lead to refragmentation.
* Buffered for later merge.
* Used to merge the original packet if all fragments are received.

The fourth patch inserts a size check of outgoing packets and fragmentation if needed. The size of fragments are limited to 1400 bytes to avoid teh need merge-and-fragment at intermediate hops with an MTU lower than that of the original fragmenter.

The fifth patch modifies the announcement of clients to be aware of the new limit on packet sizes. It now ignores new clients if it would make the local table too big to send in a (fragmented) full table response.

Comments are welcome!

Martin Hundebøll (5):
  batman-adv: Add wrapper to look up neighbor and send skb
  batman-adv: Remove old fragmentation code
  batman-adv: Receive fragmented packets and merge
  batman-adv: Fragment and send skbs larger than mtu
  batman-adv: Limit local translation table max packet size

 Makefile.kbuild     |   2 +-
 fragmentation.c     | 493 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fragmentation.h     |  56 ++++++
 hard-interface.c    |  26 ++-
 main.c              |   5 +-
 main.h              |   4 +
 originator.c        |  17 +-
 packet.h            |  34 ++--
 routing.c           | 150 ++++++----------
 routing.h           |   2 +
 send.c              |  92 ++++++++++
 send.h              |   4 +
 soft-interface.c    |  22 ++-
 translation-table.c | 251 +++++++++++++++++---------
 translation-table.h |   3 +-
 types.h             |  39 +++++
 unicast.c           | 373 ---------------------------------------
 unicast.h           |  58 -------
 vis.c               |  35 +---
 19 files changed, 995 insertions(+), 671 deletions(-)
 create mode 100644 fragmentation.c
 create mode 100644 fragmentation.h
 delete mode 100644 unicast.c
 delete mode 100644 unicast.h

-- 
1.7.11.5

