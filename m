Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 11 Dec 2011 01:15:53 +0800
Message-Id: <1323537357-9116-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] switch routing algorithm at runtime (v2)
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

next round for the selectable routing algorithm patches. The major change
which comes with this patchset is the module parameter that allows to set
the routing algorithm. This setting only affects batX interfaces created
after the change has been made. The list of available routing algorithms
moved to the batman-adv debugfs root directory, so that it is visible 
even before the first batX interface has been created. The sysfs entry
still shows the configured routing algorithm but does not allow to change
it.

Big kudos to Sven for helping me out with the compat macros.

Cheers,
Marek

