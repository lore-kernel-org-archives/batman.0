Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Sun, 29 Jan 2017 14:57:37 +0100
Message-Id: <20170129135743.21312-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH 0/6] batman-adv: broadcast packet aggregation
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

Here is a first patchset to reintroduce aggregation support for BATMAN V, too -
as well as any other packet type with a broadcast destination.

Branch:
* https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/aggregation

Regards, Linus

PS: Requires: "batman-adv: Introduce packet type independent TVLV handler API"
(40e5c9e798ec, available on patchwork or linus/aggregation branch)

---

RFC->v1:
* removed tvlv (un)pack ctx wrappers
* fixed a crash when deaggregating ARP packets
* now compile tested down to 3.2, too (no issues found)
* now stress tested with multicast traffic of a larger, public mesh setup

