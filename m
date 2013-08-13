Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Tue, 13 Aug 2013 10:23:55 +0200
Message-Id: <1376382240-30664-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] Basic Multicast Optimizations
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

This is the eighth revision of the basic multicast optimization patches.

It adds many style + functional changes and fixes some bugs.

It also adds a new, important fifth patch, which addresses an issue
that I would have overlooked if it weren't for the extensive offline
talks with Simon about the interaction of batman-adv and various
multicast related RFCs.


# Changelog v7 -> v8

## Style improvements

* renamed batadv_mcast_tt_clean() tobatadv_mcast_tt_retract()
* renamed batadv_mcast_tvlv_update_flag_counter() to batadv_mcast_update_counter()
* renamed batadv_mcast_mla_tt_update() to batadv_mcast_mla_update()
* renamed batadv_mcast_update_counter() to batadv_mcast_counter_update()

* renamed BATADV_MCAST_HAS_NO_BRIDGE to BATADV_MCAST_WANT_ALL_UNSNOOPABLES (and reverse its logic)
* change value of BATADV_UNINIT_FLAGS from -1 to an unused bit, BIT(15)
  -> no more need to check BATADV_UNINIT_FLAGS in batadv_mcast_counter_update()

* moved code from batadv_mcast_mla_tt_update() to newly introduced batadv_mcast_mla_tvlv_update
* moved introduction of multicast_mode sysfs file to the third patch
* added kernel doc for struct batadv_priv_mcast and enum batadv_mcast_flag

## Functional improvements

* changed a '== -EINVAL' to '< 0'
* check for a bridge anywhere on top of bat0 (like br0 on bond0 on bat0, not just br0 on bat0)
  (as discussed on IRC we don't need to check for bridges on top of vlans yet as multicast
  optimizations are only enabled for non-VLAN packets at the moment)
* removed sysfs file control over multicast TT+TVLV announcements, moved sysfs file introduction to the third patch
* removed BATADV_MCAST_LISTENER_ANNOUNCEMENT flag: its purpose is now provided by checking the existence of the multicast tvlv instead
* made the tvlv value length check in the multicast tvlv handler to not only accept a length of one byte but anything greater, too
* New Patch: batman-adv: Send multicast packets to nodes with a WANT_ALL flag

## Bugs

* converted the static 'enabled' variable in batadv_mcast_mla_tt_update() to a per bat_priv variable, using bat_priv->mcast.flags (fixes a bug when using multiple batX interfaces)
* the announced tvlv was missing the BATADV_MCAST_HAS_NO_BRIDGE flag (not needed anymore with the reversed logic)
* batadv_mcast_update_counter() was missing a case which would have needed a BATADV_UNINIT_FLAGS check (not needed anymore with reversed logic and new value for BATADV_UNINIT_FLAGS)
* added missing update for num_want_all_unsnoopables (former num_has_bridge) counter in batadv_mcast_purge_orig()


Cheers, Linus

