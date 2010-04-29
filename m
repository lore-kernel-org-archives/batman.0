Return-Path: <greg@kroah.com>
Date: Thu, 29 Apr 2010 12:30:15 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20100429193015.GA18882@kroah.com>
References: <1269294375-11043-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1269294375-11043-1-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/3] Staging: Batman-adv: Bug fixes for
	2.6.34-rc2.
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
To: Andrew Lunn <andrew@lunn.ch>
Cc: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

On Mon, Mar 22, 2010 at 10:46:12PM +0100, Andrew Lunn wrote:
> Hi Greg
> 
> Here are three patches against 2.6.34-rc2 which we would like including 
> into the next -rc kernel. All three are bug fixes, with the first being a
> regression relative to 2.6.33 and the second two being older bugs, prescent 
> in 2.6.33.

In looking at these more, they are a bit too big to take now for 2.6.34.
The first one is a regression, which is fine, but you also fixed up code
at the same time, which I can't take this late in the merge cycle.

So, mind if I just push these for .35, and then add them to .34 through
the -stable tree for .34 when that opens up?

thanks,

greg k-h
