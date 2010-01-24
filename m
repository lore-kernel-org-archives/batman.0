Return-Path: <andrew@lunn.ch>
Date: Sun, 24 Jan 2010 22:00:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100124210010.GB17803@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100123181048.GO24649@lunn.ch>
	<20100124204212.GA4350@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100124204212.GA4350@Sellars>
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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

On Sun, Jan 24, 2010 at 09:42:12PM +0100, Linus L??ssing wrote:
> Hi Andrew,
> 
> Here is the output with the symbols inserted. I can reproduce this
> memory leak very reliable now, by just activating the vis server
> (didn't do that with the logs I've posted before) in a couple of
> minutes. free is showing a nice countdown then :).

So it is vis server functionality which is leaking? If vis server is
not enabled, there is no leak?

If so, we don't need kmemcheck. I expect just looking at the vis code
is probably enough to find the missing free.

   Andrew
