Return-Path: <ordex@autistici.org>
Date: Sat, 26 Mar 2011 18:21:55 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110326172155.GA11235@ritirata.org>
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

Hello,

On sab, mar 26, 2011 at 04:31:42 +0100, Marek Lindner wrote:
> 
> Hi,
> 
> > In these days I was wondering whether the TTL field in the OGM packet is
> > really useful or not...Due to hop_penalty an OGM will be discarded as
> > soon as the TQ will reach 0 (which is a sort of TTL mechanism itself).
> > At this point why is the TTL field needed?
> 
> uhm.., you probably are right. As long as there is a hop penalty it also 
> functions as a TTL. Keep in mind that it is possible to set the hop penalty to 
> zero. With the current default hop penalty of 10 the maximum number of hops is 
> limited to 25.

I think it is wrong: TQ is not decremented by hop_penalty each time, but it is
multiplied by (TQ_MAX-hop_penalty/TQ_MAX), then the number of hops is
bigger than what you said. With hop_penalty = 10 we can probably reach
~135 hops (raw calculus 255*(TQ_MAX-hop_penalty/TQ_MAX)^135) =~ 0)

> 
> 
> > Someone could probably say that a node far at least TTL hops will never
> > be reached by a unicast packet, then it is meaningless to let it know
> > about me. But then it could be possible to recalibrate the TTL such that
> > it has to be equal to the maximum length in number of hops of the longest
> > path the OGM can traverse.
> 
> Not quite sure what you are proposing. A TTL of TQ_MAX / hop penalty ?
> 

Looking at the calculus above, I'm proposing to use TTL = ~135

Bye!

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
