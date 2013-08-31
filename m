Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 31 Aug 2013 20:51:28 +0200
Message-Id: <1377975097-1664-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv6 0/9] Improving the routing protocol
	abstraction
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

Hello list,

This is the *fifth* version of the "improved routing abstraction" patchset.
Thanks for the feedback so far! (Message below is the same as v3)


This patchset is introducing a new set of routing API functions meant to
improve the routing protocol abstraction.

Also the orig_node and the neigh_node structure have been heavily modified in
order to split their generic members from those which are metric related.

(the rest of the message is what you already had in the RFC cover
letter).

This changes have been written while developing batman V. The latter helped me
in understanding what batman iv and v have in common and what not.

The main problem was the metric: the two protocols use different metric domains
and different semantics.
Therefore all the functions handling/printing the metric needed to be
generalised and rearranged to let the protocols decide what to do.

Another issue was the way routing protocols handle the orig and neigh node
structures. Also these two have been changed and some small APIs have been
provided as well.

Moreover, after Simon's RFC about the new multi-interface optimisation, we saw
the need for a better abstraction so that mechanisms like that could easily be
re-used by new algorithms (like batman v) with little effort.


****** API functions changed starting from v4 ******

+ neigh comparison related:
	- bat_neigh_cmp
	- bat_neigh_is_equiv_or_better

+ orig_node related:
        - bat_orig_print: print the originator table
        - bat_orig_free
        - bat_orig_add_if
        - bat_orig_del_if


Changes from v1:
- removed bat_metric_compare() API. This is not really useful since we are
  assuming all the metrics are in the same domain (uint32_t) so a simple
  comparison is more than enough.

Changes from v2:
- initialise best_metric in the neighbor purging routine
- don't optimise ntohs. Will be done in a separate patch

Changes from v3:
- bat_metric_is_equiv_or_better is now called bat_neigh_is_equiv_or_better and
  now directly takes two neigh_node as parameters. This allows to do not export
  the metric at all: all the metric magic is handled inside the function.
- bat_metric_compare has been re-introduced again with the bat_neigh_cmp name. As
  for bat_neigh_is_equiv_or_better it also takes two neigh_node as parameters
  and the metric is handled inside only.
- as result of the two changes above bat_metric_get has been removed. The
  metric is always handled inside the routing protocol code and there is no need
  to export it to the rest of the module. This simplified the code and reduced
  code duplication. (Thanks Marek for the hint!)

Changes from v4:
- fixed typ0 in 9/9

Changes from v5:
- add neigh_node to the neighbor list only after having completed the whole
  initialisation phase (in 1/9)


Cheers,


Antonio Quartulli (9):
  batman-adv: make struct batadv_neigh_node algorithm agnostic
  batman-adv: make struct batadv_orig_node algorithm agnostic
  batman-adv: add bat_orig_print API function
  batman-adv: add bat_neigh_cmp API function
  batman-adv: add bat_neigh_is_equiv_or_better API function
  batman-adv: adapt bonding to use the new API functions
  batman-adv: adapt the neighbor purging routine to use the new API
    functions
  batman-adv: provide orig_node routing API
  batman-adv: adapt the TT component to use the new API functions

 bat_iv_ogm.c        | 394 ++++++++++++++++++++++++++++++++++++++++++++--------
 gateway_client.c    |  16 +--
 main.c              |   4 +-
 main.h              |   6 +
 network-coding.c    |   8 +-
 originator.c        | 246 ++++++++------------------------
 originator.h        |   5 +-
 routing.c           |  39 ++++--
 routing.h           |   3 +-
 translation-table.c |  35 +++--
 types.h             |  95 +++++++++----
 11 files changed, 546 insertions(+), 305 deletions(-)

-- 
1.8.1.5

