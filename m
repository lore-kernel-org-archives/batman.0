Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net: batman-adv 2020-11-27
Date: Fri, 27 Nov 2020 18:38:46 +0100
Message-Id: <20201127173849.19208-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

here are some more bugfixes for batman-adv which we would like to have in=
tegrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 14a2e551faea53d45bc11629a9dac88f88950c=
a7:

  batman-adv: set .owner to THIS_MODULE (2020-11-15 11:43:56 +0100)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-202=
01127

for you to fetch changes up to 992b03b88e36254e26e9a4977ab948683e21bd9f:

  batman-adv: Don't always reallocate the fragmentation skb head (2020-11=
-27 08:02:55 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - Fix head/tailroom issues for fragments, by Sven Eckelmann (3 patches)

----------------------------------------------------------------
Sven Eckelmann (3):
      batman-adv: Consider fragmentation for needed_headroom
      batman-adv: Reserve needed_*room for fragments
      batman-adv: Don't always reallocate the fragmentation skb head

 net/batman-adv/fragmentation.c  | 26 ++++++++++++++++----------
 net/batman-adv/hard-interface.c |  3 +++
 2 files changed, 19 insertions(+), 10 deletions(-)
