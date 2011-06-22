Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 22 Jun 2011 20:03:36 +0200
References: <201106211512.34486.sven@narfation.org>
	<20110621200124.GA4137@lunn.ch>
In-Reply-To: <20110621200124.GA4137@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106222003.37215.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] One step back
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

On Tuesday, June 21, 2011 10:01:24 PM Andrew Lunn wrote:
> Explain to David that these changes are in the pipeline. Explain what
> benefits they bring. And probably most importantly, try to promise
> they will all arrive at once. This might mean delaying some features
> for a while, but it will upset compatibility the least. After that,
> there will not be any none compatible changes for "a long time". We
> should discussion here what "a long time" means, eg 4 kernel cycles, 8
> kernel cycles, etc.
> 
> [..]
>
> The point of this is to put infrastructure in place to allow the
> protocol to be extended without breaking compatibility. It will limit
> what can be added as new features, cause more headaches while figuring
> out how to implement something using only this infrastructure, but
> will keep a lot of people happy they don't need a flag day when
> upgrading their kernel to an incompatible batman-adv version.

Merging all "big" features at once does not seem feasible. We still want to be 
able to deliver something that does not break each and every bit at the same 
time. I also doubt that David would be happy with a big blob to be merged at 
once.
In case you refer to aggregating compatibility changes - that is what we did. 
This patchset not only contained the TT protocol changes but also the TTL 
header changes we discussed at the WBMv4.

For the upcoming routing protocol changes I propose the following: First we 
abstract the routing handling and adjust the current routing algo to be 
usable. Then we add a compile time option to choose this algo or the older one 
(afaik the wireless folks do the same with their rate control algorithm). The 
new algo can be marked as experimental and be completed step by step.

Cheers,
Marek
