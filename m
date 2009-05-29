From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 29 May 2009 14:58:49 +0800
References: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D251@MBX21.stu.nus.edu.sg>
In-Reply-To: <278AF6CA06F13D4C9E9F69C7B9AB3B8302E8D251@MBX21.stu.nus.edu.sg>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200905291458.52132.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Multiradio Batman
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

On Thursday 28 May 2009 13:17:04 Kartik Muralidharan wrote:
> But how would batman choose the next hop if at every node there are two
> interfaces available. The ideal ofcourse would be
> 11a->11b->11a->11b->11a on each hop.

If all nodes have 2 interfaces its hard to predict whether it will be:
11a->11b->11a->11b->11a
or
11b->11a->11b->11a->11b

If the link qualities are all equal batman we choose the fastest path (lowest 
latency).

Regards,
Marek

