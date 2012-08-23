Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu, 23 Aug 2012 15:41:57 +0200
Message-Id: <1345729318-12804-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC] GSOC:bandwidth meter (batadv)
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

Hi all,

this is the final version of my google summer of code project,
"Bandwidth Meter". For a project description you can see the wiki page
and gsoc final report:

http://www.open-mesh.org/projects/batman-adv/wiki/Bandwidth_meter

http://www.open-mesh.org/projects/batman-adv/wiki/GSOC2012_BW_report

Any comment is welcome,

Edo


Edo Monticelli (1):
  batman-adv: bandwidth meter implementation

 Makefile.kbuild |    1 +
 bw_meter.c      |  622 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h      |    7 +
 icmp_socket.c   |   18 ++
 main.c          |    2 +
 packet.h        |   38 +++-
 routing.c       |   15 ++-
 types.h         |   25 +++
 8 files changed, 722 insertions(+), 6 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

-- 
1.7.8.6
