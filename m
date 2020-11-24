Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2020-11-24
Date: Tue, 24 Nov 2020 14:44:16 +0100
Message-Id: <20201124134417.17269-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated in=
to net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c920=
91:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
01124

for you to fetch changes up to 14a2e551faea53d45bc11629a9dac88f88950ca7:

  batman-adv: set .owner to THIS_MODULE (2020-11-15 11:43:56 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - set module owner to THIS_MODULE, by Taehee Yoo

----------------------------------------------------------------
Taehee Yoo (1):
      batman-adv: set .owner to THIS_MODULE

 net/batman-adv/log.c | 1 +
 1 file changed, 1 insertion(+)
