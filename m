Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 May 2011 00:16:32 +0200
Message-Id: <1305411394-28807-1-git-send-email-sven@narfation.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2011-05-14
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

I would like tp propose following corrections for net-next-2.6/2.6.40.
Both are bug fixes. The first one fixes the regression introduced by
"batman-adv: Make bat_priv->primary_if an rcu protected pointer" which
prevented that the attached net_devices could be destroyed because the
references to them were incorrectly counted.

The second one is a bug which may "filled" the broadcast queue when at
the same time primary_if got changed and a broadcast was initiated. The
queue counter were never reduced because there were no actual packets
attached to the the queue.

thanks,
	Sven


The following changes since commit 27aea2128ec09924dfe08e97739b2bf8b15c8619:

  batman-adv: remove duplicate code from function is_bidirectional_neigh() (2011-05-08 16:10:42 +0200)

are available in the git repository at:
  git://git.open-mesh.org/ecsv/linux-merge.git batman-adv/next

Marek Lindner (1):
      batman-adv: reset broadcast flood protection on error

Sven Eckelmann (1):
      batman-adv: Add missing hardif_free_ref in forw_packet_free

 net/batman-adv/aggregation.c |   14 +++++++++++---
 net/batman-adv/send.c        |   19 ++++++++++++++++---
 2 files changed, 27 insertions(+), 6 deletions(-)
