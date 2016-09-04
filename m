Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 4 Sep 2016 04:23:53 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160904022353.GB8395@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Rebroadcast Avoidance #2 / TVLV API generalization
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

Hi,

Just wanted to let you know that, as I promised I would after
the multicast part being merged, I'm now looking into an
automatization for the no-rebroadcast flag patch.

In Gluon, this patch is currently used in two different use-cases:
A) Avoid rebroadcasts on VPN links over e.g. ADSL
   -> upstream is costly / low bandwidth
B) Avoid rebroadcasts on wired interfaces
   -> link becomes "noisy" with a bunch of nodes quickly
      thanks to OGM and broadcast packet rebroadcasts => O(n^2)

The former case is addressed with the simple rebroadcast
avoidance patch currently pending in patchwork.


For the latter, I hacked some code into this branch, which seems
to do what it is supposed to:

https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/neighhash
(top three commits - warning lot's of code cleanup still to do)

As a goody, it's now so generic, that it works on wireless, too
:-).

The basic idea of using a simple hash to describe/summarize the
neighborhood of an interface comes from Henning, when we were
discussing rebroadcasts at the last Wireless Battle Mesh during
dinner. Kudos to him!


Anyways, before going into details about the neighborhood hash
approach (I'll document and illustrate it in the wiki soon,
anyway), I wanted to ask for some feedback for the second patch
("batman-adv: unify OGM+Unicast TVLV handler functions (WIP)"),
a prerequisite to easily add TVLV support to ELP:

I) What do you think about the proposal for the TVLV handler API?
   (e.g. generalizing by adding a packet_type attribute)
~~~
void batadv_tvlv_handler_register(struct batadv_priv *bat_priv,
                                  int (*handler)(struct batadv_priv *bat_priv,
                                                 void *tvlv_value,
                                                 u16 tvlv_value_len,
                                                 void *ctx),
                                  u8 packet_type,
                                  u8 tvlv_type, u8 tvlv_version, u8 flags);

void batadv_tvlv_handler_unregister(struct batadv_priv *bat_priv, u8 packet_type,
                                   u8 tvlv_type, u8 tvlv_version);

int batadv_tvlv_containers_process(struct batadv_priv *bat_priv,
                                   const struct sk_buff *skb, u8 packet_type,
                                   unsigned int tvlv_offset,
                                   u16 tvlv_value_len, void *ctx)
~~~

II) If you like it, would you prefer having both APIs
simultaneously for a limited time to be able to migrate TVLVs one by
one once they were thoroughly tested (con: code size).

Or dragging everything to the new API in one patchset?
(con: more invasive, potentially more regressions?)

Regards, Linus
