Return-Path: <andrew@lunn.ch>
Date: Wed, 12 Feb 2014 09:40:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140212084022.GE30814@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-13-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-13-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 12/23] batman-adv: add base throughput
 attribute
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

On Tue, Feb 11, 2014 at 01:48:12PM +0100, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> when batman-adv is asked to estimate/compute the throughput
> of an interface, but it fails for whatever reason, then the
> value in this attribute is used
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  bat_v.c | 3 +++
>  main.h  | 7 +++++++
>  sysfs.c | 7 +++++++
>  types.h | 1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/bat_v.c b/bat_v.c
> index d5457b3..3aa42ec 100644
> --- a/bat_v.c
> +++ b/bat_v.c
> @@ -75,6 +75,9 @@ static struct batadv_algo_ops batadv_batman_v __read_mostly = {
>  
>  int batadv_v_mesh_init(struct batadv_priv *bat_priv)
>  {
> +	atomic_set(&bat_priv->bat_v.base_throughput,
> +		   BATADV_DEFAULT_BASE_THROUGHPUT);
> +
>  	return batadv_v_ogm_init(bat_priv);
>  }
>  
> diff --git a/main.h b/main.h
> index 47fb9ed..5699c9f 100644
> --- a/main.h
> +++ b/main.h
> @@ -33,6 +33,13 @@
>  #define BATADV_MAX_METRIC 0xFFFFFFFF
>  #define BATADV_JITTER 20
>  
> +/**
> + * BATADV_DEFAULT_BASE_THROUGHPUT - default value used as throughput for
> + * hard_ifaces for which it is not possible to measure/estimate the real one.
> + * Value is expressed in Mbps/10

Mbps/10 is a rather odd unit. How about just Kbps?

	Andrew
