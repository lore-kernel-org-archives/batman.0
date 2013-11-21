Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 21 Nov 2013 11:52:14 +0100
Message-Id: <1385031136-15967-1-git-send-email-sw@simonwunderlich.de>
Subject: [B.A.T.M.A.N.] [PATCHv4 0/2] debugfs files for the network wide
	multi interface optimization
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

This patchset contains the remaining two debugfs patches for the network
wide multi interface optimization. There are some small changes to
the previous patchset as suggested by Marek:

 * omit the hardif directory and move hardif folders directly under $debugs/batman-adv,
   as there should be no conflict with the soft interfaces anyway
 * rename *multiif* functions to *hardif*
 * fix some outdated kerneldoc.

Thanks for all the comments on this patchset, everyone!
   Simon

Simon Wunderlich (2):
  batman-adv: add debugfs structure for information per interface
  batman-adv: add debugfs support to view multiif tables

 bat_iv_ogm.c     |   12 ++++----
 debugfs.c        |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 debugfs.h        |    2 ++
 hard-interface.c |    9 ++++++
 originator.c     |   48 +++++++++++++++++++++++++++++-
 originator.h     |    1 +
 types.h          |    5 +++-
 7 files changed, 156 insertions(+), 7 deletions(-)

-- 
1.7.10.4

