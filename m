Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 19 Mar 2018 17:37:21 +0100
Message-Id: <20180319163726.10921-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/5] pull request for net: batman-adv
 2018-03-19
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

here are some more bugfixes for net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit f22e08932c2960f29b5e828e745c9f3fb7c1bb86:

  batman-adv: Fix internal interface indices types (2018-02-25 20:19:34 +0100)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batadv-net-for-davem-20180319

for you to fetch changes up to fc04fdb2c8a894283259f5621d31d75610701091:

  batman-adv: Fix skbuff rcsum on packet reroute (2018-03-18 13:20:32 +0100)

----------------------------------------------------------------
Here are some batman-adv bugfixes:

 - fix possible IPv6 packet loss when multicast extension is used, by Linus Luessing

 - fix SKB handling issues for TTVN and DAT, by Matthias Schiffer (two patches)

 - fix include for eventpoll, by Sven Eckelmann

 - fix skb checksum for ttvn reroutes, by Sven Eckelmann

----------------------------------------------------------------
Linus Lüssing (1):
      batman-adv: Fix multicast packet loss with a single WANT_ALL_IPV4/6 flag

Matthias Schiffer (2):
      batman-adv: update data pointers after skb_cow()
      batman-adv: fix header size check in batadv_dbg_arp()

Sven Eckelmann (2):
      batman-adv: Add missing include for EPOLL* constants
      batman-adv: Fix skbuff rcsum on packet reroute

 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/icmp_socket.c           |  1 +
 net/batman-adv/log.c                   |  1 +
 net/batman-adv/multicast.c             |  4 ++--
 net/batman-adv/routing.c               | 25 +++++++++++++++----------
 5 files changed, 20 insertions(+), 13 deletions(-)
