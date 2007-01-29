From: "Lui" <batman@schmudde.com>
Date: Mon, 29 Jan 2007 17:18:12 +0100
Message-ID: <001601c743c1$16212ad0$0105a8c0@bluebox>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] -p ... crashes
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

Hi,

i've seen this behavior bevor, but couln't reproduce it until now:

If B.A.T.M.A.N.-III v0.1.1 beta2 (compability version 2)
is startet with a -p(refered gateway) option and the given gateway is (at least) 2 hops away
(may also not/-always/-directly reachable after start), batmand crashes.

This happens reproduceble ~30-60sec. after start.
Until this point routes are written.
No output. No purging of written routes.

Tests used: batmand -p <gateway> -r 2 eth1:bat br0:bat 

With a 1-hop-to-prefered-gateway enviroment batmand seems to have no problems...

Regards
Lui

