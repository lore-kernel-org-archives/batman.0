Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 0/3] pull request for net-next: batman-adv 2022-01-03
Date: Mon,  3 Jan 2022 18:17:19 +0100
Message-Id: <20220103171722.1126109-1-sw@simonwunderlich.de>
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
To: kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

Hi Jakub, hi David,

here is a little cleanup pull request of batman-adv to go into net-next.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 66f4beaa6c1d28161f534471484b2daa2de1dc=
e0:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/h=
erbert/crypto-2.6 (2021-11-12 12:35:46 -0800)

are available in the Git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-next-pullrequest-20=
220103

for you to fetch changes up to cde3fac565a7df8805a4e0e28d84a0f90177099a:

  batman-adv: remove unneeded variable in batadv_nc_init (2021-12-10 08:5=
2:52 +0100)

----------------------------------------------------------------
This cleanup patchset includes the following patches:

 - bump version strings, by Simon Wunderlich

 - allow netlink usage in unprivileged containers, by Linus L=C3=BCssing

 - remove unneeded variable, by Minghao Chi

----------------------------------------------------------------
Linus L=C3=BCssing (1):
      batman-adv: allow netlink usage in unprivileged containers

Minghao Chi (1):
      batman-adv: remove unneeded variable in batadv_nc_init

Simon Wunderlich (1):
      batman-adv: Start new development cycle

 net/batman-adv/main.h           |  2 +-
 net/batman-adv/netlink.c        | 30 +++++++++++++++---------------
 net/batman-adv/network-coding.c |  8 ++------
 3 files changed, 18 insertions(+), 22 deletions(-)
