From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Small feature request
Date: Sun, 17 Jun 2007 14:00:00 +0200
References: <4672937F.3040208@poelzi.org>
In-Reply-To: <4672937F.3040208@poelzi.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706171400.01329.lindner_marek@yahoo.de>
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


> I got a interessting paper forwarded which discussed routing in tcp on
> ad-hoc networks (especially tcp vegas). The idea was like that:
> If the routing protocol notices the tcp stack that the route has
> changed, it can recalculate some of its parameters (here the BaseRTT
> value) to optimize speed.
>
> Implementing meshferry, a tcp over udp proxy to surround most of tcp
> problems, I can see a lot of usage for this. Because batman doesn't know
> the topology itself, i thought about a mechanism to detect route changes
> without knowing topology itself.

interesting idea but I don't get your big picture. Could you further explain 
what you have in mind while considering the following:

Even with your algorithm, detecting route changes is quite difficult for 
batman, simply because batman does not know the concept of routes through the 
network. Batman just counts packets which arrived via one or the other 
neighbor and does not care about how the packets arrived at its neighbors. 
Which "route change" should be considered ? A route change after one / two / 
three / ... hops ? A one hop routing change could be detected without your 
algorithm. That is why I think you want to detect more.
If we make a 2 hop example: We have a batman running and (for the sake of 
simplicity) one neighbor A. This neighbor has 3 neighbors of its own which 
equally supply originator packets of our target, lets say 3 and we receive 9 
packets via our neighbor A. What is our new route ?
On the other hand we begin to leave the new approach of a one hop horizon 
towards OLSR based routing which makes routing assumptions based on outdated 
data.

TCP Vegas is an algorithm in which the sending side increases and decreases 
its window size. If you upload something it is your very host or in case of a 
download it is the server. Apart from the fact that you would need an altered 
TCP stack, batman has no big chance in helping out because its most 
widespread use is to build the "backbone infrastructure". Batman hosts 
seldomly act as client or server.

TCP Vegas algorithm to detect congestion is based on the round trip times of 
the packets. It simply observes if the RTTs get bigger or smaller and derives 
its window size from it. No information about a routing change is needed.

If you really plan to deploy TCP Vegas in your network you should make sure 
that *all* your clients do the same. Otherwise the users of TCP Vegas will 
experience a massive throughput loss because the commonly used TCP stack is 
much less fair. More information on that matter can be found here: 
http://www.isoc.org/inet2000/cdproceedings/2d/2d_2.htm


Regards,
Marek
