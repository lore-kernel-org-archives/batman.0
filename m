Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/1] pull request for net: batman-adv 2022-05-08
Date: Sun,  8 May 2022 15:21:09 +0200
Message-Id: <20220508132110.20451-1-sw@simonwunderlich.de>
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

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc=
17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
20508

for you to fetch changes up to a063f2fba3fa633a599253b62561051ac185fa99:

  batman-adv: Don't skb_split skbuffs with frag_list (2022-04-17 23:41:44=
 +0200)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - Don't skb_split skbuffs with frag_list, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Don't skb_split skbuffs with frag_list

 net/batman-adv/fragmentation.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
