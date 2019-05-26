Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v4 0/2] batman-adv: routeable multicast preparations
Date: Sun, 26 May 2019 18:35:48 +0200
Message-Id: <20190526163550.4073-1-linus.luessing@c0d3.blue>
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

This patchset provides some code restructuring in preparation for the
support of routeable multicast addresses.

The first one swaps the kernel MAC multicast list with the equivalent
IPv4 and IPv6 ones: This allows an easier filtering later.

Patch 2 is a first application of such filtering and allows
omitting some redundant address additions to the TT. Later, the same
will be necessary for routeable multicast addresses.

---

Changelog v4:

* rebased to master:
  -> removed [PATCH v3 1/3] (now applied)
* fixed build issues with CONFIG_IPV6 disabled

Changelog v3:

* fixed "From:" address in mail header

Changelog v2:

* rebased to master
* removed already applied patch
  ("batman-adv: mcast: fix multicast tt/tvlv worker locking")
* split patchset in two with the intention to ease reviewing
  (no code changes, just omitted the last two patches)

* kerneldoc: alignment for batadv_mcast_mla_flags_update()
  [PATCH 2/6] / [PATCH v2 1/3]
* fixed compile issues due to a duplicated member in struct
* batadv_priv_mcast
  [PATCH 2/6] / [PATCH v2 1/3]
* kerneldoc: added missing @flags for batadv_mcast_mla_flags_update()
  [PATCH 2/6] / [PATCH v2 1/3]
* kerneldoc: @flags -> @tvlv_flags in struct batadv_mcast_mla_flags
  [PATCH 2/6] / [PATCH v2 1/3]


