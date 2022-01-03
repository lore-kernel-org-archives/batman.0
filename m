Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2022-01-03
Date: Mon,  3 Jan 2022 18:12:02 +0100
Message-Id: <20220103171203.1124980-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

happy new year! Here is a bugfix for batman-adv which we would like to ha=
ve integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 66f4beaa6c1d28161f534471484b2daa2de1dc=
e0:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/h=
erbert/crypto-2.6 (2021-11-12 12:35:46 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
20103

for you to fetch changes up to 938f2e0b57ffe8a6df71e1e177b2978b1b33fe5e:

  batman-adv: mcast: don't send link-local multicast to mcast routers (20=
22-01-02 09:31:17 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - avoid sending link-local multicast to multicast routers,
   by Linus L=C3=BCssing

----------------------------------------------------------------
Linus L=C3=BCssing (1):
      batman-adv: mcast: don't send link-local multicast to mcast routers

 net/batman-adv/multicast.c      | 15 ++++++++++-----
 net/batman-adv/multicast.h      | 10 ++++++----
 net/batman-adv/soft-interface.c |  7 +++++--
 3 files changed, 21 insertions(+), 11 deletions(-)
