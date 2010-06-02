Return-Path: <joe@perches.com>
From: Joe Perches <joe@perches.com>
In-Reply-To: <201006030133.25522.sven.eckelmann@gmx.de>
References: <1275509418.23599.42.camel@Joe-Laptop.home>
	<201006030123.25027.sven.eckelmann@gmx.de>
	<1275521522.23599.88.camel@Joe-Laptop.home>
	<201006030133.25522.sven.eckelmann@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 16:47:30 -0700
Message-ID: <1275522450.23599.101.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Convert
 MAC_FMT to %pM
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: devel <devel@driverdev.osuosl.org>, Greg Kroah-Hartman <gregkh@suse.de>, b.a.t.m.a.n@lists.open-mesh.net, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Marek Lindner <lindner_marek@yahoo.de>

On Thu, 2010-06-03 at 01:33 +0200, Sven Eckelmann wrote:
> Joe Perches wrote:
> > On Thu, 2010-06-03 at 01:23 +0200, Sven Eckelmann wrote:
> > > You've also changed the output. So you may partly broke batctl too (have
> > > to check that first).
> > There was no change in output.
> > MAC_FMT output is the same as %pM
> I meant the other patch :)

batctl is parsing dmesg or equivalent?  ouch.

If so, may I suggest you consider using something other than
a message logging parser for batctl?

I glanced at the source and don't see any such use.
It looks like it's only /sys, /proc and debugfs,
but I only spent a few seconds at it.

http://www.open-mesh.net/changeset/1682/trunk?old_path=%2F&format=zip

cheers, Joe

