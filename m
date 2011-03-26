Return-Path: <ordex@autistici.org>
Date: Sat, 26 Mar 2011 19:01:28 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110326180128.GC11235@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: Re: [B.A.T.M.A.N.] TTL yes, TTL no
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Sat, Mar 26, 2011 at 06:45:48PM +0100, Andrew Lunn wrote:
> > I think it is wrong: TQ is not decremented by hop_penalty each time, but it is
> > multiplied by (TQ_MAX-hop_penalty/TQ_MAX), then the number of hops is
> > bigger than what you said. With hop_penalty = 10 we can probably reach
> > ~135 hops (raw calculus 255*(TQ_MAX-hop_penalty/TQ_MAX)^135) =~ 0)
> 
> I agree with the principle. However, you need to take rounding into
> effect. The kernel does integer arithmetic and TQ is always an integer
> value. I also got it wrong in my last post. I used the wrong round
> function when calculating the values. Using rounddown() i get:
> 

[cut]

> 
> After 73 hops, TQ will be zero.

You are right, my raw calculus was too raw :p
> 
> > Looking at the calculus above, I'm proposing to use TTL = ~135
> 
> TTL of 73 would be more accurate i think.

Yes.

> 
> Which leads me to a new question. At WBM we talked about moving the
> HNAs out of the OGMs. If we had a really big mesh, with more than 73
> hops from side to side, do we get into a situation where we have HNAs
> from more than 73 hops away, but no idea how to route to them since
> OGMs got dropped when TQ reached 0?
> 

Mh..The HNA request is triggered by the TTVN carried into the OGM. Then a node
far more than 73 hops should never ask for HNAs it cannot reach..
Moreover, a route toward a client is never allocated if we don't have
its orig_node in our DB.


Bye

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
