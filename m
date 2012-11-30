Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Fri, 30 Nov 2012 11:14:09 +0100
Message-Id: <1354270450-25935-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] pull request: batman-adv 2012-11-30
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

Here is a lonely patch intended for net-next/linux-3.8.
It it simply adapting the batman-adv code to use the new ETH_P_BATMAN define
recently introduced in if_ether.h.

Let me know if there is any problem!

Thank you,
	Antonio


The following changes since commit bb728820fe7c42fdb838ab2745fb5fe6b18b5ffa:

  core: make GRO methods static. (2012-11-29 13:18:32 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-for-davem

for you to fetch changes up to af5d4f7737963f2112f148f97c5820425f050650:

  batman-adv: use ETH_P_BATMAN (2012-11-30 10:50:22 +0100)

----------------------------------------------------------------
Included changes:
- Use the new ETH_P_BATMAN define instead of the private BATADV_ETH_P_BATMAN

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: use ETH_P_BATMAN

 net/batman-adv/hard-interface.c | 3 ++-
 net/batman-adv/packet.h         | 2 --
 net/batman-adv/send.c           | 6 ++++--
 net/batman-adv/soft-interface.c | 9 +++++----
 4 files changed, 11 insertions(+), 9 deletions(-)
