Return-Path: <andrew@lunn.ch>
Date: Sat, 1 May 2010 16:05:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100501140528.GM3734@lunn.ch>
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-5-git-send-email-andrew@lunn.ch>
	<201005011528.33100.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005011528.33100.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: include cleanup: Update
 gfp.h and slab.h includes to prepare for breaking implicit...
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

On Sat, May 01, 2010 at 03:28:30PM +0200, Sven Eckelmann wrote:
> Andrew Lunn wrote:
> > diff --git a/device.c b/device.c
> > index 5f7655b..b2ecba2 100644
> > --- a/device.c
> > +++ b/device.c
> > @@ -20,6 +20,7 @@
> >   */
> > 
> >  #include <linux/device.h>
> > +#include <linux/slab.h>
> >  #include "main.h"
> >  #include "device.h"
> >  #include "send.h"
> > @@ -27,8 +28,6 @@
> >  #include "hash.h"
> >  #include "hard-interface.h"
> > 
> > -#include "compat.h"
> > -
> >  static struct class *batman_class;
> > 
> >  static int Major;	/* Major number assigned to our device driver */
> 
> Can you explain why it is here ok to remove compat.h in maint?

It is not. My error. I will fix this. 

   Andrew

