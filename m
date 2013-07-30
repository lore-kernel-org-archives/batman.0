Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Tue, 30 Jul 2013 22:16:23 +0200
Message-Id: <1375215385-606-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv9 0/2] per-VLAN TT CRC
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

This is the second patchset of the TT-VLAN improvement.
It brings a not negligible change into the TT logic since it is splitting the
CRC mechanism on a per-VLAN basis. Since it is not so easy to digest I decided
to send it alone.

This change is required by an improvement which will come right after: VLAN
based TT filtering for BLA2 enabled nodes (third patchset of the TT-VLAN
feature).

In a few words....
Right now a backbone node rejects any TT entry announced by another backbone.
With this change it will be possible to filter out only those TT entries
belonging to the VLAN where BLA2 is running on. In this way, the others VLANs
will still be able to contact each other.

Before implementing the new feature, the first patch is introducing a
new lock to make any change to the local and global TT table atomic.
In this way a TT Reply cannot be sent during a writing operation on
one of the TT tables. This will prevent the TT Reply from containing
any inconsistent data.

Thank you for the feedback!

Cheers,



Changes from v8:
- removed bogus kernel doc in 2/2

Changes from v7:
- improved kernel doc and commit message in 1/2
- fixed some kernel doc typ0s in 2/2
- moved change_offset computation inside batadv_tt_prepare_tvlv_global_data()
  and batadv_tt_prepare_tvlv_local_data() to avoid code replication in 2/2

Changes from v6:
- remove orig_node_vlan from the list after freeing
- introduce locking around TT operations with 1/2
- fixed refcounting
- fixed style


Antonio Quartulli (2):
  batman-adv: lock around TT operations to avoid sending inconsistent
    data
  batman-adv: make the TT CRC logic VLAN specific

 compat.c            |   9 +
 compat.h            |   1 +
 main.c              |   1 +
 originator.c        | 102 +++++++-
 originator.h        |   7 +
 packet.h            |  18 +-
 translation-table.c | 738 ++++++++++++++++++++++++++++++++++++++++++----------
 types.h             |  54 +++-
 8 files changed, 772 insertions(+), 158 deletions(-)

-- 
1.8.1.5

