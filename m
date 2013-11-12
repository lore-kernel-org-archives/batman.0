Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Tue, 12 Nov 2013 10:18:17 +0100
Message-Id: <1384247902-789-1-git-send-email-antonio@meshcoding.com>
Subject: [B.A.T.M.A.N.] [PATCH 0/5] Introducing the Extended-Isolation
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

quite some time ago I sent a first version of this patchset together
with other changes. At that time we decided to split the features up and to
postpone the Extended Isolation for later sending.
Now here it is!

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


p.s. I don't know if this can make a difference, but this patchset is based on
master + all my other patches pending on the mailing list.


Antonio Quartulli (5):
  batman-adv: add isolation_mark sysfs attribute
  batman-adv: mark a local client as isolated when needed
  batman-adv: print the new BATADV_TT_CLIENT_ISOLA flag
  batman-adv: extend the ap_isolation mechanism
  batman-adv: set the isolation mark in the skb if needed

 main.h              |  2 ++
 multicast.c         |  3 ++-
 packet.h            |  1 +
 soft-interface.c    | 23 ++++++++++++++----
 sysfs.c             | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 translation-table.c | 57 ++++++++++++++++++++++++++++++++++++++++----
 translation-table.h |  4 +++-
 types.h             |  2 ++
 8 files changed, 148 insertions(+), 12 deletions(-)

-- 
1.8.4.3

