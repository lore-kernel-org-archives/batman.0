Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Mon, 17 Feb 2014 21:48:39 +0100
Message-Id: <1392670129-2498-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 00/10] pull request net: batman-adv 2014-02-17
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

here you have a pull request intended for net/linux-3.14 and linux-3.13 (please
take care of queuing these patches for merging in the latter).

Patch 1 fixes the computation of the MTU assigned to a soft-interface. This
value is based on the MTUs of the real interfaces handled by batman-adv and due
to an arithmetical error the result was always smaller than what it was supposed
to be.

Patch 2 fixes the access to a TT TVLV message in the RX path this avoiding to
read random memory.
This bug was leading to a bogus TT update messages parsing, thus to a continuous
generation of useless traffic needed to recover the entire table from another
node in the network.

Patch 3 is fixing a memory leak caused by a reference counting unbalance: after
having used a VLAN object to compare its CRC with the value received by another
node, the reference counter was never decreased so preventing the object to be
free'd when needed.

Patch 4 is a minor fix which properly addresses a wrong assumption on the
pskb_may_pull return value.

Patch 5 fixes a potential race condition when adding a new neighbour.

Patch 6 fixes a potential memory leak that could be triggered in case of
failure of the originator node initialization routine by Simon Wunderlich.

Patch 7 fixes the TranslationTable CRC computation (used for consistency check)
by taking into consideration the endianess of the host machine. Prior to this
fix, hosts having different endianess would compute different CRCs thus
continuously triggering an "inconsistency" exception with respect to the
received data which resulted in an endless sequence of recovery messages.

Patch 8 fixes a severe memory leak caused by a missing SKB consumption after a
successful TVLV message parsing.

Patch 9 avoids a potential double free that could be trigger in case of orig_node
initialization failure.

Patch 10 fixes a potential kernel paging error caused by the wrong usage of an
old skb->data pointer after that the skb itself was reallocated (by
pskb_may_pull()) by me in collaboration with Linus Lüssing.


Please pull or let me know of any problem!

Thanks a lot,
	Antonio



The following changes since commit 0fd5d57ba3456c4d0b77d1ae64be4818b47d7545:

  packet: check for ndo_select_queue during queue selection (2014-02-17 00:36:34 -0500)

are available in the git repository at:

  git://git.open-mesh.org/linux-merge.git tags/batman-adv-fix-for-davem

for you to fetch changes up to 70b271a78beba787155d6696aacd7c4d4a251c50:

  batman-adv: fix potential kernel paging error for unicast transmissions (2014-02-17 17:17:02 +0100)

----------------------------------------------------------------
Included changes:
- fix soft-interface MTU computation
- fix bogus pointer mangling when parsing the TT-TVLV
  container. This bug led to a wrong memory access.
- fix memory leak by properly releasing the VLAN object
  after CRC check
- properly check pskb_may_pull() return value
- avoid potential race condition while adding new neighbour
- fix potential memory leak by removing all the references
  to the orig_node object in case of initialization failure
- fix the TT CRC computation by ensuring that every node uses
  the same byte order when hosts with different endianess are
  part of the same network
- fix severe memory leak by freeing skb after a successful
  TVLV parsing
- avoid potential double free when orig_node initialization
  fails
- fix potential kernel paging error caused by the usage of
  the old value of skb->data after skb reallocation

----------------------------------------------------------------
Antonio Quartulli (9):
  batman-adv: fix soft-interface MTU computation
  batman-adv: fix TT-TVLV parsing on OGM reception
  batman-adv: release vlan object after checking the CRC
  batman-adv: properly check pskb_may_pull return value
  batman-adv: avoid potential race condition when adding a new neighbour
  batman-adv: fix TT CRC computation by ensuring byte order
  batman-adv: free skb on TVLV parsing success
  batman-adv: avoid double free when orig_node initialization fails
  batman-adv: fix potential kernel paging error for unicast
    transmissions

Simon Wunderlich (1):
  batman-adv: fix potential orig_node reference leak

 net/batman-adv/bat_iv_ogm.c        | 30 ++++++++++++++++++++----------
 net/batman-adv/hard-interface.c    | 22 ++++++++++++++--------
 net/batman-adv/originator.c        | 36 ++++++++++++++++++++++++++++++++++++
 net/batman-adv/originator.h        |  4 ++++
 net/batman-adv/routing.c           |  4 +++-
 net/batman-adv/send.c              |  9 +++++++--
 net/batman-adv/translation-table.c | 23 +++++++++++++++++------
 7 files changed, 101 insertions(+), 27 deletions(-)

-- 
1.8.5.3

