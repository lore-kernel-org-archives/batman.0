Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 12 May 2012 03:35:33 +0800
References: <1336335725-22016-1-git-send-email-lindner_marek@yahoo.de>
	<20120507071500.GA4330@ritirata.org>
In-Reply-To: <20120507071500.GA4330@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205120335.33620.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: turn tt commit code into
	routing protocol agnostic API
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

On Monday, May 07, 2012 15:15:00 Antonio Quartulli wrote:
> On Mon, May 07, 2012 at 04:22:05AM +0800, Marek Lindner wrote:
> > Prior to this patch the translation table code made assumptions about how
> > the routing protocol works and where its buffers are stored (to directly
> > modify them).
> > Each protocol now calls the tt code with the relevant pointers, thereby
> > abstracting the code.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 29ccfec.

Regards,
Marek
