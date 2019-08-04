Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v2 0/2] batman-adv: BATMAN_V: OGMv2 packet aggregation
Date: Sun,  4 Aug 2019 20:06:30 +0200
Message-Id: <20190804180632.489-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

This small patchset implements the transmission side for the OGMv2
packet aggregation in BATMAN_V. The receiver part was already
implemented and seems to work nicely.

The first patch implements the necessary queueing mechanism, utilizing
skb queues.

The second patch then implements the actual OGMv2 packet aggregation for
the queued packets.


Opportunities for later improvements (left out on purpose, to keep this
patchset simple):

* Reset queue timer on full queue / if flushing in batadv_v_ogm_queue_on_if():
  -> to avoid sending small aggregates in the worker afterwards
* Remove BATADV_MAX_AGGREGATION_BYTES (512 bytes) limitation:
  -> not needed for BATMAN_V, would break compatibility though...
(* Increase BATADV_MAX_AGGREGATION_MS (100ms):
   -> BATMAN_V has less averaging, therefore could use slower OGM intervals
      and therefore slightly larger aggregtion time window)

Regards, Linus


Ref./obsolete: Previous, generic aggregation patchset:
https://patchwork.open-mesh.org/patch/17013/

==

Changelog v2:

* PATCH 1/2:
  * added lockdep_assert_held()
  * fixed aggr_len kerneldoc in types.h
  * fixed alignment in batadv_v_ogm_queue_left()
  * added missing includes in bat_v_ogm.{c,h}
  * fixed @hard_iface kerneldoc for batadv_v_ogm_aggr_list_free()
  * removed unused bat_priv in batadv_v_ogm_aggr_work()
* PATCH 2/2:
  * unchanged


