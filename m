Return-Path: <andrew@lunn.ch>
Date: Fri, 7 May 2010 07:25:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100507052549.GY3734@lunn.ch>
References: <1273177132-8792-1-git-send-email-andrew@lunn.ch>
	<201005062344.57242.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005062344.57242.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 00/26] staging:batman-adv
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>

On Thu, May 06, 2010 at 11:44:06PM +0200, Sven Eckelmann wrote:
> Andrew Lunn wrote:
> > 
> > Marek Lindner (9):
> >   staging:batman-adv: fix aggregation timing bug
> >   staging:batman-adv: fix whitespace style issues
> >   staging:batman-adv: convert multiple /proc files to use sysfs
> >   staging:batman-adv: convert more files from /proc to /sys
> >   staging:batman-adv: move originator interval setting from /proc to
> >     /sys
> >   staging:batman-adv: remove redundant pointer to originator interface
> >   staging:batman-adv: move /proc interface handling to /sys
> >   staging:batman-adv: Fix whitespace problems criticized by
> >     checkpatch.pl
> >   staging:batman-adv: Reduce max characters on a line to 80
> 
> Am I the only one who thinks that Marek takes credits for too many patches? 

Sorry, i never thought about checking this.

I will have to track this backwards and see where it got the
information from. It does not look like it is simply the first
Signed-off-by. It is also possible i get something wrong when
squashing patches together...

> Some patches are missing the signed-off-by line from you or have typos inside 
> that line. Maybe you can use `git format-patch --signoff` to get that 
> automatically added if it is missing.

Yes, i only found that after manually adding them... I should read the
man pages from top to bottom and see what other useful flags i don't
know about :-)

    Andrew
