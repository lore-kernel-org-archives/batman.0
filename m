Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sun, 11 Aug 2013 14:33:14 +0200
Message-Id: <1376224403-2494-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2 0/9] Improving the routing protocol
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

This is the second version of the "improved routing abstraction" patchset.
In this second version I simply removed the bat_metric_compare() API since it
was not really needed. The reason is that we are now assuming that all the
metrics are represented by a uint32_t and they can be generically compared with
a simple comparison (<, == or >).


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


This is the second version of this RFC where I introduced some changes to the
names of some functions and some other minor changes discussed in the previous
RFC thread.


+ metric related:
        - bat_metric_get
	- bat_metric_is_equiv_or_better

+ orig_node related:
        - bat_orig_print: print the originator table
        - bat_orig_free
        - bat_orig_add_if
        - bat_orig_del_if


Changes from v1:
- removed bat_metric_compare() API. This is not really useful since we are
  assuming all the metrics are in the same domain (uint32_t) so a simple
  comparison is more than enough.


Cheers,


*** BLURB HERE ***

Antonio Quartulli (9):
  batman-adv: make struct batadv_neigh_node algorithm agnostic
  batman-adv: make struct batadv_orig_node algorithm agnostic
  batman-adv: add bat_orig_print function API
  batman-adv: add bat_metric_get API function
  batman-adv: add bat_metric_is_equiv_or_better API function
  batman-adv: adapt bonding to use the new API functions
  batman-adv: adapt the neighbor purging routine to use the new API
    functions
  batman-adv: provide orig_node routing API
  batman-adv: adapt the TT component to use the new API functions

 bat_iv_ogm.c        | 344 +++++++++++++++++++++++++++++++++++++++++++---------
 gateway_client.c    |  16 +--
 main.c              |   4 +-
 main.h              |   6 +
 network-coding.c    |   8 +-
 originator.c        | 228 +++++++---------------------------
 originator.h        |   5 +-
 routing.c           |  34 ++++--
 routing.h           |   3 +-
 translation-table.c |  31 +++--
 types.h             |  85 ++++++++-----
 11 files changed, 457 insertions(+), 307 deletions(-)

-- 
1.8.1.5

