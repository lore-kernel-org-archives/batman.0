Return-Path: <andrew@lunn.ch>
Date: Thu, 23 Nov 2017 16:43:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20171123154329.GE30167@lunn.ch>
References: <20171119140517.24329-1-sven@narfation.org>
 <20171119140517.24329-9-sven@narfation.org>
 <7304207.KlJx96cEKj@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7304207.KlJx96cEKj@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Change batman_adv.h
 license to MIT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, Nov 23, 2017 at 03:36:04PM +0100, Sven Eckelmann wrote:
> Hi Andrew,
> 
> On Sonntag, 19. November 2017 15:05:16 CET Sven Eckelmann wrote:
> > The ISC license is considered as not recommended in "Linux kernel licensing
> > rules". It should only be used for existing code or for importing code from
> > a different project with that license.
> > 
> > But the kernel still has the similar sounding MIT/Expat license under the
> > preferred licenses. Switching to this license for this relatively new file
> > should therefore allow batman-adv to better follow the new licensing rules.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > I would ask for Acked-by from following persons
> 
> What I wanted to say here: "I would like to get an Acked-by reply from 
> following persons" (thanks to Simon, Matthias and Antonio for the fast 
> response).

Hi Sven

Sorry, was not paying close enough attentions to notice you wanted my
feedback.

I just looked at Linus's current master branch:

~/linux/include/uapi$ grep -hr SPDX * | sort | uniq -c 
     14 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
    541 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
    113 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
      1 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) AND MIT) */
     21 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
     17 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
      4 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR BSD-3-Clause) */
      3 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR MIT) */
      3 /* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
      3 /* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
     15 /* SPDX-License-Identifier: LGPL-2.1+ WITH Linux-syscall-note */

We are in the region of "Lies, damn lies, and statistics", but
everything with an SPDX tag has some form of GPL/LGPL. Now, adding
SPDX tags is a new activity, and adding the GPLs tags have been done
first, since they are easier to do. So it could be there are a lot of
UAPI header files which are not {L}GPL. Also, given this small sample,
it seems BSD is more popular over MIT.

I understand the reasons for ISC to MIT, so

Acked-by: Andrew Lunn <andrew@lunn.ch>

However, i wounder if GPL-2.0 WITH Linux-syscall-note OR one of the
BSD variants would be more consistent with the rest of the kernel?

    Andrew
