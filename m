Message-ID: <38681.85.41.146.90.1190394295.squirrel@krisma.oltrelinux.com>
Date: Fri, 21 Sep 2007 19:04:55 +0200 (CEST)
From: a.anselmi@oltrelinux.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] assigned IP life
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
To: b.a.t.m.a.n@open-mesh.net

Hi
mybe these lines form -d3 level at client node 5.1.7.251 can help:

Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
Gateway client - gateway (5.1.7.254) says: IP (1.0.254.169) is expired
Gateway client - got IP (1.0.254.169) from gateway: 5.1.7.254
Gateway client - disconnecting from unresponsive gateway: 5.1.7.254
Deleting default route via bat0 0.0.0.0 (table 67)
-- after some seconds --
Adding default route to 5.1.7.254 (49,64,64)
Adding default route via bat0 0.0.0.0 (table 67)

...seems that lease assigned by gateway to client (IP 1.0.254.169) have a
less than 1 sec of life... almost in my case.

Antonio


