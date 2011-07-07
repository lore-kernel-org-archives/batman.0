Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu,  7 Jul 2011 15:35:34 +0200
Message-Id: <1310045738-30950-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv4 0/3] Implement the AP-Isolation mechanism
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

Hi all,

I have to apologise for my mistake. I wrongly sent a different patchset instead
of the ap-isolation one. In this period I'm working on several stuff, including
my thesis and it's easy for me to make such errors.
----

This is the third version of the AP-Isolation patchset.
The patches have been rebased on top of the master branch but they have been
left mostly unmodified.

The Ap-isolation mechanism will prevent (if enabled) WIFI clients to communicate
with other WIFI clients over the mesh network. WIFI check on a client is done
by default while the isolation is performed only if the mechanism is enabled
either on the receiver and on the transmitter side.

Ap-isolation can be enabled or disabled by means of a new sysfs attribute (a
batctl patch has also been provided to toggle interact with it).

Thank you all.

Regards,
	Antonio Quartulli


