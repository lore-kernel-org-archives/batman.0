Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 17 May 2013 10:10:10 +0200
Message-Id: <1368778211-2142-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request for net: batman-adv 2013-05-17
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

here you have one fix intended for net/linux-3.10.
This patch is fixing a global fault protection that can be triggered on module
removal due to the double invocation of call_rcu() in chain.

While fixing, the patch is also adding some kernel doc to the changed functions.
Consider queueing this patch to -stable.



Please pull or let me know if there is any problem!

Thank you,
	Antonio


The following changes since commit b0ce3508b25ea6fa10ae3ca254de1d695b521702:

  bonding: allow TSO being set on bonding master (2013-05-16 15:02:01 -0700)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 72822225bd41320a98f5d7cde38317766e18983f:

  batman-adv: Fix rcu_barrier() miss due to double call_rcu() in TT code (2013-05-17 09:54:28 +0200)

----------------------------------------------------------------
Included changes:
- fix global protection fault by avoiding double call_rcu

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: Fix rcu_barrier() miss due to double call_rcu() in TT code

 net/batman-adv/originator.c        | 16 ++++++++++++++++
 net/batman-adv/originator.h        |  1 +
 net/batman-adv/translation-table.c |  7 ++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)
