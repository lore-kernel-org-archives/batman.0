Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net-next: batman-adv 2021-03-12
Date: Fri, 12 Mar 2021 16:47:23 +0100
Message-Id: <20210312154724.14980-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Jakub, hi David,

this time we only have one patch in the pull request of batman-adv to
go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 25d81f9307ffc166427d93152498f45178f593=
6a:

  batman-adv: Fix names for kernel-doc blocks (2021-02-06 09:22:45 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
210312

for you to fetch changes up to b1de0f01b0115575982cf24c88b35106449e9aa7:

  batman-adv: Use netif_rx_any_context(). (2021-02-13 18:08:40 +0100)

----------------------------------------------------------------
There is only a single patch this time:

 - Use netif_rx_any_context(), by Sebastian Andrzej Siewior

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      batman-adv: Use netif_rx_any_context().

 net/batman-adv/bridge_loop_avoidance.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)
