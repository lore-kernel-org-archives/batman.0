Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Wed, 30 Jul 2014 00:39:36 +0200
Message-Id: <1406673579-20110-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv6 0/3] Multicast optimizations for bridges
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

This patchset enables the usage of the batman-adv multicast optimizations
for scenarios involving bridges on top of e.g. bat0, too.

Along come two more patches adding according debugging facilities
to make it possible for the user to check why the multicast
optimizations might not work ideally to give hints about
what they might change about their topology.

Cheers, Linus


Changes in v6:
* New PATCH 2/3 inserted, moving logging to separate patch
* More verbose logging added to PATCH 2/3:
  Bridge and querier state changes are logged too
* upper case to lower case for kernel doc of batadv_mcast_flags_open
  (PATCH 2/3)
* Adding note to kernel doc of batadv_mcast_get_bridge about
  increased refcount (PATCH 1/3)
* Printing some lines about current bridge and querier state to
  debugfs too (PATCH 3/3)

Changes in v5 (PATCH 2/2 only):
* s/dat_cache/mcast_flags/ in kerneldoc (copy&paste error)

Changes in v4 (PATCH 2/2 only):
* initial {ad,e}dition of this patch

Changes in v3 (PATCH 1/2 only):
* Removed "RFC" tag in title again: The stubs and new export are upstream
  in net-next and therefore going to be included in 3.17
* Added some debug output:
  * Two warning messages:
    -> Old kernel version or no bridge IGMP/MLD snooping compiled
  * New batman-adv log-level "mcast":
    -> Logging mcast flag changes
  (a third debugging facility, a new table for debugfs for a global
   mcast flag overview will be added in a separate patch later
   as discussed with Simon)

Changes in v2 (PATCH 1/2 only):
* fetching local (= on this same kernel) multicast listeners from
  the bridge instead of the bat0 interface if a bridge is present
  - just like ip addresses and routes should be used from br0, the
  same goes for multicast listeners
* beautification of batadv_mcast_mla_br_addr_cpy(), now using already
  present functions from the kernel instead of own, hackish approach
* changed names of some goto-labels (not using "skip" anymore)
* using new, third bridge multicast export (because this export is
  not upstream yet, I've added the "RFC" in the title):
  br_multicast_has_querier_anywhere()
* adding compat stubs for two bridge multicast exports, to make
  batman-adv compile- and usable even if a 3.16 kernel was compiled
  without bridge code - the stubs are supposed to be upstream in the
  bridge code in 3.17 (therefore just 'compat')
* updated kerneldocs for batadv_mcast_mla_bridge_get() and
  batadv_mcast_mla_softif_get()
* The two sentences in the commit message starting with "Queriers: ..."
  were slightly modified to include the third bridge multicast export

