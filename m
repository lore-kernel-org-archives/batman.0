Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 26 Dec 2012 18:08:50 +0800
References: <1355570082-19574-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1355570082-19574-1-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201212261808.51135.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone OGM preparation
	to sending time
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

On Saturday, December 15, 2012 19:14:42 Antonio Quartulli wrote:
> OGMs are currently prepared 1 originator interval in advance
> then the time they are used to be sent.
> This means that once in the air they carry old information (like TT
> announcements and possibly other flags). To fix this, postpone the OGM
> creation to the same time of sending, in this way the OGM is first created
> and then immediately sent.

How about:
OGMs are currently assembled and enqueued one originator interval before they 
are sent. This means they might carry information which was outdated while the 
OGM waited in the outgoing packet queue (like TT announcements and possibly 
other flags).
The OGM assembly has to be postponed to the latest possible moment before 
sending in order to minimize the gap between gathering the data and flooding 
it to the network.


> -/* when do we schedule our own ogm to be sent */
> +/**
> + * batadv_iv_ogm_emit_wait_time - compute the OGM preparation waiting time
> + * @bat_priv: the bat priv with all the soft interface information
> + *
> + * Returns the amount of jiffies to wait before preparing and sending the
> next + * own OGM
> + */

I'd say "Returns the number of jiffies [..]".


> @@ -468,6 +442,7 @@ static void batadv_iv_ogm_aggregate(struct
> batadv_forw_packet *forw_packet_aggr, memcpy(skb_buff, packet_buff,
> packet_len);
>  	forw_packet_aggr->packet_len += packet_len;
>  	forw_packet_aggr->num_packets++;
> +	forw_packet_aggr->own |= own_packet;
> 
>  	/* save packet direct link flag status */
>  	if (direct_link) {

Using "|= own_packet" isn't strictly necessary because "forw_packet_aggr->own" 
isn't a bit field.
Did you vigorously test this code ? Especially, multi-node with multiple 
interface setups are of interest. Also use different orig intervals to ensure 
it still works everywhere.

The thing is: Throughout the code you can find the implicite assumption of the 
first aggregated packet being an "own packet" (if forw_packet_aggr->own is 
set). Therefore, you have to be very careful changing that logic. One function 
you definitely overlooked is batadv_iv_ogm_send_to_if() but there might be 
others.


> @@ -498,8 +473,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_priv
> *bat_priv,
> 
>  	/* find position for the packet in the forward queue */
>  	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> -	/* own packets are not to be aggregated */
> -	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
> +	if ((atomic_read(&bat_priv->aggregated_ogms))) {
>  		hlist_for_each_entry(forw_packet_pos, tmp_node,
>  				     &bat_priv->forw_bat_list, list) {
>  			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,

Now it gets interesting! Did you review the impact of 
batadv_iv_ogm_can_aggregate() before you bravely removed the exclusion of own 
packets ? That is quite a beast ...


> +/**
> + * batadv_iv_ogm_send - prepare an send an own OGM
> + * @work: kernel work struct
> + *
> + * Prepare the OGM and immediately enqueue it for sending
> + */

prepare and send an own OGM
        ^^^


> +static void batadv_iv_ogm_send(struct work_struct *work)

The naming is less than optimal. bat_iv_ogm.c now has:
 * batadv_iv_ogm_send
 * batadv_iv_ogm_emit


> --- a/types.h
> +++ b/types.h
> @@ -49,6 +49,7 @@ struct batadv_hard_iface_bat_iv {
>  	unsigned char *ogm_buff;
>  	int ogm_buff_len;
>  	atomic_t ogm_seqno;
> +	struct delayed_work work;
>  };

Guess we need some kernel doc for this change too. Since types.h now is fully 
documented ...

Cheers,
Marek
