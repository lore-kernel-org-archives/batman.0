Return-Path: <linus.luessing@web.de>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@web.de>
Date: Sun,  7 Sep 2014 07:42:36 +0200
Message-Id: <1410068560-7829-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv9 0/4] Multicast optimizations for bridges
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

The fourth one alters the forwarding behaviour for IGMP and MLD
reports. For one thing this reduces overhead (especially for IGMPv3/MLDv2
reports). But more importantly this is necessary to make the
optimizations work in bridged scenarios at all. For more details see:
http://www.open-mesh.org/projects/batman-adv/wiki/Multicast-optimizations-listener-reports

Also note, that with PATCH 4/4 multicast optimizations do not build
for kernels < 2.6.35 (net/mld.h didn't exist back then): If there are
actually brave souls out there running such ancient end-of-life kernels,
it is suggested to build batman-adv with the multicast-compile-time option
disabled. Multicast optimizations for bridges does not half any benefits
for kernels < 3.17 anyways.

Cheers, Linus


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
