Message-ID: <481F3DD0.8060506@ddmesh.de>
Date: Mon, 05 May 2008 19:03:12 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] deactivated/reenabled interfaces needs batmand
	restart
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

Hello again,


I'm running batman-experimental rev1023. Batman is running with two interfaces, one for wifi and one for
backbone. The backbone interface is created by tincd a vpn deamon. If I have an active vpn connection
batman recognizes the nodes at the other end of this connection. When the connection dead because the client
has closed the vpn connection, batman is still working correctly.

The problem occurres when the client re-creates the vpn connection. Batman ignores the interface. the log does not
show incomming packages from the vpn-client. If I just restart batmand with the two interfaces, batman shows
the packets within seconds and the node is reachable.

Is there a way that the inactive interfaces are reactivated and used automatically?

/Stephan
