Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 14 Sep 2012 00:31:47 +0800
References: <1347495936.15654.YahooMailClassic@web121402.mail.ne1.yahoo.com>
In-Reply-To: <1347495936.15654.YahooMailClassic@web121402.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201209140031.47996.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] interface preference
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thursday, September 13, 2012 08:25:36 adam wiz wrote:
> Is there any manual way to prioritize a wired interface over a wireless
> interface? It seems to do so naturally at first, but if I unplug and
> replug the Ethernet cable a couple times when testing it will stay on
> wireless. Is this considered an optimization or a bug, and how can I make
> it so it should always choose the Ethernet, even in multi-hop situations?
> For example, Babel uses an "rxcost" metric for each interface to manually
> increase the cost of a route on each interface.

batman-adv has no ability to manually manipulate the cost of a link. Our goal 
is to make batman-adv as easy to use as possible, thus we refrain from adding 
too many configuration options. We'd rather implement an automatic detection 
even if it comes at the cost of not being amongst the first of supporting a 
certain feature.

Cheers,
Marek
