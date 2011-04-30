Return-Path: <andrew@lunn.ch>
Date: Sat, 30 Apr 2011 19:48:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20110430174839.GC6538@lunn.ch>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1303940106-1457-3-git-send-email-ordex@autistici.org>
	<20110430084226.GM21883@lunn.ch>
	<20110430160027.GC3851@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110430160027.GC3851@ritirata.org>
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

> > You indentation/wrapping is a bit strange. In the function
> > declaration, i would of put the int tt_num_changes directly under int
> > buff_pos.
> 
> This is what I've done, but it seems that your mail client is messing up
> with the tabs (I think).

Possibly. Or the list server. I use mutt, same as you, and it normally
gets tabs and the like correct.

> > > +++ b/packet.h
> > > @@ -30,9 +30,10 @@
> > >  #define BAT_BCAST        0x04
> > >  #define BAT_VIS          0x05
> > >  #define BAT_UNICAST_FRAG 0x06
> > > +#define BAT_TT_QUERY	 0x07
> > 
> > Indentation?
> 
> As above, but in this case I think I'll substitute the tab with spaces so
> that all the BAT_* definitions can be homogeneous

checkpatch might complain, depending on the number of spaces. 
 
> > > +/* TT flags */
> > > +#define TT_RESPONSE	0x00
> > > +#define TT_REQUEST	0x01
> > > +#define TT_FULL_TABLE	0x02
> > > +
> > > @@ -101,6 +109,7 @@ struct unicast_packet {
> > >  	uint8_t  version;  /* batman version field */
> > >  	uint8_t  dest[6];
> > >  	uint8_t  ttl;
> > > +	uint8_t  ttvn; /* destination ttvn */
> > >  } __packed;
> > 
> > What is ttvn? The vn in particular? Is it version? There is already
> > ver and version used, do we want yet another way to say version?
> > 
> 
> Translation Table Version Number. 'ttvn' is the abbreviation used in the
> documentation, so I decided to use it as field name. Only in the struct
> orig_node it is called last_tt_ver_num. Do you think I should use the
> latter everywhere? 'ttvn' is really nice and compact :)

It is a minor point. ttvn is O.K. But how about ttver? 

> 
> 
> > > @@ -134,4 +143,25 @@ struct vis_packet {
> > >  	uint8_t  sender_orig[6]; /* who sent or rebroadcasted this packet */
> > >  } __packed;
> > >  
> > > +struct tt_query_packet {
> > > +	uint8_t  packet_type;
> > > +	uint8_t  version;  /* batman version field */
> > > +	uint8_t  dst[6];
> > > +	uint8_t  ttl;
> > > +	uint8_t  flags;		/* bit0: 0: -> tt_request
> > > +				 *	 1: -> tt_response
> > > +				 * bit1: request the full table
> > > +				 */
> > 
> > Rather than document the bits, it would be better to reference to the
> > macros TT_*. Somebody at some time with add new flags, or change the
> > values and not update this description.
> 
> Mh..Honestly I prefer to understand what each bit means in a bitfield
> flag. What do you mean with reference to the macros? 

I mean say that flags is a combination of TT_RESPONSE, TT_REQUEST,
TT_FULL_TABLE. The TT_* macros.

> > > +	uint8_t  src[6];
> > > +	uint8_t  ttvn;		/* if tt_request: ttvn that triggered the
> > > +				 *		  request
> > > +				 * if tt_response: new ttvn for the src
> > > +				 * orig_node
> > > +				 */
> > > +	uint16_t tt_data;	/* if tt_request: crc associated with the
> > > +				 *		   ttvn
> > > +				 * if tt_response: table_size
> > > +				 */
> > 
> > Maybe a union instead of tt_data being used for two different things?
> > Makes it less confusing when reading the code.
> 
> I decided to avoid a union because here we have two different things
> which have exactly the same length. So I opted for a "generic" name.
> What do style experts suggest? :)
> A union would probably make easier to understand what is going on while
> reading the code, as Andrew suggested.

I believe in the saying: Code is written once, read a 100 times, so
make it easy to read.

> > > +	/* the ttvn increased by one -> we can apply the attached changes */
> > > +	if (ttvn - orig_ttvn == 1) {
> > > +		/* if it does not contain the changes send a tt request */
> > > +		if (!tt_num_changes)
> > > +			goto request_table;
> > 
> > Why would that happen? It sounds like you are handling a bug, not
> > something which is designed to happen. 
> >
> 
> We have two cases which would lead to this situation:
> 1) An OGM, after being sent TT_OGM_APPEND_MAX times, will not contain
> the changes anymore. If a node missed all the "full" OGMs, it will
> end up in this situation when receiving the next one.
> 2) The set of changes is too big to be appended to the OGM (due to the frame
> maximum size). The receiving node will send a tt_request to recover the
> changes (later on, it could also exploit the fragmentation, while the
> OGM cannot)

O.K. so there is a good reason. So maybe hint about these reasons in
the comment? Help the reader understand why it might happen.

> Yes, memory problem. Actually it is not possible to make two passes:
> e.g. imagine that the set of changes is the following:
> - DEL A
> - ADD A
> - DEL A
> (ok it is probably not really common, but still possible)

And since it will not happen to often, it is not worth the code so
find such situations and simply the transactions.

> Remember that we added the TT_CRC. It was born as conutermeasure to node
> reboots, but now we are exploiting it as consistency check! This is why
> the code recomputes the crc after applying every change set. If something
> went wrong, on the next OGM the node will recognise the problem and ask
> for a "full table".

O.K. a clean self recovery. That is good.

> > > +	if (tt_query->flags & TT_REQUEST) {
> > > +		/* Try to reply to this tt_request */
> > > +		ret = send_tt_response(bat_priv, tt_query);
> > > +		if (ret != NET_RX_SUCCESS) {
> > 
> > This looks wrong. The name send_tt_response() suggests we are sending,
> > but you compare against NET_RX_SUCCESS!
> 
> eheh you're nearly right. We are sending a tt_response here, BUT only if we
> have enough information to send such message we can consider the
> tt_request as correctly received, otherwise, as the code below suggests,
> we have to re-route the packet and so let route_unicast_packet() decide
> whether the mesage was correctly received or not.

You definitely need a comment here. It is so counter intuitive that
you are bound to get bug reports and patches by people who see this. 

> > > +			bat_dbg(DBG_ROUTES, bat_priv,
> > > +				"Routing TT_REQUEST to %pM [%c]\n",
> > > +				tt_query->dst,
> > > +				(tt_query->flags & TT_FULL_TABLE ? 'F' : '.'));
> > > +			tt_query->tt_data = htons(tt_query->tt_data);
> > > +			return route_unicast_packet(skb, recv_if);
> > > +		}
> > > +		goto out;
> > > +	}
> > > +	/* We need to linearize the packet to access the TT data */
> > > +	if (skb_linearize(skb) < 0)
> > > +		goto out;
> > 
> > Isn't this too late. You have already accessed tt_query->tt_data in
> > the code above?
> > 
> 
> the access to the tt_data field is guaranteed by 
>
> pskb_may_pull(skb, sizeof(struct tt_query_packet))
> 
> (a few lines above inside the function), while here we are linearising the
> skb to let handle_tt_reponse access the data contained after the header.

Ah, O.K. The comment is ambiguous and i got the wrong meaning. Maybe
the comment could be:

	/* We need to linearize the packet to access the TT change records */

	Andrew	
