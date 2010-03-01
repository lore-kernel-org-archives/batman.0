Return-Path: <andrew@lunn.ch>
Date: Mon, 1 Mar 2010 06:59:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100301055955.GC15286@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100126061311.GA12697@Sellars>
	<20100129082545.GI7844@lunn.ch>
	<201001291659.59677.lindner_marek@yahoo.de>
	<20100130165059.GV24649@lunn.ch> <20100211094659.GH2900@lunn.ch>
	<20100211100156.GI2900@lunn.ch>
	<20100228163428.GA15370@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100228163428.GA15370@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
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

Hi Simon

> @@ -503,15 +550,23 @@
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&vis_hash_lock, flags);
> +
>  	purge_vis_packets();
>  
> -	if (generate_vis_packet() == 0)
> +	if (generate_vis_packet() == 0) {
>  		/* schedule if generation was successful */
> +		kref_get(&my_vis_info->refcount);
>  		list_add_tail(&my_vis_info->send_list, &send_list);
> +	}
>  
>  	list_for_each_entry_safe(info, temp, &send_list, send_list) {
> +		spin_unlock_irqrestore(&vis_hash_lock, flags);
> +
> +		send_vis_packet(info);
> +
> +		spin_lock_irqsave(&vis_hash_lock, flags);
>  		list_del_init(&info->send_list);
> -		send_vis_packet(info);
> +		kref_put(&info->refcount, free_info);
>  	}
>  	spin_unlock_irqrestore(&vis_hash_lock, flags);
>  	start_vis_timer();

Although you say this works, i just looks wrong. It looks
unbalanced. Where is the kref_put for my_vis_info->refcount?  There is
a kref_put inside what looks like a loop, but no kref_get inside the
loop. 

Can you explain this is more detail? Can we make it look correctly
balanced?

	Thanks
		Andrew
