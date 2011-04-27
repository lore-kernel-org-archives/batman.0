Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Wed, 27 Apr 2011 23:35:02 +0200
Message-Id: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCH] New translation table announcement mechanism
	patchset
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
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

This patchset wants to introduce a new client announcement mechanism (previously
called HNA) which totally revises the old one.

B.A.T.M.A.N.-advanced manages clients by the means of two translation tables:
a local table and a global table. The first one stores all the clients directly
connected to the node itself while the second one stores all the clients which
are announced by other nodes in the mesh network.

In the current implementation the whole local table is sent within each OGM
causing a big protocol overhead.

The core of the new implementation, instead, consists in avoiding this part
and replace this procedure by sending only the local table _changes_ which
happened in the last OGM interval. In this way, every node will update its
global table applying the changes it finds in the OGM.

A roaming improvement is also provided exploiting the newly implemented
announcement mechanism.

Moreover the global and local translation table are now lock free and rcu
protected :-)

Patchset description:
1) Rename all the variables/functions/constants from *hna* to *tt*
2) Implement the new announcement mechanism
3) Implement the roaming optimisation
4) Protect by RCU the local and global table

** Patch 2/4 also introduces a dependency on the crc16 module since the new
mechanism uses the crc16 computation function provided by this module. **

For more details, please refer to the commit message of each patch.

Regards,
	Antonio Quartulli

