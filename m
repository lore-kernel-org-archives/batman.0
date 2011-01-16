Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 16 Jan 2011 03:38:45 +0100
Message-Id: <1295145527-17537-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-01-16
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi,

i would propose some smaller corrections.

The following changes since commit 53320fe3bb1b1eef1aaff8dd47aae530ebeeb1e5:

  batman-adv: Return hna count on local buffer fill (2010-12-20 10:32:03 -0800)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git for-david

Jesper Juhl (1):
      batman-adv: Even Batman should not dereference NULL pointers

Sven Eckelmann (1):
      batman-adv: Use "__attribute__" shortcut macros

 net/batman-adv/main.h    |    6 +++---
 net/batman-adv/packet.h  |   14 +++++++-------
 net/batman-adv/types.h   |    4 ++--
 net/batman-adv/unicast.c |    6 ++++--
 4 files changed, 16 insertions(+), 14 deletions(-)
