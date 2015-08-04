Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue,  4 Aug 2015 18:35:20 +0200
Message-Id: <1438706134-3492-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] pull request [net]: batman-adv 20150804
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

Hello David,

here you have our batch of fixes intended for net/linux-4.2.

Patch 1 by Sven Eckelmann is changing the way the GW metric is
computed so that the resulting operation does not make use of
divisions and also does not lead to any data type promotion. This is
a requirement for patch 2.

Patch 2 by Ruben Wisniewski is changing the type of the variable used
in the same GW metric computation as patch 1 to uint64_t so that potential
integer overflows are prevented. Thanks to Sven's patch above no 64bit
division will be involved.

Patch 3 (by me) is preventing DAT from injecting replies received from the
mesh into the LAN which would confuse a L2 bridge.

Patches 4, 5, 6 and 7 by Linus Lüssing are converting plain bitwise
operations on capability bits to set/clear/test_bit() in order to ensure
their atomicity and prevent potential race conditions.

Patch 8 also by Linus is making the multicast TVLV parsing routine
thread-safe in order to prevent race conditions upon reception of two
OGMs from the same originator at the same time.

Patch 9 introduces several NULL checks in order to prevent spurious
kernel crashes due to NULL pointer deferences, by Marek Lindnder.

Patches 10 and 11, still by Marek, prevent accidental double deletions
of different TT objects from their own lists which would lead to a
kernel crash.

Patch 12 by Simon Wunderlich fixes a memory leak which is triggered by
the missing initialization of the bandwidth_up/down fields of the bat-GW
struct.

Patch 13, again by Simon, is ensuring that no enqueued packet is leaked
when an interface is deactivated.

Patch 14 by Linus Lüssing is setting the network header in the skb struct
right after a packet was delivered to the batman virtual interface so that
subsequent call to ip/ipv6_hdr() do not crash.

-------------

I know they are not "just 2 or 3 small patches" (as you'd have preferred),
but they all fix bugs introduced in batman-adv several kernel releases ago
and therefore they should all be considered for inclusion in stable releases.

-------------



Please pull or let me know if anything is wrong!

Thanks a lot,
	Antonio



The following changes since commit 7c764cec3703583247c4ab837c652975a3d41f4b:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2015-07-31 17:10:56 -0700)

are available in the git repository at:

  git.open-mesh.org/linux-merge.git batman-adv-fix-for-davem

for you to fetch changes up to ec3b66e09f164824dd4f334b3802b742b7df651b:

  batman-adv: Fix potentially broken skb network header access (2015-08-04 10:48:52 +0200)

----------------------------------------------------------------
Included changes:
- avoid integer overflow in GW selection routine
- prevent DAT from replying on behalf of local clients and confuse L2
  bridges
- prevent race condition by making capability bit changes atomic (use
  clear/set/test_bit)
- fix synchronization issue in mcast tvlv handler
- fix crash on double list removal of TT objects (tt_local_entry and
  tt_request)
- initialize bw values for new GWs objects to prevent memory leak
- fix leak by puring packets enqueued for sending upon iface removal
- ensure network header pointer is set in skb

----------------------------------------------------------------
Antonio Quartulli (1):
      batman-adv: avoid DAT to mess up LAN state

Linus Lüssing (6):
      batman-adv: Make DAT capability changes atomic
      batman-adv: Make NC capability changes atomic
      batman-adv: Make TT capability changes atomic
      batman-adv: Make MCAST capability changes atomic
      batman-adv: Fix potential synchronization issues in mcast tvlv handler
      batman-adv: Fix potentially broken skb network header access

Marek Lindner (3):
      batman-adv: fix kernel crash due to missing NULL checks
      batman-adv: protect tt_local_entry from concurrent delete events
      batman-adv: protect tt request from double deletion

Ruben Wisniewski (1):
      batman-adv: Avoid u32 overflow during gateway select

Simon Wunderlich (2):
      batman-adv: initialize up/down values when adding a gateway
      batman-adv: remove broadcast packets scheduled for purged outgoing if

Sven Eckelmann (1):
      batman-adv: Replace gw_reselect divisor with simple shift

 net/batman-adv/distributed-arp-table.c | 25 +++++++----
 net/batman-adv/gateway_client.c        | 10 ++---
 net/batman-adv/multicast.c             | 81 +++++++++++++++++++++++++---------
 net/batman-adv/network-coding.c        |  7 +--
 net/batman-adv/originator.c            |  5 +++
 net/batman-adv/send.c                  |  3 +-
 net/batman-adv/soft-interface.c        | 10 ++++-
 net/batman-adv/translation-table.c     | 46 ++++++++++++++-----
 net/batman-adv/types.h                 | 15 ++++---
 9 files changed, 144 insertions(+), 58 deletions(-)
