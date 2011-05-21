Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Sat, 21 May 2011 23:25:04 +0200
Message-Id: <1306013107-18515-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1303940106-1457-1-git-send-email-ordex@autistici.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv5 0/3] New translation table announcement
	mechanism patchset v5
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

Hi,

this new patchset provides some fixes/improvements:
- Code has been rebased on top of the current master branch
- Support for kfree_rcu() has been added (with the related compat code)
- 'Fix & clean' thanks to Sven's suggestions/patches
- seq_before() is now used for ttvn comparison in recv_unicast_packet()

***
This patchset assumes that seq_before/after have been moved to main.h using these two patches:
- https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-May/004730.html
- https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2011-May/004748.html
***

Thank you all.

Regards,
	Antonio Quartulli

