Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Jun 2010 17:12:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100623151233.GK15420@lunn.ch>
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
	<20100623145154.GI15420@lunn.ch>
	<201006231702.37242.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201006231702.37242.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: add routing debug log
 accessible via debugfs
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Jun 23, 2010 at 05:02:36PM +0200, Marek Lindner wrote:
> On Wednesday 23 June 2010 16:51:54 Andrew Lunn wrote:
> > > +
> > > +#ifdef CONFIG_BATMAN_ADV_DEBUG
> > > +extern int debug;
> > 
> > What is debug used for now? Does it still have a purpose?
> 
> Oh yes, it does. You have to use it to configure the log level as before.

So you get one global setting, which affects all meshes? Should this
maybe pushed into priv? Is there a use case for having different
logging levels for different meshes in a node?

	Andrew
