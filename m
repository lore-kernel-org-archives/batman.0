Return-Path: <bhutchings@solarflare.com>
From: Ben Hutchings <bhutchings@solarflare.com>
In-Reply-To: <201112210315.02171.lindner_marek@yahoo.de>
References: <1324377504-20983-1-git-send-email-lindner_marek@yahoo.de>
	<201112210259.42387.lindner_marek@yahoo.de>
	<20111220.140209.618109781658024408.davem@davemloft.net>
	<201112210315.02171.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 20 Dec 2011 20:56:20 +0000
Message-ID: <1324414580.2818.31.camel@bwh-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: checkpatch cleanup - remove
 lines longer than 80 chars
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, David Miller <davem@davemloft.net>

On Wed, 2011-12-21 at 03:15 +0800, Marek Lindner wrote:
> On Wednesday, December 21, 2011 03:02:09 David Miller wrote:
> > From: Marek Lindner <lindner_marek@yahoo.de>
> > Date: Wed, 21 Dec 2011 02:59:41 +0800
> > 
> > > On Wednesday, December 21, 2011 02:32:30 David Miller wrote:
> > >> From: Marek Lindner <lindner_marek@yahoo.de>
> > >> Date: Tue, 20 Dec 2011 18:38:24 +0800
> > >> 
> > >> > The long line was introduced with b26e478f8f.
> > >> > 
> > >> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> > >> 
> > >> I'm not applying this.
> > >> 
> > >> I tell people to make sure arguments line up correctly to the
> > >> openning parenthesis on the previous line, and that is what is
> > >> happening here.
> > > 
> > > I am not against lining up the arguments but what about checkpatch ? Are
> > > we going to ignore the complaints or is this line limit about to be
> > > changed ?
> > 
> > Refactor the code so that both constraints can be satisfied.
> > 
> > Is this so hard to understand?
> 
> Well, my crystal ball did not unveil that a checkpatch complaint you silently 
> introduced would mean somebody else has to refactor the code. Guess I have to 
> get a replacement unit.

No-one has to refactor the code.  I think David's point is that he's
more concerned about proper alignment than having every line under 80
characters.  If you want to satisfy the latter constraint, you still
have to satisfy the former.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

