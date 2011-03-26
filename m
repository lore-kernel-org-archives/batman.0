Return-Path: <ordex@autistici.org>
Date: Sat, 26 Mar 2011 19:15:22 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110326181522.GD11235@ritirata.org>
References: <20110326172155.GA11235@ritirata.org>
	<20110326174547.GL17979@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110326174547.GL17979@lunn.ch>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

On Sat, Mar 26, 2011 at 06:45:48PM +0100, Andrew Lunn wrote:
> Which leads me to a new question. At WBM we talked about moving the
> HNAs out of the OGMs. If we had a really big mesh, with more than 73
> hops from side to side, do we get into a situation where we have HNAs
> from more than 73 hops away, but no idea how to route to them since
> OGMs got dropped when TQ reached 0?
> 

I have another question: why do we use a HOP_PENALTY instead of an
additional HOP_COUNT field? In this way the OGM is spread as long as
possible. Is there any problem in this concept I'm not seeing?

Bye!

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
