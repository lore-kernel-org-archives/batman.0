Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu,  9 Aug 2012 14:15:23 +0200
Message-Id: <1344514526-30256-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 0/3] GSOC 2012: bandwidth meter project
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

Hi,

I have almost completed my Google Summer of Code project and I'd like to have a
feedback from the batman community. The project is a kernel-space bandwidth
meter, a lightweight tool to measure network performance between batman nodes.
You can find a general project description in the project wiki page:

http://www.open-mesh.org/projects/batman-adv/wiki/GSOC2012_BW

Any advice is welcome,
Edo Monticelli


Edo Monticelli (3):
  batman-adv: bandwidth meter implementation
  batman-adv: sender retransmission counter
  batman-adv: seqnumber is wrap around safe

 Makefile         |    2 +-
 Makefile.kbuild  |    1 +
 bw_meter.c       |  531 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h       |    7 +
 icmp_socket.c    |   18 ++
 main.c           |    2 +
 packet.h         |   22 ++-
 routing.c        |   15 ++-
 soft-interface.c |    5 +
 types.h          |   38 ++++
 10 files changed, 634 insertions(+), 7 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

-- 
1.7.8.6

