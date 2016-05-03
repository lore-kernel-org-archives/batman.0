Return-Path: <andrew@lunn.ch>
Date: Tue, 3 May 2016 20:24:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160503182442.GA26706@lunn.ch>
References: <1462293026-24716-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462293026-24716-1-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: Use netlink to replace some of
	debugfs
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.org>

Hi Sven

> diff --git a/debug.c b/debug.c
> index 3db3ed9..c61970e 100644
> --- a/debug.c
> +++ b/debug.c
> @@ -23,10 +23,12 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  
>  #include "debug.h"
>  #include "debugfs.h"
>  #include "functions.h"
> +#include "netlink.h"
>  #include "sys.h"

...

> diff --git a/functions.c b/functions.c
> index be8f8b0..27c14d6 100644
> --- a/functions.c
> +++ b/functions.c
> @@ -52,6 +52,7 @@
>  #include "sys.h"
>  #include "debug.h"
>  #include "debugfs.h"
> +#include "netlink.h"

...  
> diff --git a/netlink.c b/netlink.c
> new file mode 100644
> index 0000000..951b842
> --- /dev/null
> +++ b/netlink.c
> @@ -0,0 +1,1024 @@
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <net/if.h>
> +#include <netlink/netlink.h>
> +#include <netlink/genl/genl.h>
> +#include <netlink/genl/ctrl.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +
> +#include "bat-hosts.h"
> +#include "batman_adv.h"
> +#include "netlink.h"
> +#include "functions.h"
> +#include "main.h"

Where is netlink.h missing?

Thanks
	Andrew
