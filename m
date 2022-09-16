Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2022-09-16
Date: Fri, 16 Sep 2022 18:09:30 +0200
Message-Id: <20220916160931.1412407-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
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

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b8=
68:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
20916

for you to fetch changes up to b1cb8a71f1eaec4eb77051590f7f561f25b15e32:

  batman-adv: Fix hang up with small MTU hard-interface (2022-08-20 14:17=
:45 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - Fix hang up with small MTU hard-interface, by Shigeru Yoshida

----------------------------------------------------------------
Shigeru Yoshida (1):
      batman-adv: Fix hang up with small MTU hard-interface

 net/batman-adv/hard-interface.c | 4 ++++
 1 file changed, 4 insertions(+)
