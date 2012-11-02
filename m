Return-Path: <0000013ac23ca1c8-740e6cfa-8166-4369-80d6-88bdfa8117d6-000000@amazonses.com>
Date: Fri, 2 Nov 2012 17:48:04 +0000
From: Christoph Lameter <cl@linux.com>
In-Reply-To: <5093EE7E.6040400@gmail.com>
Message-ID: <0000013ac23ca1c8-740e6cfa-8166-4369-80d6-88bdfa8117d6-000000@email.amazonses.com>
References: <5093EE7E.6040400@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 9/9] net: batman-adv: use per_cpu_add
	helper
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
To: Shan Wei <shanwei88@gmail.com>
Cc: NetDev <netdev@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Kernel-Maillist <linux-kernel@vger.kernel.org>, siwu@hrz.tu-chemnitz.de, lindner_marek@yahoo.de, David Miller <davem@davemloft.net>

On Sat, 3 Nov 2012, Shan Wei wrote:

> diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
> index 897ba6a..3aef5b2 100644
> --- a/net/batman-adv/main.h
> +++ b/net/batman-adv/main.h
> @@ -263,9 +263,7 @@ static inline bool batadv_has_timed_out(unsigned long timestamp,
>  static inline void batadv_add_counter(struct batadv_priv *bat_priv, size_t idx,
>  				      size_t count)
>  {
> -	int cpu = get_cpu();
> -	per_cpu_ptr(bat_priv->bat_counters, cpu)[idx] += count;
> -	put_cpu();
> +	this_cpu_add(bat_priv->bat_counters[idx], count);
>  }

Reviewed-by: Christoph Lameter <cl@linux.com>

