From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 27 Apr 2009 17:01:43 +0800
References: <238a15490904202025u4ff40130ue2e57f63db9091d0@mail.gmail.com>
In-Reply-To: <238a15490904202025u4ff40130ue2e57f63db9091d0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200904271701.54989.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] vis server - global or local map?
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


Hi,

> I wanted to know if the entire network map is made available to each
> and every node OR the node has information only about its local
> connectivity to its neighbors and max the neighbors immediate
> connectivity.

I'm not entirely sure about your question but I'll do my best to answer it.
Once you enable the vis server the node will activate a flag in his originator 
messages indicating that you can send vis information. All nodes receiving 
this OGM will send their vis client data to this node.
If you have several vis servers (due to out fo range problems) the nodes will 
send their information to the nearest vis server whereas the vis server 
themselves will sync with each other.

Hope it helps clarifying the situation,
Marek

