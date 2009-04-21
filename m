MIME-Version: 1.0
Date: Mon, 20 Apr 2009 22:25:37 -0500
Message-ID: <238a15490904202025u4ff40130ue2e57f63db9091d0@mail.gmail.com>
From: Gargi Purohit <gaargie@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] vis server - global or local map?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi

I have a 3 node network setup with Routerboards 433.  Each of these
boards have 2 wifi cards running. I run layer 2 batman kernel module
on these routers.

I have enabled vis server by:
 echo "server" > /proc/net/batman-adv/vis

and I can see the contents of the vis file now.

I wanted to know if the entire network map is made available to each
and every node OR the node has information only about its local
connectivity to its neighbors and max the neighbors immediate
connectivity.

For instance I have a set up

A----B----C----D-----E----F
                          |
                          |
                          P

Now wheter Node A will know if E is connected to P  and the link
quality of the same?
Or it would just know that A is connected to B and since B is its
immediate neighbor it would also know B is connected to C?



Regards

Gargi
