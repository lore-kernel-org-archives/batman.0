In-Reply-To: <20071102051711.GA8869@apoderado.ometepe.net>
References: <20071102051711.GA8869@apoderado.ometepe.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A96E36E4-0E15-4AAF-811C-211F11A3C252@lo-res.org>
Content-Transfer-Encoding: 7bit
From: Aaron Kaplan <aaron@lo-res.org>
Subject: Re: [B.A.T.M.A.N.] batmand-exp test in the developing world 
Date: Sat, 3 Nov 2007 22:39:50 +0100
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

jan, please can you do me a favor and report if the release version  
0.5.4 of olsrd
was more efficient? sven-ola fixed a hug huge bug (the fish eye  
algorithm did not work!).

We experienced ~ 200% increase in cpu efficiency and ~ 300% in  
network efficiency between 0.4.10 and 0.5.4.
c.f. http://olsr.funkfeuer.at for graphs.

I believe the 0.5.4pre still had that bug .

thanks for helping with testing .

a.

PS: Concerning the massive emulation... i am working on it..


On Nov 2, 2007, at 6:17 AM, Jan Hetges wrote:

> Hola todos
> after
> On Mon, Oct 15, 2007 at 04:14:36PM +0200, elektra wrote:
>> I'm sorry to say that 0.3beta is not usable at the moment.
> and my tests with 0.3-beta_~rv720 showed path-detection pretty
> broken, i tried exp-0.3. Finally i installed rv772 on 14
> nodes real-world, rural nicaragua "non-profit-WISP/community
> network" parallel to existing olsrd(0.4.10/0.5.2/0.5.4pre)/
> batmand_0.2-rv502.
> the solar powered nodes run bmxd-rv772 for almost 36hrs
> now, with no significant instabilities(with lots of tunneled
> download-traffic, the tunnel get's a bit unstable, what Axel already
> fixed in rv774). CPU-usage on client nodes looks less than in
> batmand_0.2, and slightly more than olsrd (would be interesting to
> see that scaling in a cloud with >100 nodes (how's the
> "massive parallel vm simulation" going btw?)), but is significantly
> higher (about factor 2) on gateway node. Best path-detection and
> usability/stability of routes so far. All nodes seem visible
> everywhere anytime, which is the case in olsrd as well, but not in
> batmand_0.2. I'm located two hops from the GW where my server also is.
> So i'm streaming music from there to check the stability of the
> route: with only olsrd it gets silent (with 1024KB disk cache
> in mplayer, ~40sec) pretty regularly (because of "collapsing
> routing tables" somewhere), with only batmand_0.2 it's even worse
> (because the GW node "doesn't hear my OGMs" too well). Both together
> are pretty usable. So i tried with only bmxd and disk cache set
> to 32KB (>1.5sec) and in tree hours music stopped once for <2sec !
> from the "user-feeling" it's the way best mesh-daemon i tried so far.
> for fairness i have to say that my olsrds are neither all up to date,
> nor pretty well configured, but i beleave olsrd is a
> "historically crippled design" and the evolution of batmand will
> show the possibilities of wireless mesh networking.
> this all needs some further testing and improvements, but
> i'm pretty sure all the good bits will find their way into 0.3-final.
> Thanks to Elektra, Marek, Axel and everyone else who put so much
> energy into this amazing peace of free software.
>
> BatMan-eXperimental 0.3-alpha rv772 (compatibility version 5)
>
> 		 /'          '\
> 	       /   \__^..^__/   \
> 	     /    / _ \vv/ _ \    \
> 	    /          \/          \
> 	   /                        \
> 		
> 	 May the bat guide your path ...
>
>
> cheers
>
>   --Jan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

---
there's no place like 127.0.0.1



