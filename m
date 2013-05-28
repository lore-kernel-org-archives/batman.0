Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 29 May 2013 00:20:39 +0200
Message-Id: <1369779649-2537-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [RFC 00/10] Improving the routing protocol
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

with this RFC I'd like to introduce some new routing API functions meant to
improve the routing protocol abstraction.

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



The new API functions are the following:
+ metric related:
	- bat_metric_get
	- bat_metric_is_similar
	- bat_metric_compare

+ orig_node related:
	- bat_orig_print: print the originator table
	- bat_orig_add_if
	- bat_orig_del_if
	- bat_orig_free

Any feedback will surely be welcome :-)


Cheers,

p.s. there are some small "checkpatch glitches" but they will be removed before
this RFC becomes a real patchset :)


Antonio Quartulli (10):
  batman-adv: make struct batadv_neigh_node algorithm agnostic
  batman-adv: make struct batadv_orig_node algorithm agnostic
  batman-adv: add bat_orig_print function API
  batman-adv: add bat_metric_get API function
  batman-adv: add bat_metric_is_similar API function
  batman-adv: add bat_metric_compare API function
  batman-adv: adapt bonding to use the new API functions
  batman-adv: adapt the gateway feature to use the new API functions
  batman-adv: adapt the neighbor purging routine to use the new API
    functions
  batman-adv: provide orig_node routing API

 bat_iv_ogm.c        | 373 +++++++++++++++++++++++++++++++++++++++++++---------
 gateway_client.c    |  74 ++++++-----
 main.c              |   5 +-
 main.h              |   7 +
 network-coding.c    |   8 +-
 originator.c        | 238 ++++++++-------------------------
 originator.h        |   5 +-
 routing.c           |  37 ++++--
 routing.h           |   3 +-
 translation-table.c |   4 +-
 types.h             | 106 +++++++++------
 11 files changed, 518 insertions(+), 342 deletions(-)

-- 
1.8.1.5

