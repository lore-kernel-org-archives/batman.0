Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Sat, 16 Nov 2013 12:03:46 +0100
Message-Id: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCHv3 0/5] Introducing the Extended-Isolation
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

Hello list,

this is the third version of this patchset.
Kudos to Marek for his feedback :-)


Changes from v2:
- add sysfs documentation for the new isolation_mark attribute
- revert order of show and store functions for isolation_mark (sysfs.c)
- fix a couple of typ0s in sysfs.c kerneldoc
- add missing kerneldoc for mark argument in tt_local_add()
- improve the way 'mask' is initialised in store_isolation_mark()

Changes from v1 are:
- Introduction of patch 5/6: it adds an helper function to avoid code
  duplication - function is called batadv_vlan_ap_isola_get() and it is used to
  get the current AP isolation status on a given vlan
- patch 1/6 has been changed to allow the user to enter a mark value without
  specifying any bitmask - 0xFFFFFFFF will be used as default
- patch 6/6 has been changed so that broadcasts packets are marked on the
  receiver node only if AP isolation is enabled. In this way, if AP isolation
  is not ON packets are not altered at all neither on the sender nor on the
  receiver.
- the patchset has been rebased on top of current master (dependency from the
  patch altering the table headers has been removed)

Description:
=========================

This feature is an extension of the already existing "AP isolation" which aims
to generalise the latter.

The idea is based on considering a particular subset of non-mesh clients as
"ISOLATED" and then apply the same policy that batman-adv already applies for
WiFi clients.

To decide which client belongs to this subset batman-adv uses the skb->mark
field which value can be altered by several components in the kernel (e.g.
netfilter). When an skb hits the soft-interface (e.g. bat0) the skb->mark
is compared to a preconfigured value and the source client is classified as
"ISOLATED" only in case of match.

The pre-configured mark (and its mask) is a user choice and can be set through
a new sysfs interface that is added within this patchset.

"ISOLATED" clients won't be able to talk to each other (batman-adv will drop
any packet originated by an isolated client and directed to another isolated
client) like it now happens for WiFi ones (when AP isolation is on).

Moreover broadcast packets sent by ISOLATED clients are marked on the
receiving node with the same mark that the user configured through the sysfs.
In this way netfilter (or any other program) can make decisions about
these packets on the receiver side (e.g. a rule could be "broadcast packets
created by ISOLATED clients cannot be forwarded over any port of the bridge X")


A draft of the documentation (with an example of how to use tc to mark/filter
packets) is available here[1] and will be improved as soon as the feature is
released.


Cheers,

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Extended-isolation


*** BLURB HERE ***

Antonio Quartulli (6):
  batman-adv: add isolation_mark sysfs attribute
  batman-adv: mark a local client as isolated when needed
  batman-adv: print the new BATADV_TT_CLIENT_ISOLA flag
  batman-adv: extend the ap_isolation mechanism
  batman-adv: create helper function to get AP isolation status
  batman-adv: set the isolation mark in the skb if needed

 main.c               | 26 +++++++++++++++++++
 main.h               |  3 +++
 packet.h             |  1 +
 soft-interface.c     | 27 ++++++++++++++++----
 sysfs-class-net-mesh |  8 ++++++
 sysfs.c              | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.c  | 72 +++++++++++++++++++++++++++++++++++++++-------------
 translation-table.h  |  4 ++-
 types.h              |  2 ++
 9 files changed, 191 insertions(+), 23 deletions(-)

-- 
1.8.4.3

