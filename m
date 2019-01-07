Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 7 Jan 2019 17:57:56 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20190107165755.GA5399@otheros>
References: <20181207203209.22633-1-sven@narfation.org>
 <20181207203209.22633-9-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207203209.22633-9-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [RFC v4 08/20] batctl: Support generic netlink
 for loglevel command
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

On Fri, Dec 07, 2018 at 09:31:57PM +0100, Sven Eckelmann wrote:
> sysfs should be avoided for new settings of network interfaces. To still
> provide a common configuration infrastructure, all the existing settings
> subcommands also have to be reimplemented via generic netlink while still
> using sysfs as fallback.
> 
> The loglevel implementation is using the commands
> BATADV_CMD_SET_MESH/BATADV_CMD_GET_MESH to set/get the configuration of
> this feature using the u32 (bitmask) BATADV_ATTR_LOG_LEVEL attribute.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> ---
>  loglevel.c | 138 ++++++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 28 deletions(-)
> 
> diff --git a/loglevel.c b/loglevel.c
> index fed70c8..72e16e0 100644
> --- a/loglevel.c
> +++ b/loglevel.c
> @@ -20,7 +20,9 @@
>   * License-Filename: LICENSES/preferred/GPL-2.0
>   */
>  
> +#include <errno.h>
>  #include <getopt.h>
> +#include <stdint.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -29,6 +31,10 @@
>  #include "main.h"
>  #include "sys.h"
>  
> +static struct log_level_data {
> +	uint32_t log_level;
> +} log_level_globals;
> +
>  static void log_level_usage(void)
>  {

Seems that this patch needs a rebase now, after f11e64ac9
("batctl: Remove check of compiled_out files").	Otherwise I get a
conflict with "git am --3way".
