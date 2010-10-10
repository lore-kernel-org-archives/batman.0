Return-Path: <andrew@lunn.ch>
Date: Sun, 10 Oct 2010 10:12:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20101010081226.GB19495@lunn.ch>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: Wrapper functions for
 sysfs storing
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

On Sun, Oct 10, 2010 at 06:29:57AM +0200, Linus L??ssing wrote:
> Sysfs configuration options that just took a boolean value
> (enable(d)/disable(d)/0/1) and integer setting basically all had the same
> structure.
> 
> To avoid even more copy and pasting in the future and to make introducing
> new configuration parameters for batman-adv simpler, more generic
> wrapper functions are being introduced with this commit. They can deal with
> boolean and unsigned integer parameters, storing them in the specified
> atomic_t variables.
> 
> Signed-off-by: Linus L??ssing <linus.luessing@web.de>
> ---
>  bat_sysfs.c |  224 +++++++++++++++++++++++-----------------------------------
>  1 files changed, 89 insertions(+), 135 deletions(-)
> 
> diff --git a/bat_sysfs.c b/bat_sysfs.c
> index 3f551f3..60e3122 100644
> --- a/bat_sysfs.c
> +++ b/bat_sysfs.c
> @@ -39,6 +39,81 @@ struct bat_attribute bat_attr_##_name = {	\
>  	.store  = _store,			\
>  };
>  
> +static int store_switch_attr(char *buff, size_t count,
> +			     struct net_device *net_dev,
> +			     char *attr_name, atomic_t *attr)
> +{

Hi Linus

Maybe the name store_bool_attr() or store_enabled_attr() would be
clearer what it does?

	Andrew
