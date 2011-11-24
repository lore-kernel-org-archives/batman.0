Return-Path: <andrew@lunn.ch>
Date: Thu, 24 Nov 2011 14:26:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111124132648.GC6836@lunn.ch>
References: <1322131238-11036-1-git-send-email-sven@narfation.org>
	<201111242101.21710.lindner_marek@yahoo.de>
	<1323728.0ybshCSZ9s@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323728.0ybshCSZ9s@sven-laptop.home.narfation.org>
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

> I would be even happier when we also could remove the '#include "compat.h"' 
> from main.h somehow, but I had no good (and working) idea.

Hi Sven

Could you build solution using the gcc option:

-include file

    Process file as if #include "file" appeared as the first line of
    the primary source file.

Pass this when compiling out of tree by appending it to CFLAGS?  The
hard thing is the ordering. compat.h will be first, before all other
header files.

     Andrew
