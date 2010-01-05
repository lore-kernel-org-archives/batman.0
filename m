Return-Path: <andrew@lunn.ch>
Date: Tue, 5 Jan 2010 08:41:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100105074107.GE25037@lunn.ch>
References: <20091231033752.GA18781@Sellars>
	<201001030326.02365.lindner_marek@yahoo.de>
	<20100105042058.GA3102@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100105042058.GA3102@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batman-adv: atomic variable for
 vis-srv activation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

> > * checkpatch reports 8 errors & 8 warnings
> Ehm, just got 1 error at the else part... (sorry, never used
> checkpatch before, hope that I'm not handling it wrong in any
> way...)

The number of errors will vary depending on which version of
checkpatch you use. I tend to use the one from the current -rc kernel,
or when sending patches to GregKH, checkpatch from linux-next.

I suggest you don't use anything older than 2.6.32.

  Andrew
