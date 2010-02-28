Return-Path: <andrew@lunn.ch>
Date: Sun, 28 Feb 2010 10:37:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100228093728.GF637@lunn.ch>
References: <201002280430.09575.lindner_marek@yahoo.de>
	<1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1267302649-22040-1-git-send-email-lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: convert multiple /proc
 files to use sysfs
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

Hi Marek

I've not looked into the details yet, just a quick glans. However
maybe we should discuss this point:

> @@ -249,6 +249,8 @@ static void rebuild_batman_packet(struct batman_if *batman_if)
>  
>  void schedule_own_packet(struct batman_if *batman_if)
>  {
> +	/* FIXME: each batman_if will be attached to a softif */
> +	struct bat_priv *bat_priv = netdev_priv(soft_device);
>  	unsigned long send_time;
>  	struct batman_packet *batman_packet;
>  	int vis_server = atomic_read(&vis_mode);
> @@ -289,7 +291,9 @@ void schedule_own_packet(struct batman_if *batman_if)
>  	slide_own_bcast_window(batman_if);
>  	send_time = own_send_time();
>  	add_bat_packet_to_list(batman_if->packet_buff,
> -			       batman_if->packet_len, batman_if, 1, send_time);
> +			       batman_if->packet_len,
> +			       batman_if, 1, send_time,
> +			       &bat_priv->aggregation_enabled);
>  }

  
>  struct bat_priv {
>  	struct net_device_stats stats;
> +	atomic_t aggregation_enabled;
> +	atomic_t bonding_enabled;
> +	struct kobject *mesh_obj;
>  };

With time i expect that bat_priv will gain many more members as global
variables are replaced with variables per mesh. Rather than passing to
functions a member, pass the pointer and let the function dereference
it. I think it will make the APIs neater in the long run.

    Andrew
