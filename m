Return-Path: <linus.luessing@c0d3.blue>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 0/3] batman-adv: broadcast flooding improvements
Date: Tue, 14 May 2019 09:38:56 +0200
Message-Id: <20190514073859.2053-1-linus.luessing@c0d3.blue>
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

This patchset adds two improvements for the broadcast flooding
algorithm:

The first patch refactors/reorders the broadcast packet queueing.
Before a broadcast packet was always queued. Now the queueing decision
is performed on a per interface basis. Also the first broadcast is always
transmitted immediately, without queueing now to increase performance.

Furthermore this restructuring prepares for the next two patches:

Patches 2 and 3 introduce a broadcast-packet-to-unicast mechanism.
Similar to the multicast-to-unicast feature of the multicast back-end a
broadcast packet is split into multiple unicast transmissions. The major
difference here, for the broadcast flooding, is that it is performed on
a per-hop instead of the initial originator node basis.

This should improve throughput and reliability in densely populated
receiver scenarios, where the multicast back-end is not able to operate
(the multicast back-end is more targeted at sparsely populated receiver
scenarios so far).

Regards, Linus

