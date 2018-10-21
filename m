Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 21 Oct 2018 11:30:27 +0200
Message-Id: <20181021093032.19928-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/5] batman-adv: Tracing and debugfs
 deprecation cleanups
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

the current master branch already contains support to store debug messages
to the tracing buffer and to inform users about the deprecation of the
debugfs functionality.

This patchset is now cleaning it up a little bit more and allows to the
tracing infrastructure completely without BATMAN_ADV_DEBUGFS.

Kind regards,
	Sven

Sven Eckelmann (5):
  batman-adv: Drop unused lockdep include
  batman-adv: Add includes for deprecation warning
  batman-adv: Improve includes for trace functionality
  batman-adv: Allow to use BATMAN_ADV_DEBUG without BATMAN_ADV_DEBUGFS
  batman-adv: Fix description for BATMAN_ADV_DEBUG

 compat.h                    |  5 ----
 net/batman-adv/Kconfig      |  7 +++--
 net/batman-adv/bat_iv_ogm.c |  1 -
 net/batman-adv/debugfs.c    |  2 ++
 net/batman-adv/log.c        | 60 ++++++++++++++++++++-----------------
 net/batman-adv/trace.c      |  2 --
 net/batman-adv/trace.h      |  6 ++++
 7 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.19.1

