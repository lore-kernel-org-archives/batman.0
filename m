Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 16 Jul 2010 16:39:15 +0200
Message-Id: <1279291156-5297-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 0/1] Reviewing batman-adv for net/
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
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.net

Hi,

batman-adv is a layer2 meshing protocol currently in
drivers/staging/batman-adv. GregKH recently [1][2] gave us his blessing
to leave the staging tree and move to a more suitable location. To the
best of our knowledge the net tree should be it ?!

Short functionality overview:

The batman-adv module is an implementation of the B.A.T.M.A.N. routing
protocol operating on layer2 optimized for (but not limited to) wireless
networks. Next to finding the best possible path through the network it
encapsulates the data traffic and optimizes the transport as well. There
also is a user space tool "batctl" which offers various functionalities
next to a kernel module configuration interface. Detailed documentation
can be found at the project homepage[3].

I will send a patch referencing this mail. I hope you find time to send
us your opinion and ideas.

Everything is addressed in the last round of comments.

thanks,
	Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-June/002881.html
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-June/002968.html
[3] http://www.open-mesh.org
