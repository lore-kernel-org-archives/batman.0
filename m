Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 26 Apr 2012 13:49:29 +0800
References: <1335170112-6610-1-git-send-email-lindner_marek@yahoo.de>
	<20120424131556.GD1015@ritirata.org>
In-Reply-To: <20120424131556.GD1015@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201204261349.30120.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: turn tt commit code into
	routing protocol agnostic API
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


Hi,

> thank you for your effort in improving the TT code :)

I try to make the TT code a better place.  ;-)


> > +	if (hard_iface == primary_if)
> > +		tt_num_changes = tt_append_changes(bat_priv,
> > +						   &hard_iface->packet_buff,
> > +						   &hard_iface->packet_len,
> > +						   BATMAN_OGM_HLEN);
> > +
> > +	if (tt_num_changes > 0)
> > +		batman_ogm_packet->tt_num_changes = tt_num_changes;
> > +	else
> > +		batman_ogm_packet->tt_num_changes = 0;
> 
> Do we really need this if-loop? Am I wrong or tt_num_changes can only be >=
> 0 ?

Right, strictly speaking it is not needed. However, tt_append_changes() is 
defined as returning int, hence the calling function can't rely on this 
assumption.


> > -int tt_changes_fill_buffer(struct bat_priv *bat_priv,
> > -			   unsigned char *buff, int buff_len)
> > +static void tt_realloc_packet_buff(unsigned char **packet_buff,
> > +				   int *packet_buff_len, int min_packet_len,
> > +				   int new_packet_len)
> > +{
> > +	unsigned char *new_buff;
> > +
> > +	new_buff = kmalloc(new_packet_len, GFP_ATOMIC);
> > +
> > +	/* keep old buffer if kmalloc should fail */
> > +	if (new_buff) {
> > +		memcpy(new_buff, *packet_buff, min_packet_len);
> > +		kfree(*packet_buff);
> > +		*packet_buff = new_buff;
> > +		*packet_buff_len = new_packet_len;
> > +	}
> 
> I took quite a while to understand what happens to packet_buff_len if
> kmalloc failed. Actually it correctly stores the "previous" buffer size, so
> the rest of the code will handle kmalloc failures the right way. :)

Actually, this part of the code did not change. Check realloc_packet_buffer() 
in send.c and you will find the same function.


> > +}
> > +
> > +static void tt_prepare_packet_buff(struct bat_priv *bat_priv,
> > +				   unsigned char **packet_buff,
> > +				   int *packet_buff_len, int min_packet_len)
> > +{
> > +	struct hard_iface *primary_if;
> > +	int req_len;
> > +
> > +	primary_if = primary_if_get_selected(bat_priv);
> > +
> > +	req_len = min_packet_len;
> > +	req_len += tt_len((uint8_t)atomic_read(&bat_priv->tt_local_changes));
> 
> This cast is also in the current code. But why not removing it? atomic_t is
> an int, the tt_len() argument too.

No idea why the cast is there. I'll remove it.  :-)


> > +
> > +	/* if we have too many changes for one packet don't send any
> > +	 * and wait for the tt table request which will be fragmented */
> 
> please fix this comment. */ must be on a new line.

Ok, I'll fix it. Just a quick reminder that this is old code as well ..


> > +static int tt_changes_fill_buff(struct bat_priv *bat_priv,
> > +				unsigned char **packet_buff,
> > +				int *packet_buff_len, int min_packet_len)
> > 
> >  {
> > 
> > -	int count = 0, tot_changes = 0;
> > 
> >  	struct tt_change_node *entry, *safe;
> > 
> > +	int count = 0, tot_changes = 0, new_len;
> > +	unsigned char *tt_buff;
> > +
> 
> As suggesting on IRC we should lock the "read and copy procedure".
> I'd call lock() here.
> 
> > +	tt_prepare_packet_buff(bat_priv, packet_buff,
> > +			       packet_buff_len, min_packet_len);
> > 
> > -	if (buff_len > 0)
> > -		tot_changes = buff_len / tt_len(1);
> > +	new_len = *packet_buff_len - min_packet_len;
> > 
> > 
> > 
> > +	tt_buff = *packet_buff + min_packet_len;
> > +
> > +	if (new_len > 0)
> > +		tot_changes = new_len / tt_len(1);
> > 
> >  	spin_lock_bh(&bat_priv->tt_changes_list_lock);
> >  	atomic_set(&bat_priv->tt_local_changes, 0);
> > 
> > @@ -290,7 +339,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_priv,
> > 
> >  	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
> >  	
> >  				 list) {
> >  		
> >  		if (count < tot_changes) {
> > 
> > -			memcpy(buff + tt_len(count),
> > +			memcpy(tt_buff + tt_len(count),
> > 
> >  			       &entry->change, sizeof(struct tt_change));
> >  			
> >  			count++;
> >  		
> >  		}
> 
> and I'd call unlock() after having copied everything to the tt_buff and
> emptied the changes list. Can we directly use
> bat_priv->tt_changes_list_lock ? It seems to be the case :)

I'd rather move the locking into a separate patch to make it easier to trace 
the change.


> > 
> >  	/* all the reset entries have now to be effectively counted as local
> >  	
> >  	 * entries */
> >  	
> >  	atomic_add(changed_num, &bat_priv->num_local_tt);
> >  	tt_local_purge_pending_clients(bat_priv);
> > 
> > +	bat_priv->tt_crc = tt_local_crc(bat_priv);
> > 
> >  	/* Increment the TTVN only once per OGM interval */
> >  	atomic_inc(&bat_priv->ttvn);
> >  	bat_dbg(DBG_TT, bat_priv, "Local changes committed, updating to ttvn
> >  	%u\n",
> >  	
> >  		(uint8_t)atomic_read(&bat_priv->ttvn));
> >  	
> >  	bat_priv->tt_poss_change = false;
> > 
> > +
> > +	/* reset the sending counter */
> > +	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
> > +
> > +	return tt_changes_fill_buff(bat_priv, packet_buff,
> > +				    packet_buff_len, packet_min_len);
> > +}
> 
> As you suggested on IRC, we may want to envelop this function with a
> lock/unlock to force exclusive access to the local table and to the event
> list.
>
> We should apply the same lock in tt_local_add()/del() I think.


Why do want to lock tt_changes_fill_buff() and tt_commit_changes() separately? 
We should already lock in tt_commit_changes() because the entire commit has to 
be an atomic operation. Several of the function calls in tt_commit_changes() 
depend on the fact that no client is purged or added while these functions 
run.

Thanks for your comments!

Cheers,
Marek
