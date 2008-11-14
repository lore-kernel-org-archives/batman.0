Message-ID: <81dcbafc2db4bd2b7dac33af881cc7a0.squirrel@wm.ddmesh.de>
In-Reply-To: <41e6c23c2c09924ae91b571b5a36420b.squirrel@wm.ddmesh.de>
References: <41e6c23c2c09924ae91b571b5a36420b.squirrel@wm.ddmesh.de>
Date: Fri, 14 Nov 2008 12:30:12 +0100 (CET)
From: "Stephan Enderlein (Freifunk Dresden)" <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batmand-exp rev 1146 - hanging again
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


I have called "tcpdump -tni bat0" and have seen that a lot of packets on port 4306
were sent from my hanging batman node to a other node.

When I call "tcpdump -tni bat0" on a working node I do not see such packets. But I
see that sometimes the interface goes down.


/Stephan

