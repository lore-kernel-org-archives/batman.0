Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 10 May 2016 18:41:23 +0200
Message-Id: <1462898487-9696-1-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv15 0/4] Multicast optimizations for bridges
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

The first one alters the forwarding behaviour for IGMP and MLD reports
which is a prerequisite before enabling multicast optimizations in
bridged setups. It also increases the MCAST TVLV version number to 2.
More on the issue of insufficient report handling with the v1
MCAST TVLV can be found here:

http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports

The second patch finally enables the multicast optimizations for
bridged setups.

Along come two more patches adding according debugging facilities
to make it possible for the user to check why the multicast
optimizations might not work ideally to give hints about
what they might change about their topology.


This patchset can be found in the current linus/multicast-bridge
branch.

Cheers, Linus


-----
With v15 Mareks suggestions were added and all build report errors
were fixed.

Changes in v15:
* fixed indentiton in compat-sources/net/core/skbuff.c for
  skb_postpush_rcsum() [PATCH 1/4]
* fixed 80 characters limit for compat-include/linux/if_bridge.h
* moved querier struct introduction from [PATCH 3/4] to [PATCH 2/4]
* moved a flag variable assignment to a slightly later position
* removed unnecessary linux/mld.h include in [PATCH 1/4]
* added missing include for printk.h in multicast.c [PATCH 2/4]
* added missing include for seq_file.h in multicast.c [PATCH 4/4]
* added missing include for kernel.h in multicast.c [PATCH 3/4]
* fixed cppcheck warnings in multicast.c regarding:
  "(style) Clarify calculation precedence for '&' and '?'."
* added "struct seq_file;" declaration in multicast.h [PATCH 4/4]
* fixed kerneldoc for batadv_mcast_flags_seq_print_text() [PATCH 4/4]
  -> added missing "Return:"
  -> renamed "@mcast_flags" to "@flags"
* fixed kerneldoc for batadv_mcast_flags_open() in debugfs.c
  by adding "Return:" [PATCH 4/4]
* fixed compat-code return type in compat-source/net/core/skbuff.c,
  skb_checksum_{simple_,}validate() [PATCH 1/4]
  -> -ERRNO, does not suite a __sum16, should return skb_checksum_complete()
     directly to fix sparse warnings

Changes in v14:
* replaced compat-sources/net/bridge/br_multicast.c with
  "static inline [foo]" and #defines in
  compat-include/linux/if_bridge.h

Changes in v13:
* Substituted a non-breaking space with a boring one
* Dropped compat code for kernels < 3.2
* Removed mcast tvlv container and handler support for v1 completely
* Rebase to current master branch
  (automatic 3-way merge without issues)

Changes in v12:
* Rebase to current master branch
  (automatic 3-way merge, then batadv_hardif_free_ref() -> batadv_hardif_put())
* Adding Linux upstream fix to compat-sources/net/core/skbuff.c
  -> "net: fix bridge multicast packet checksum validation"
     (9b368814b33, present since v4.5, queued for stable)

Changes in v11:
* Rewording of commit messages (PATCH 1/4+2/4)
* Rebasing to master (solving conflict with kernel doc "return" changes)
* Updating kerneldoc to proper "Return:" syntax
* Using eth_zero_addr() over memset (fixes a new checkpatch warning)
* Changing uint8_t to u8 and uint32_t to u32 (fixes new checkpatch warnings)
* Turning some batadv_dbg() into batadv_info(), making querier presence more
  visible (i.e. in dmesg too) (PATCH 3/4)

Changes in v10:
- PATCH 1/4:
* Former "[PATCH 4/4] batman-adv: Forward IGMP/MLD reports to selected querier (only)"
  substituted by the interim branch "batman-adv: Always flood IGMP/MLD reports"
  with the following changes:
  * Increased compatibility to mcast-v1-tvlv nodes by
    registering a v1 tvlv container and handler, too
    (note: PATCH 2/4 needs to still unregister the handler
     if the node is bridged bc. it can't "trust" v1 nodes)
  * Removed skb_set_network_header() call
    (extra patch pending for review for maint)
* Compared to patchset v9 this substitution makes things
  compilable again for kernels < 2.6.35
- PATCH 2/4:
* Moved enum introduction of BATADV_DBG_MCAST to PATCH 3/4,
  not needed in PATCH 2/4 yet
* Adjusted compat code to new compat layout
* Adjustments to batadv_mcast_mla_tvlv_update() to fit now
  preceding PATCH 1/4
* bat_priv->mcast.bridged flag already introduced here
  (instead of in PATCH 3/4) because we need it for the new
  mcast-v1-tvlv handling

---
  Interim Changlog of
  "batman-adv: Always flood IGMP/MLD reports"

  v1:
   * Removed query snooping and state
   * Squashed all three patches into one
   * Renamed "batadv_mcast_tvlv_ogm_handler_v1()" to *_v2()
   * Added explicit icmpv6.h include
   * Rebased on top of master

-----
    Interim Interim Changelog of
    "batman-adv: Unicasting multicast reports to querier-node only"
    v6:
     * compat: copied copyright headers from original upstream c files
     * compat: unified ordering in compat c files:
       -> copyright header, then includes, then kernel specific functions
    v5:
     * Removed RFC tag: Needed exports got merged to net-next and are going to
       be available with Linux 4.2
     * Redid compat solution - now fully backwards compatible down to 2.6.33
    v4:
     * excluded bridge part from this patchset, they should
       hopefully be added to net-next soon
     * Added a compat solution (PATCH 3/3)
     * Removed Kconfig-depends as by David's suggestion the needed parsing
       functions for MLD are going to be forced built-ins even if IPv6 is
       going to be built as a module
     * Removed unused variable 'int ret' in batadv_mcast_is_report_ipv6()
     * Adjusted to new folder structure
    v3:
     * Adding Kconfig-depends and #if's
       (so basically adding similar dependancy constraints as the bridge code
        has, except that there are no depends if batman-adv gets compiled without
        multicast optimizations)
       -> the case of IPv6=M and batman-adv=y is still impossible if multicast
          optimizations are enabled; but I don't see the practical demand for that
          either - people who use IPv6 as a module will probably also want to
          use batman-adv as a module
    v2:
     * various bugfixes (now runtime tested, too - should(tm) work)
     * added netdev+bridge mailinglists
-----
---

Changes in v9:
- PATCH 1/4:
* fix: added compat code for pr_warn_once()
* compat fix for bridge export stubs: fixes compile error
  with kernels < 3.16 without bridge (snooping) support
- PATCH 2/4:
* perform updates of variables within bat_priv->mcast.querier_ipv{4,6}
  individually (there's a new, third member in 4/4 which shouldn't be
  overriden)
* PATCH 4/4: NEW

Changes in v8 (thanks to Simon's suggestions):
- PATCH 2/3:
* print shadowing status log of an appearing and shadowing querier, too
  (the bridge-querier-existence call has an additional 10s delay
   to ensure reports had their time to arrive -
   the bridge-querier-port call doesn't have that)
- PATCH 3/3:
* changing debugfs output from "+" and "-" to "U/4/6" and "."
* fixing "no querier present" logic (introduced in [PATCHv7 3/3])

Changes in v7 (thanks to Simon's suggestions):
- PATCH 2/3:
* renaming old/new_querier to old/new_state
* slightly extended kerneldoc of batadv_mcast_querier_log()
* removing words "good" and "bad" from debug output
* simplified batadv_mcast_flags_log()
* assignment instead of memset in batadv_mcast_mla_tvlv_update()
  and batadv_softif_init_late()
* simple struct member assignments instead of one complex struct
  assigment
* removing unnecessary memcmp's
* substituting return statement for an if-block in
  batadv_mcast_querier_log() and batadv_mcast_bridge_log()
* print "Unsnoopables(U)-flag" instead of just "U-flag"
- PATCH 3/3:
* use bat_priv values instead of querying bridge ABI in
  batadv_mcast_flags_print_header()

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

