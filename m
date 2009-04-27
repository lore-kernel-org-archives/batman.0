Message-ID: <49F5E0D3.208@gmx.net>
Date: Mon, 27 Apr 2009 18:44:03 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
In-Reply-To: <209743CECB91EB4F84169A51F300410D1F3137C3F9@MAIL02.ug.kth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Masters thesis
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

Hello Vojislav!

I have a personal wish list of things that would be great to have in 
Batman. I don't know if any of these would be suitable/interesting for 
you, but I will use the opportunity to post it to the list now:

*  Modify Batman-0.3.X  in order to support IPv6
*  Improve Batman with regards to protocol overhead and convergence speed
*  Get support for other operating systems working (so far it only works 
with Linux)
*  Implement a minimalistic and power saving Batman client version for 
embedded mobile devices
*  Modify Batman-0.3.X code so we have an option to compile it without 
policy routing support
*  Modify the way that Batman-Advanced (Layer 2) deals with 
broadcast/multicast payload packages (on multihop wireless routes there 
is always packet loss, protocols like DHCP use broadcast or multicast 
messages which are not send redundantly and not acknowledged, so these 
protocols which are not designed to deal with a high level of packetloss 
have difficulties to work on a Layer 2 mesh as the number of hops and 
packet loss on the media increases)

Cheers,
elektra






> Hi!
>
> My name is Vojislav Marinkovic and I am a student of Electrical Engineering at the Royal Institute of Technology in Stockholm. My major is Communication Networks and right now I am looking for an interesting subject for my masters thesis. While browsing the Internet for some interesting topics, I ran into your project which is very similar to (yet better than) one of my own ideas. So I thought "why should I put time on inventing wet water instead of joining the project?",
>
> On your homepage you stated that you have a lot of ideas but you don't have the time to implement them all. My question is, do you have any ideas that would fit to be done as a masters thesis in communication networks? It could be anything from an issue related to the protocol itself or it could be porting an already deployed technology on other types of networks to the B.A.T.M.A.N. (I'm not suggesting anything, but as an example let's say potential issues with live streaming over a B.A.T.M.A.N.-network), comparing B.A.T.M.A.N. some other routing protocol/s or any other topic related to my major subject. I really don't have any idea on what problems you have encountered so please help me find a good topic for my masters thesis.
>
> The thesis will be done during this summer.
>
> Thank you in advance
> Vojislav Marinkovic
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>
>   

