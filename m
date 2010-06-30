Return-Path: <an.langer@gmx.de>
Date: Wed, 30 Jun 2010 20:58:46 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100630205846.230b2112@rechenknecht>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batman adv unicast fragmentation
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
- with fragmentation enabled the mtu of batX is always ETH_DATA_LEN
- fragment if mtu of the outgoing interface is smaller the needed size
- add a new packet type for fragmentation
- new recv function for fragmented packets
- new route unicast packet function to share routing code
- increase compat number to 12


regards,
andreas
