Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 28 Jan 2017 04:40:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170128034050.GC4195@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-2-linus.luessing@c0d3.blue>
 <7229903.vTJUiGXDOz@sven-edge> <2848761.xHKJYXNK64@sven-edge>
 <20170128031311.GB4195@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170128031311.GB4195@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/4] batman-adv: Keep hard interface
 neighbor list sorted
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Sat, Jan 28, 2017 at 04:13:11AM +0100, Linus Lüssing wrote:
> On Wed, Dec 14, 2016 at 08:23:19PM +0100, Sven Eckelmann wrote:
> >     diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
> >     index 712bd428..a69614f5 100644
> >     --- a/net/batman-adv/bat_v_elp.c
> >     +++ b/net/batman-adv/bat_v_elp.c
> >     @@ -19,10 +19,10 @@
> >      #include "main.h"
> >      
> >      #include <crypto/hash.h>
> >     -#include <crypto/sha.h>
> >      #include <linux/atomic.h>
> >     +#include <linux/bug.h>
> >      #include <linux/byteorder/generic.h>
> >     -#include <linux/err.h>
> >     +#include <linux/device.h>
> >      #include <linux/errno.h>
> >      #include <linux/etherdevice.h>
> >      #include <linux/ethtool.h>
> 
> Hm, do you remember what you were adding bug.h and device.h for?
> Also, err.h seems to be needed for IS_ERR() and PTR_ERR().

Ok, found bug.h is needed for WARN_ON() in the third patch. The
device.h addition and err.h removal still leave me clueless
though.
