Return-Path: <andrew@lunn.ch>
Date: Wed, 12 Feb 2014 10:12:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20140212091215.GI30814@lunn.ch>
References: <1392122903-805-1-git-send-email-antonio@meshcoding.com>
 <1392122903-805-16-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392122903-805-16-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 15/23] batman-adv: ELP - send unicast ELP
 packets for throughput sampling
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

On Tue, Feb 11, 2014 at 01:48:15PM +0100, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> In case of a unused link, the throughput estimation will
> get stuck to the last sampled value and therefore the
> reported metric will becomes obsolete.
> 
> Send unicast ELP packets to each neighbor to trigger throughput
> sampling on unused links.

Humm, i can understand the need for this, but i really think the rate
control code should be sending the probes, not batman. What do the
wifi people say about this? Have they tried submitting patches to
them?

>  	/* Instead of updating the metric each "received" ELP packet, it is
>  	 * better to do it on each ELP sending. This way, if a node is dead and
>  	 * does not send packets anymore, batman-adv is still able to timely
>  	 * react to its death.
> +	 *
> +	 * The metric is updated by following these steps:
> +	 * 1) if the hard_iface if wifi => send a unicast ELP for
> +	 * probing/sampling to each neighbor
> +	 * 2) update the metric value of each neighbor

Might be worth pointing out here, that because of queuing, there is no
guarantee the ELP packets have been send yet and the RC estimated
bandwidth could be up to 100ms old.

> +	 *
>  	 */
>  	rcu_read_lock();
> -	hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list)
> +	hlist_for_each_entry_rcu(neigh, &hard_iface->bat_v.neigh_list, list) {
> +		if (batadv_v_elp_wifi_neigh_probe(hard_iface, neigh) < 0)
> +			/* if something goes wrong while probing, better to stop
> +			 * sending packets immediately and reschedule the task
> +			 */
> +			break;
> +
>  		ewma_add(&neigh->metric, batadv_v_elp_get_throughput(neigh));
> +	}
>  	rcu_read_unlock();
>  
