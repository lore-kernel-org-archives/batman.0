References: <48448358.4070505@changind.com>
In-Reply-To: <48448358.4070505@changind.com>
Subject: RE: [B.A.T.M.A.N.] Multiple radios to improve throughput
Date: Tue, 3 Jun 2008 10:26:30 +0200
Message-ID: <000701c8c553$882cbd50$988637f0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
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

I believe the new routerboard 433 is supposed to handle that with its 600 (or
was it 800?) MHz cpu (atheros). But then you never know...

> -----Original Message-----
> From: b.a.t.m.a.n-bounces@open-mesh.net [mailto:b.a.t.m.a.n-bounces@open-
> mesh.net] On Behalf Of Shane Chao
> Sent: Tuesday, June 03, 2008 1:34 AM
> To: b.a.t.m.a.n@open-mesh.net
> Subject: [B.A.T.M.A.N.] Multiple radios to improve throughput
> 
> Elektra,
> 
> Thank you for pointing out in May 08 that most embedded boards do not
> have enough CPU power to saturate the capacity of single radio link.  I
> was experimenting Batman in a straight line, three node configuration
> with the middle node having two radios so it doesn't have to switch
> between node 1 and node 3.  My configuration is as follows:
> 
> node 1          node 2          node 3
> ------          ------          ------
>   ath0 <--ch 1--> ath0
>                   ath1 <--ch 11-> ath0
> 
> When I ran iperf between node 1 and 3, I did not see any throughput
> improvements with either one or two radios in node 2. I even stopped
> Batman and manually setup the routes and the performance remains the
> same.  However, when I upgrade node 2 from a 200MHz CPU board to a
> 500MHz CPU board, the bandwidth went up 50%.  So thanks again for
> pointing out my bottleneck:)
> 
> Lastly, can someone suggest some embedded boards fast enough to push
> wifi radios to its limits?
> 
> Thanks,
> Shane
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

