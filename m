Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 14 Nov 2018 14:46:16 +0100
Message-Id: <20181114134618.17557-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/2] pull request for net: batman-adv
 2018-11-14
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
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Simon Wunderlich <sw@simonwunderlich.de>

Hi David,

here are some bugfixes which we would like to see integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20181114

for you to fetch changes up to d7d8bbb40a5b1f682ee6589e212934f4c6b8ad60:

  batman-adv: Expand merged fragment buffer for full packet (2018-11-12 10:41:29 +0100)

----------------------------------------------------------------
Here are two batman-adv bugfixes:

 - Explicitly pad short ELP packets with zeros, by Sven Eckelmann

 - Fix packet size calculation when merging fragments,
   by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (2):
      batman-adv: Use explicit tvlv padding for ELP packets
      batman-adv: Expand merged fragment buffer for full packet

 net/batman-adv/bat_v_elp.c     | 6 ++++--
 net/batman-adv/fragmentation.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)
