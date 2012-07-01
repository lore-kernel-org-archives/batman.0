Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun,  1 Jul 2012 14:09:11 +0200
Message-Id: <1341144554-27900-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 0/3] new feature: Speedy Join 2012-07-01b
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello people,

this is the fourth version of the Speedy Join patchset below


Changes history:
v1 -> v2:
- indentation and style has been fixed taking into consideration Sven's
  suggestions
- Old patch 4 has been removed. TT flags do not really need to be carry along
  with the tt_entry in a roaming_adv packet. (at least this is not needed for
  the purpose of this feature). A roaming client will be marked as ROAM on
  the new mesh node and therefore it will be already purged if nobody claims it

v2 -> v3:
- patch 1 and 2 have been merged in 1/3. Changes were all related to the new
  refcounting mechanism. ..orig_entry_find() function has been improved as well
  as ..orig_entry_add() (it does internally check if the orig_entry already
  exists or not) and ..has_orig() (now it does use ..orig_entry_find()).
- patch 2/3 has been modified to take into consideration the change above
- temp timeout changed to an absolute value instead of being computed as product
  of the local orig_interval times a constant factor.

v3 -> v4:
- fixed some minor style issues
- renamed batadv_orig_list_entry_free_ref() to
  batadv_tt_orig_list_entry_free_ref()
- improved comment in patch 2/3

Thank you,
	Antonio


Antonio Quartulli (3):
  batman-adv: add reference counting for type batadv_tt_orig_list_entry
  batman-adv: detect not yet announced clients
  batman-adv: change interface_rx to get orig node

 main.h              |    1 +
 packet.h            |    1 +
 routing.c           |   10 +--
 soft-interface.c    |    6 +-
 soft-interface.h    |    5 +-
 translation-table.c |  194 +++++++++++++++++++++++++++++++++++++--------------
 translation-table.h |    4 +-
 types.h             |    2 +
 8 files changed, 163 insertions(+), 60 deletions(-)

-- 
1.7.9.4

