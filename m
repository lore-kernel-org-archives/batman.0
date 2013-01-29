Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 29 Jan 2013 08:07:59 +0100
Message-Id: <1359443280-28835-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2013-01-29
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

here you have just a single patch which is fixing a pesky bug that I introduced
within a patchset recently sent to net-next/linux-3.9.
It is not big, but I think it is worth fixing the new behaviour before it
gets released.

Please pull or let me know if there is any problem.
Thanks a lot,
	Antonio



The following changes since commit cef401de7be8c4e155c6746bfccf721a4fa5fab9:

  net: fix possible wrong checksum generation (2013-01-28 00:27:15 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to a7966d908ae8472e8183496916b7baec5f65b3a6:

  batman-adv: fix local translation table output (2013-01-28 20:46:03 +0100)

----------------------------------------------------------------
Included changes:
- fix recently introduced output behaviour

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: fix local translation table output

 net/batman-adv/translation-table.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
