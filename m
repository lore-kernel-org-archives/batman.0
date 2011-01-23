Return-Path: <linus.luessing@web.de>
Date: Sun, 23 Jan 2011 01:52:33 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110123005233.GB19219@Sellars>
References: <1295659302-7171-1-git-send-email-linus.luessing@saxnet.de>
	<1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1295659302-7171-8-git-send-email-linus.luessing@saxnet.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 07/19] batman-adv: Prepare and send own
 multicast tracker packets
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

> +struct tracker_packet_state {
> +	int mcast_num, dest_num;
> +	struct mcast_entry *mcast_entry;
> +	uint8_t *dest_entry;
> +	int break_flag;
> +};
> +
> +static void init_state_mcast_entry(struct tracker_packet_state *state,
> +				   struct mcast_tracker_packet *tracker_packet)
> +{
> +	state->mcast_num = 0;
> +	state->mcast_entry = (struct mcast_entry *)(tracker_packet + 1);
> +	state->dest_entry = (uint8_t *)(state->mcast_entry + 1);
> +}
> +
> +static int check_state_mcast_entry(struct tracker_packet_state *state,
> +				   struct mcast_tracker_packet *tracker_packet)
> +{
> +	if (state->mcast_num < tracker_packet->num_mcast_entries &&
> +	    !state->break_flag)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void inc_state_mcast_entry(struct tracker_packet_state *state)
> +{
> +	state->mcast_num++;
> +	state->mcast_entry = (struct mcast_entry *)state->dest_entry;
> +	state->dest_entry = (uint8_t *)(state->mcast_entry + 1);
> +}
> +
> +static void init_state_dest_entry(struct tracker_packet_state *state)
> +{
> +	state->dest_num = 0;
> +	state->break_flag = 1;
> +}
> +
> +static int check_state_dest_entry(struct tracker_packet_state *state)
> +{
> +	if (state->dest_num < state->mcast_entry->num_dest)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void inc_state_dest_entry(struct tracker_packet_state *state)
> +{
> +	state->dest_num++;
> +	state->dest_entry += ETH_ALEN;
> +	state->break_flag = 0;
> +}
> +
> +#define tracker_packet_for_each_dest(state, tracker_packet)		 \
> +	for (init_state_mcast_entry(state, tracker_packet);		 \
> +	     check_state_mcast_entry(state, tracker_packet);		 \
> +	     inc_state_mcast_entry(state))				 \
> +		for (init_state_dest_entry(state);			 \
> +		     check_state_dest_entry(state);			 \
> +		     inc_state_dest_entry(state))

Mixed up the logic of the new state.break_flag a little. Might be fixed
upstream (didn't have the time to test it yet). Will be fixed and
tested with next patchset.

Cheers, Linus
