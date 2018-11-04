Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun,  4 Nov 2018 20:34:06 +0100
Message-Id: <20181104193408.18253-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [RFC 0/2] batctl: netlink restructuring, part 3
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

As mentioned earlier, the netlink config restructuring in batctl will be
splitted in multiple steps. The first step was already merged and the
RFC changes for the netlink interface in batman-adv were just posted.

Since it doesn't make sense to have a full implementation in batctl when
the batman-adv part is not yet in a finished state. But it also is useless
to have only the batman-adv RFC part without a userspace tool. The
(by default disabled) config subcommand is (my) solution for this problem.
It allows developers to play around with this interface and assign new
values for specific keys and to read the current config state.

Make sure that you enable it during the build:

  $ make clean; make CONFIG_config=y

Kind regards,
	Sven

Sven Eckelmann (2):
  batctl: Add generic netlink configuration subcommand
  batctl: Add support for config mcast group in event monitor

 Makefile     |   1 +
 batman_adv.h |  55 ++++++
 config.c     | 542 +++++++++++++++++++++++++++++++++++++++++++++++++++
 event.c      | 100 ++++++++++
 man/batctl.8 |  37 ++++
 netlink.c    |   3 +
 6 files changed, 738 insertions(+)
 create mode 100644 config.c

-- 
2.19.1

