Date: Wed, 2 Apr 2008 11:18:38 +0200
Message-ID: <003a01c894a2$8f7ebe00$ae7c3a00$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Subject: [B.A.T.M.A.N.] Node with two wireless interfaces - to bridge them
	or not?
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

I have one node that has two wireless interfaces. I was thinking to increase
somewhat the multi-hop bandwidth loss and what is the best way of doing that.
Currently I have ath0 with two nodes on there and ath1 with another two nodes
but I'm not bridging those two interfaces. The thing is, they are on the same
subnet so is there any point in keeping them "separate", any performance
advantage, or should I just make a bridge and add the two ath's to it and just
have a single IP and run batman on that one bridge or leave it as it is, with
two IPs from the same subnet and run batman ath0 /w ath1 /w as I do currently?

Pele

