Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Tue, 25 Apr 2017 02:02:13 +0200
Message-Id: <20170425000218.23721-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] =?utf-8?q?=28no_subject=29?=
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

This patchset introduces aggregation support for BATMAN V -
as well as any other packet type with a broadcast destination.

Branch:
* https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/aggregation

Regards, Linus

---

Changelog:

v3:
* moved "Introduce packet type independent TVLV ..." from
  linus/neighhash to this patchset
  (this patchset is more important, therefore swapping their order)
* removed the two already applied patches
* rebased to master

v2:
* reset skb->cb on the soft-iface reception path, too [PATCH 5/6]
  (thanks Sven!)

RFC->v1:
* removed tvlv (un)pack ctx wrappers
* fixed a crash when deaggregating ARP packets
* now compile tested down to 3.2, too (no issues found)
* now stress tested with multicast traffic of a larger, public mesh setup

