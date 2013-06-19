Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 19 Jun 2013 18:17:54 +0200
Message-Id: <1371658676-4023-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 0/2] TT-VLAN: First patchset
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

This is another iteration of the first patchset.

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


Cheers,

Antonio Quartulli (2):
  batman-adv: add per VLAN interface attribute framework
  batman-adv: add sysfs framework for VLAN

 compat.c         |   9 +++
 compat.h         |  24 ++++++++
 hard-interface.c |   2 +
 main.c           |   5 +-
 soft-interface.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 soft-interface.h |   1 +
 sysfs.c          | 142 +++++++++++++++++++++++++++++++++++++++++++++++
 sysfs.h          |  10 ++++
 types.h          |  21 +++++++
 9 files changed, 377 insertions(+), 3 deletions(-)

-- 
1.8.1.5

