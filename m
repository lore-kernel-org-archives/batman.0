Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.4 0/3] batman-adv: Fixes for stable/linux-4.19.y
Date: Sat, 20 Nov 2021 13:40:50 +0100
Message-Id: <20211120124053.261156-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: stable@vger.kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann <sven@narfation.org>

Hi,

I went through  all changes in batman-adv since v4.19 with a Fixes: line
and checked whether they were backported to the LTS kernels. The ones which
weren't ported and applied to this branch are now part of this patch series.

For this kernel version, I only found following three patches:

* batman-adv: Consider fragmentation for needed_headroom
* batman-adv: Reserve needed_*room for fragments
* batman-adv: Don't always reallocate the fragmentation skb head

which could in some circumstances cause packet loss but which were created
to fix high CPU load/low throughput problems. But I've added them here
anyway because the corresponding VXLAN patches were also added to stable.
And some stable kernels also got these fixes a while back.

Kind regards,
	Sven

Sven Eckelmann (3):
  batman-adv: Consider fragmentation for needed_headroom
  batman-adv: Reserve needed_*room for fragments
  batman-adv: Don't always reallocate the fragmentation skb head

 net/batman-adv/fragmentation.c  | 26 ++++++++++++++++----------
 net/batman-adv/hard-interface.c |  3 +++
 2 files changed, 19 insertions(+), 10 deletions(-)

-- 
2.30.2

