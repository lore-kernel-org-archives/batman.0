From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-radio nodes and alternative next hop
Date: Thu, 24 Apr 2008 09:33:08 +0200
References: <20080421123928.GA3483@apoderado.ometepe.net>
	<200804230954.37620.axel@open-mesh.net>
	<20080423230233.GA20235@apoderado.ometepe.net>
In-Reply-To: <20080423230233.GA20235@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804240933.08946.axel@open-mesh.net>
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

> ok, what happend: .4.165 (i386/prism2.5/hostap(-pci)) switched for some
> unknown reason to .3.x/channel/essid (which explains the poor link from
> .4.165 to ".4.1"(actually .3.160), and i thought it was a fast growing
> Guahumo tree :). So i fixed the bssids on both, .4.1 and .4.165. And it
> seems to not switch anymore... 
So lets hope that the prism2.5 behavior is more predictable than madwifi
> thanks for being so stubborn :-) 
> But that doesn't change the fact, that .4.1 still shows .4.162 as
> alternativeNextHop to .3.x, where, in fact, all alternative paths inside
> .4.x to .3.x lead back to .4.1 !

Yea, thats correct. Its not a bug, its a design thing of the batman protocol.
3.1 generates OGMs which are rebroadcasted via 4.1. Then, they are received 
by 4.162 and 4.160 which rebroadcast them again. Consequently, 4.162 and 
4.160 will both receive 3.1-OGMs from each other. 

3.x----4.1--+- - -4.162-+
            |           |
            +---4.160---+

Now assuming, for some reasons the link between 4.1 and 4.162 is weak, then 
4.162 might receive more OGMs via 4.160 then via 4.1. Consequently, 4.1 will 
receive the 3.x-OGMs broadcasted by 4.162 and consider 4.162 as an 
alternativeNextHop towards 3.x. 
The good thing is that the number of OGMs received via such a "wrong path" can 
NEVER become more (and faster) than those received via the "correct path" and 
therefore such path should never be chosen.

Theoretically, the same applies for a setup like this:
3.x----4.1---4.162 
where 4.1 receives the 3.x-OGMs rebroadcasted by 4.162. But for paranoid 
reasons we included a mechanism which allows 4.1 to identify OGMs that 
travelled via itself just one hop ago.

happy ruminating,

axel


>
> > > i'll make some more logs when .3.137 is back up
>
> still down, anyways, i attach -cbd8 from .4.1, .4.160, .4.162 and .4.165
>
>
> cheers
>
>     --Jan


