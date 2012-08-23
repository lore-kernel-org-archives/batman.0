Return-Path: <montik@autistici.org>
From: Edo Monticelli <montik@autistici.org>
Date: Thu, 23 Aug 2012 15:42:49 +0200
Message-Id: <1345729370-13614-1-git-send-email-montik@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC] GSOC:bandwidth meter
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

this patch adds the possibility to call bandwidth meter from batctl.

batctl bw <MAC>

This is part of my gsoc bandwidth meter project.
Any comment is welcome,
Edo

montik (1):
  batctl: introduced support for bandwidth meter

 Makefile     |    2 +-
 bw_meter.c   |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 bw_meter.h   |    1 +
 main.c       |    6 ++
 man/batctl.8 |   24 ++++++++-
 packet.h     |   38 +++++++++++--
 6 files changed, 231 insertions(+), 8 deletions(-)
 create mode 100644 bw_meter.c
 create mode 100644 bw_meter.h

-- 
1.7.8.6

