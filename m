Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Thu, 18 Feb 2016 18:25:52 +0100
Message-ID: <6595687.FqdJJADTWg@bentobox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] [RFC 0/5] batman-adv: Throughput meter
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
Cc: Edo Monticelli <montik@autistici.org>

Hi,

do you still remember GSOC 2012? Yes, it is really long ago. It was a time
when winters were still cold, summers still hot and it was still politically
correct to say "bandwidth meter" when you actually meant "throughput meter".

Three students tried their best to implement some of the ideas floating around
in the B.A.T.M.A.N. advanced community. And after some more work, most of the
features reached the finishing line. TVLV [1] and the fragmentation v2 [2]
were both integrated as part of the COMPAT 15 bump. But the "bandwidth
meter" [3] was never ready to being merged.

Nevertheless, the lessons learned in the first implementation [4] inspired
different people to continue working on it. Especially Antonio Quartulli
worked on his own version to increase its usefulness. And this feature makes
even more sense since we reached the new "throughput based metric" time epoch
with the introduction of B.A.T.M.A.N. V.

I hope we can reignite interest in this feature with a rebased and refurbished
version of this patchset. Both the batman-adv and batctl patches are based on
the newest revision in their respective master branches. Also a branch called
"tp_meter" was created in the batctl.git and batman-adv.git repository with
these patches already applied.


batman-adv
==========

Antonio Quartulli (2):
      batman-adv: return netdev status in the TX path
      batman-adv: use another ICMP packet when sending command from userspace
      batman-adv: throughput meter implementation

Sven Eckelmann (1):
      batman-adv: Add compatibility code for to_delayed_work


 compat-include/linux/netdevice.h |   17 +
 compat-include/linux/workqueue.h |   46 ++
 net/batman-adv/Makefile          |    1 +
 net/batman-adv/fragmentation.c   |   41 +-
 net/batman-adv/fragmentation.h   |    6 +-
 net/batman-adv/icmp_socket.c     |  225 +++---
 net/batman-adv/icmp_socket.h     |    5 +-
 net/batman-adv/main.c            |    6 +-
 net/batman-adv/main.h            |   24 +-
 net/batman-adv/packet.h          |  120 ++++
 net/batman-adv/routing.c         |   33 +-
 net/batman-adv/send.c            |   25 +-
 net/batman-adv/soft-interface.c  |    2 +
 net/batman-adv/tp_meter.c        | 1451 ++++++++++++++++++++++++++++++++++++++
 net/batman-adv/tp_meter.h        |   34 +
 net/batman-adv/types.h           |  113 +++
 16 files changed, 2005 insertions(+), 144 deletions(-)



batctl
======

Antonio Quartulli (1):
      batctl: introduce throughput meter support


 Makefile     |   2 +-
 main.c       |   6 ++
 man/batctl.8 |  24 ++++++-
 packet.h     | 120 +++++++++++++++++++++++++++++++
 tcpdump.c    |  14 +++-
 tp_meter.c   | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tp_meter.h   |  22 ++++++
 7 files changed, 411 insertions(+), 4 deletions(-)

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/2012-10-01-GSoC-2012-Spyros-Gasteros-Final-Report
[2] https://www.open-mesh.org/projects/open-mesh/wiki/2012-09-24-GSoC-2012-Martin-Hundebolls-Final-Report
[3] https://www.open-mesh.org/projects/open-mesh/wiki/2012-10-06-GSoC-2012-Edo-Monticellis-Final-Report
[4] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-August/007924.html

