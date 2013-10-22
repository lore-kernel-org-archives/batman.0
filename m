Return-Path: <andrew@lunn.ch>
Date: Wed, 23 Oct 2013 01:53:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20131022235337.GH26694@lunn.ch>
References: <1382484463-32339-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1382484463-32339-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred-gpsd: add -lm to linker flags for
 libgps
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

On Wed, Oct 23, 2013 at 01:27:43AM +0200, Simon Wunderlich wrote:
> Appearently applications using libgps must link -lm themselves. A patch
> was submitted [1] to change this unusual behaviour upstream, but was
> never applied. Therefore link to -lm to alfred-gpsd too as this should
> not hurt anyway.

Hi Simon

What the gpsd sources i have says is:

     On some systems (those which do not support implicit linking in
     libraries) you may need to add -lm to your link line when you
     link libgps.  It is always safe to do this.

So i guess my Debian system does have implicit linking, and ldd on the
library does include libm. Hence it worked for me.

However, as you said, it does not harm, so:

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> 
> [1] https://lists.berlios.de/pipermail/gpsd-dev/2011-August/009451.html
> 
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  gpsd/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gpsd/Makefile b/gpsd/Makefile
> index 9b21652..92e690f 100644
> --- a/gpsd/Makefile
> +++ b/gpsd/Makefile
> @@ -49,7 +49,7 @@ ifeq ($(origin LIBGPS_CFLAGS) $(origin LIBGPS_LDLIBS), undefined undefined)
>      $(error No $(LIBGPS_NAME) development libraries found!)
>    endif
>    LIBGPS_CFLAGS += $(shell $(PKG_CONFIG) --cflags $(LIBGPS_NAME))
> -  LIBGPS_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBGPS_NAME))
> +  LIBGPS_LDLIBS +=  $(shell $(PKG_CONFIG) --libs $(LIBGPS_NAME)) -lm
>  endif
>  CFLAGS += $(LIBGPS_CFLAGS)
>  LDLIBS += $(LIBGPS_LDLIBS)
> -- 
> 1.7.10.4
> 
