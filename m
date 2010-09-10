Return-Path: <an.langer@gmx.de>
Date: Fri, 10 Sep 2010 18:47:06 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100910184706.151a6728@rechenknecht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman-adv: unicast fragmentation enhancements
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

things that changed since the last patch:
- add support to fragment packets on every node,
  if outgoing iface mtu is smaller as the packet
- add support to defragment packets on every node,
  if outgoing iface mtu is >= original size
- rename some functions

In this patch every node defragment packets if it can. Do you think it
is better to add an option to enable/disable this ?

regards,
Andreas
