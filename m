From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] dynamic gateway
Date: Sat, 4 Aug 2007 12:25:31 +0200
References: <20070803110942.7h6ynax7lx0cckgc@webmail.ddmesh.de>
In-Reply-To: <20070803110942.7h6ynax7lx0cckgc@webmail.ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708041225.31184.lindner_marek@yahoo.de>
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


Hi,

> this sounds good, but you should keep in mind that such a "good"
> internet connection that was choosen being the best, has only a short
> disconnection. I this case each batmand of each client should retest
> the connection after a timeout of few minutes. I think this could be
> disturbing an established connection because the batmand has to change
> the tunnel to the new gateway.

I think you misunderstood. The batman (internet) client will not "check" if 
the internet connection is available or not. It waits until the user wants to 
connect to the internet and than observes if the requests to the internet are 
answered or not. Of course, batman will wait until a timeout is reached and 
wont kill the connection instantly.


> For this I beleave that it is better to have a separated process
> checking its own internet connection (if provided and setup by node
> config). this process then tells batmand about the connection. batmand
> will deside on some criteries if this connection is stable an worth to
> be populated through the net.

In addition this is a good thing to do. But it should be implemented by the 
firmware maintainer and not by us.


> I have implemented in our firmware a test (like leipzig) that only
> pings some addresses.

You are not the first who has the idea to do so. Unfortunately this approach 
does not work everywhere. You should get in contact with Sven-Ola (the 
maintainer of the dyngw plugin) and ask him what his latest solution consists 
of.

Regards,
Marek
