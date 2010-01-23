Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 23 Jan 2010 20:24:57 +0800
References: <20100122100238.GL24649@lunn.ch>
	<201001231127.30577.lindner_marek@yahoo.de>
	<20100123111427.GM24649@lunn.ch>
In-Reply-To: <20100123111427.GM24649@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001232024.58333.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] State of batman-adv in mainline
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

On Saturday 23 January 2010 19:14:27 Andrew Lunn wrote:
> Well, 2.6.33 will have the in kernel dot/json formatting. So the vis
> stuff in batctl 0.2.x is useless. 0.2.x however no longer has the
> controls to set the vis format the kernel uses. 2.6.33 still has the
> old logging concept, so the loglevel command with three levels is
> wrong and the man page talks about dmesg etc...

That sounds like the 0.2 release, doesn't it ?


> I think you missed the point about the merge window etc. Stuff in
> maint will be merged during the next merged window into 2.6.34, around
> the beginning of April and will be released end of June. I'm talking
> about 2.6.33 here, which will be released end of March. We can still
> get bug fixes into 2.6.33 if we want. Are there any bad bugs in the
> code from the end of December?

I misread you then. AFAIK there were no critical bugfixes.


> So you are happy for gateway, bonding etc to go into 2.6.35, merge window
> beginning of July and released sometime around end of September?

Yes, I think that might be a workable plan. We can discuss of the indiviadual 
features once we get closer to the .35 merge window. In case we find major 
problems we still can hold them back.

Regards,
Marek


