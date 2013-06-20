Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 20 Jun 2013 15:00:25 +0200
Message-Id: <1371733228-3295-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv7 0/3] TT-VLAN: First patchset
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
Cc: Antonio Quartulli <ordex@autistici.org>

Hello folks,

after version 4 I decided to split the bug TT-VLAN batch in several patchsets to
make them easier to get digested by the maintainers.

This is the third iteration of the first patchset.

Differences from v6:
- added patch introducing the per-VLAN ap_isolation attribute. It made no sense
  to have the new framework without a user. This patch introduces it.
- removed the "novlan" sysfs folder. To avoid confusion and keep backward
  compatibility in a sane way, attributes corresponding to the untagged LAN are
  located in the root sysfs mesh folder (as it was done before). To implement
  this, some changes to the sysfs routines were needed (with respect to v6).
- the array used to build the sysfs subfolder name now has a proper size instead
  of a too generic "256".


Differences from v5 are:
- added "untagged VLAN" removal routine. In the previous code the "untagged
  VLAN" was added but never removed.

- use the correct vid argument when invoking batadv_tt_local_remove(). One
  invocation to the mentioned function was getting a vid that was not ORed with
  the HAS_TAG flag. However, such invocation has been enclosed into the new
  batadv_softif_destroy_vlan() function introduced to account the previous
  point.

- bat_priv->softif_vlan_list is now an hlist instead of of a list.


Thanks to Marek for his feedbacks.


*** BLURB HERE ***

Antonio Quartulli (3):
  batman-adv: add per VLAN interface attribute framework
  batman-adv: add sysfs framework for VLAN
  batman-adv: make the AP isolation attribute VLAN specific

 compat.c             |   9 +++
 compat.h             |  24 ++++++++
 hard-interface.c     |   2 +
 main.c               |   5 +-
 soft-interface.c     | 171 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 soft-interface.h     |   4 ++
 sysfs-class-net-mesh |   2 +-
 sysfs.c              | 167 ++++++++++++++++++++++++++++++++++++++++++++++++-
 sysfs.h              |  10 +++
 translation-table.c  |  21 +++++--
 translation-table.h  |   2 +-
 types.h              |  23 +++++++
 12 files changed, 426 insertions(+), 14 deletions(-)

-- 
1.8.1.5

