Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Jun 2010 17:23:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100623152359.GL15420@lunn.ch>
References: <201006231620.11058.lindner_marek@yahoo.de>
	<1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1277302839-20197-1-git-send-email-lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Marek Lindner <lindner_marek@yahoo.de>, b.a.t.m.a.n@lists.open-mesh.net

On Wed, Jun 23, 2010 at 04:20:38PM +0200, Marek Lindner wrote:

Hi Marek

> -		if (bat_debug_type(type))				\
> -			printk(KERN_DEBUG "batman-adv:" fmt, ## arg);	\

did you think about keeping this? Maybe use some of the spare bits of
debug to indicate what goes into the circular buffer and what goes to
the kernel log?

I don't see the two schemes are mutually exclusive. "Normal" kernel
hackers will look in the normal kernel logging places and could be a
bit surprised when its not there.

    Andrew
