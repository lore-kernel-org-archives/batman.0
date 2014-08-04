Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon,  4 Aug 2014 17:47:00 +0200
Message-Id: <1407167221-10575-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] pull request net: batman-adv 2014-08-04
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hello David,

this is a pull request intended for net.

It just contains a patch by Sven Eckelmann that fixes the
reception of out-of-order fragments. As explained in the
commit message, the issue was due to a wrong assumption
about hlist_for_each_entry() in batadv_frag_insert_packet().


Please pull or let me know of any problem.
*If possible, this patch should also be enqueued for stable*

Thanks a lot,
	Antonio



The following changes since commit 4f933f414bf629852f361edf0fc5e765e3e78388:

  r8152: add missing Makefile rule (2014-08-02 20:53:55 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 9d2155fb59e21f4a38838035d2a26a8a02fec16c:

  batman-adv: Fix out-of-order fragmentation support (2014-08-04 16:05:43 +0200)

----------------------------------------------------------------
Fix out-of-order fragments reception.

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Fix out-of-order fragmentation support

 net/batman-adv/fragmentation.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

