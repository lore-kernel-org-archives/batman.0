Return-Path: <ordex@autistici.org>
Date: Sat, 30 Apr 2011 18:00:27 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110430160027.GC3851@ritirata.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110430084226.GM21883@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110430084226.GM21883@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: improved client
 announcement mechanismy
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

On sab, apr 30, 2011 at 10:42:26 +0200, Andrew Lunn wrote:
> Hi Antonia

Hi Andrew, hi all

(don't worry for the typo ;) )

> > For details, please visit:
> > http://www.open-mesh.org/wiki/batman-adv/Hna-improvements
> 
> This is a nice summary of the idea. The LaTeX document is also good.
> Great to see documentation...

A research project has been made upon this topic, indeed that document
is an old draft of part of the project report. (The whole report will be
published as soon as it is ready)

> 
> >  /* is there another aggregated packet here? */
> > -static inline int aggregated_packet(int buff_pos, int packet_len, int num_tt)
> > +static inline int aggregated_packet(int buff_pos, int packet_len,
> > +				    int tt_num_changes)
> >  {
> > -	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (num_tt * ETH_ALEN);
> > +	int next_buff_pos = buff_pos + BAT_PACKET_LEN + (tt_num_changes *
> > +						sizeof(struct tt_change));
> 
> You indentation/wrapping is a bit strange. In the function
> declaration, i would of put the int tt_num_changes directly under int
> buff_pos.

This is what I've done, but it seems that your mail client is messing up
with the tabs (I think).

> For next_buff_pos i would of put the whole ( ) subexpression
> on the next line, not split it in half. This happens throughout the
> patch.
> 
> > +#define TT_OGM_APPEND_MAX 3 /* number of OGMs sent with the last tt diff */
> > +
> > +/* Transtable operations */
> > +#define TT_ADD 0
> > +#define TT_DEL 1
> 
> > +
> > +++ b/packet.h
> > @@ -30,9 +30,10 @@
> >  #define BAT_BCAST        0x04
> >  #define BAT_VIS          0x05
> >  #define BAT_UNICAST_FRAG 0x06
> > +#define BAT_TT_QUERY	 0x07
> 
> Indentation?

As above, but in this case I think I'll substitute the tab with spaces so
that all the BAT_* definitions can be homogeneous

> 
> >  
> >  /* this file is included by batctl which needs these defines */
> > -#define COMPAT_VERSION 12
> > +#define COMPAT_VERSION 14
> 
> What happened to version 13? It suggests this diff is against an older
> version of batman. Is there going to be merging problems?
> 

There was a problem with the COMPAT_VERSION so I had to jump to 14 (I can't
really remember the details, Marek should know something more :))

> > @@ -52,6 +53,11 @@
> >  #define UNI_FRAG_HEAD 0x01
> >  #define UNI_FRAG_LARGETAIL 0x02
> >  
> > +/* TT flags */
> > +#define TT_RESPONSE	0x00
> > +#define TT_REQUEST	0x01
> > +#define TT_FULL_TABLE	0x02
> > +
> > @@ -101,6 +109,7 @@ struct unicast_packet {
> >  	uint8_t  version;  /* batman version field */
> >  	uint8_t  dest[6];
> >  	uint8_t  ttl;
> > +	uint8_t  ttvn; /* destination ttvn */
> >  } __packed;
> 
> What is ttvn? The vn in particular? Is it version? There is already
> ver and version used, do we want yet another way to say version?
> 

Translation Table Version Number. 'ttvn' is the abbreviation used in the
documentation, so I decided to use it as field name. Only in the struct
orig_node it is called last_tt_ver_num. Do you think I should use the
latter everywhere? 'ttvn' is really nice and compact :)


> > @@ -134,4 +143,25 @@ struct vis_packet {
> >  	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
> >  } __packed;
> >  
> > +struct tt_query_packet {
> > +	uint8_t  packet_type;
> > +	uint8_t  version;  /* batman version field */
> > +	uint8_t  dst[6];
> > +	uint8_t  ttl;
> > +	uint8_t  flags;		/* bit0: 0: -> tt_request
> > +				 *	 1: -> tt_response
> > +				 * bit1: request the full table
> > +				 */
> 
> Rather than document the bits, it would be better to reference to the
> macros TT_*. Somebody at some time with add new flags, or change the
> values and not update this description.

Mh..Honestly I prefer to understand what each bit means in a bitfield
flag. What do you mean with reference to the macros? Should I explain
here which macro can be assigned to the field?

> 
> 
> > +	uint8_t  src[6];
> > +	uint8_t  ttvn;		/* if tt_request: ttvn that triggered the
> > +				 *		  request
> > +				 * if tt_response: new ttvn for the src
> > +				 * orig_node
> > +				 */
> > +	uint16_t tt_data;	/* if tt_request: crc associated with the
> > +				 *		   ttvn
> > +				 * if tt_response: table_size
> > +				 */
> 
> Maybe a union instead of tt_data being used for two different things?
> Makes it less confusing when reading the code.

I decided to avoid a union because here we have two different things
which have exactly the same length. So I opted for a "generic" name.
What do style experts suggest? :)
A union would probably make easier to understand what is going on while
reading the code, as Andrew suggested.

> > +	/* the ttvn increased by one -> we can apply the attached changes */
> > +	if (ttvn - orig_ttvn == 1) {
> > +		/* if it does not contain the changes send a tt request */
> > +		if (!tt_num_changes)
> > +			goto request_table;
> 
> Why would that happen? It sounds like you are handling a bug, not
> something which is designed to happen. 
>

We have two cases which would lead to this situation:
1) An OGM, after being sent TT_OGM_APPEND_MAX times, will not contain
the changes anymore. If a node missed all the "full" OGMs, it will
end up in this situation when receiving the next one.
2) The set of changes is too big to be appended to the OGM (due to the frame
maximum size). The receiving node will send a tt_request to recover the
changes (later on, it could also exploit the fragmentation, while the
OGM cannot)

> > +
> > +		for (count = 0; count < tt_num_changes; count++) {
> > +			tt_change = (struct tt_change *) tt_buff + count;
> > +			/* Check for the change op */
> > +			if (tt_change->op == TT_DEL)
> > +				tt_global_del(bat_priv, orig_node,
> > +					      tt_change->addr,
> > +					      "tt remotely removed");
> > +			else
> > +				if (!tt_global_add(bat_priv, orig_node,
> > +							tt_change->addr,
> > +							ttvn))
> > +					/* In case of problem while storing a
> > +					 * global_entry, we stop the updating
> > +					 * procedure without committing the
> > +					 * ttvn change. This will avoid to send
> > +					 * corrupted data on tt_request
> > +					 */
> > +					return;
> 
> Why would an add fail? Because we are out of space? Does it make sense
> to have two passes over the changes. The first pass does all the
> deletes and the second pass the adds? Does that make it less likely
> the add will fail?

Yes, memory problem. Actually it is not possible to make two passes:
e.g. imagine that the set of changes is the following:
- DEL A
- ADD A
- DEL A
(ok it is probably not really common, but still possible)
If we make two passes we will have A again in the table while it should not be
there.
By the way, if we are going to add a client which is already in the
table, we will not allocate more memory, but we will simply change
the "pointer" of the originator serving such client in our structure
(tt_global_entry->orig_node).

> 
> Also, the ttvn still has the old value, but some of the new content.
> Does this cause problems when somebody makes a request for the ttvn
> with the old value? The requester gets something between ttvn and
> ttvn+1, but thinks it has ttvn. Can subsequent updates work?

Remember that we added the TT_CRC. It was born as conutermeasure to node
reboots, but now we are exploiting it as consistency check! This is why
the code recomputes the crc after applying every change set. If something
went wrong, on the next OGM the node will recognise the problem and ask
for a "full table".
Moreover the crc is sent within the tt_request message, so
that if a intermediate node doesn't match it, the request is forwarded
instead of immediatly reply.

> >  	bat_dbg(DBG_BATMAN, bat_priv,
> >  		"Received BATMAN packet via NB: %pM, IF: %s [%pM] "
> > -		"(from OG: %pM, via prev OG: %pM, seqno %d, tq %d, "
> > -		"TTL %d, V %d, IDF %d)\n",
> > +		"(from OG: %pM, via prev OG: %pM, seqno %d, ttvn %u, "
> > +		"crc %u, changes %u, td %d, TTL %d, V %d, IDF %d)\n",
> >  		ethhdr->h_source, if_incoming->net_dev->name,
> >  		if_incoming->net_dev->dev_addr, batman_packet->orig,
> >  		batman_packet->prev_sender, batman_packet->seqno,
> > -		batman_packet->tq, batman_packet->ttl, batman_packet->version,
> > +		batman_packet->tt_ver_num, batman_packet->tt_crc,
> > +		batman_packet->tt_num_changes, batman_packet->tq,
> > +		batman_packet->ttl, batman_packet->version,
> >  		has_directlink_flag);
> 
> I think this is the information bisect uses to look for routing loops
> etc. Do you plan to extend bisect to look for TT problems? Does it
> make sense to add a new DBG_TT which dumps the adds and removes in the
> OGM?

Sounds good to me :)

> > +	if (tt_query->flags & TT_REQUEST) {
> > +		/* Try to reply to this tt_request */
> > +		ret = send_tt_response(bat_priv, tt_query);
> > +		if (ret != NET_RX_SUCCESS) {
> 
> This looks wrong. The name send_tt_response() suggests we are sending,
> but you compare against NET_RX_SUCCESS!

eheh you're nearly right. We are sending a tt_response here, BUT only if we
have enough information to send such message we can consider the
tt_request as correctly received, otherwise, as the code below suggests,
we have to re-route the packet and so let route_unicast_packet() decide
whether the mesage was correctly received or not.

> 
> > +			bat_dbg(DBG_ROUTES, bat_priv,
> > +				"Routing TT_REQUEST to %pM [%c]\n",
> > +				tt_query->dst,
> > +				(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
> > +			tt_query->tt_data = htons(tt_query->tt_data);
> > +			return route_unicast_packet(skb, recv_if);
> > +		}
> > +		goto out;
> > +	}
> > +	/* We need to linearize the packet to access the TT data */
> > +	if (skb_linearize(skb) < 0)
> > +		goto out;
> 
> Isn't this too late. You have already accessed tt_query->tt_data in
> the code above?
> 

the access to the tt_data field is guaranteed by 

pskb_may_pull(skb, sizeof(struct tt_query_packet))

(a few lines above inside the function), while here we are linearising the
skb to let handle_tt_reponse access the data contained after the header.
(If I correctly understood how the skb work, this should be ok).
The comment refers to the data carried by the tt_response, not to the
tt_data field.


> > +	diff = unicast_packet->ttvn - curr_ttvn;
> > +	/* Check whether I have to reroute the packet */
> > +	if (unicast_packet->packet_type == BAT_UNICAST &&
> > +	    (diff < 0 && diff > -0xff/2)) {
> 
> Are there no helper methods to do this wrap around comparison in one
> of the linux header files?

Honestly, I don't know. I'll investigate on it..

> 
>    Andrew

Andrew thank you very much for reading the patches and for all your
suggestion/criticism/corrections!

Regards,

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
