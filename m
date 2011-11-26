Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 26 Nov 2011 21:18:00 +0800
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<201111242118.47604.lindner_marek@yahoo.de>
	<1912197.PaK4SIUBy6@sven-laptop.home.narfation.org>
In-Reply-To: <1912197.PaK4SIUBy6@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201111262118.01224.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Move build compat stuff to
	Makefile
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

On Thursday, November 24, 2011 21:32:41 Sven Eckelmann wrote:
> > sorry, I misread your intentions - then I discovered the patch at the
> > end. Let me try this on OpenWrt.
> 
> OpenWRT would need some tweaks to get it working (I didn't test it... just
> assuming some things). So copying the Makefile.kbuild to Makefile must be
> removed and PWD= has to be set to the source folder when making the
> build/install/clean calls.

Right, these few changes did the make it compile.

I like this approach. If nobody objects I'd say you can submit a patch for 
that. Maybe we could add a little note at the beginning of the Makefile:

# uncomment to enable extended debug log
# CONFIG_BATMAN_ADV_DEBUG=y

DAT / BLA2 / catwoman / $future_feature will want to add their option too.

Cheers,
Marek
