Return-Path: <linus.luessing@web.de>
Date: Sun, 16 Feb 2014 12:31:26 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140216113126.GG28274@Linus-Debian>
References: <1384187589-23259-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1384187589-23259-1-git-send-email-sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: silence smatch errors in
 multicast compat code
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Mon, Nov 11, 2013 at 05:33:09PM +0100, Simon Wunderlich wrote:
> diff --git a/compat.h b/compat.h
> index 186547b..a99c9d5 100644
> --- a/compat.h
> +++ b/compat.h
> @@ -160,14 +160,12 @@ static inline int batadv_param_set_copystring(const char *val,
>  #define NET_ADDR_RANDOM 0
>  
>  #define netdev_master_upper_dev_get_rcu(dev) \
> -	upper; \
> -	rcu_read_unlock(); \
> +	NULL; \
>  	if (dev->br_port ? 1 : 0) { \
> +		rcu_read_unlock(); \
>  		dev_hold(dev); \
>  		return dev; \
>  	} \
> -\
> -	return NULL\
>

This approach unfortunately doesn't work and leads to crashes
because we assign NULL to upper and therefore dev, too, leading to
a null pointer exception when trying to access dev->br-port.

As the smatch warning is just a compat warning not leading to any
issues despite that, could we simply silence the build system to
ignore this instead?
