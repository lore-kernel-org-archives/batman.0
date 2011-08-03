Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Aug 2011 07:31:52 +0200
References: <1310255457-26009-1-git-send-email-ordex@autistici.org>
	<201107232317.23438.lindner_marek@yahoo.de>
	<20110731215318.GA25702@ritirata.org.org>
In-Reply-To: <20110731215318.GA25702@ritirata.org.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201108030731.52934.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: handle hash_add() return
	value in the TT code
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

On Sunday, July 31, 2011 23:53:19 Antonio Quartulli wrote:
> > > +	hash_added = hash_add(bat_priv->tt_local_hash, compare_ltt,
> > > +			      choose_orig, tt_local_entry,
> > > +			      &tt_local_entry->hash_entry);
> > > +	if (hash_added != 0)
> > > +		tt_local_entry_free_ref(tt_local_entry);
> > > +
> > > +	if (hash_added < 0)
> > > +		goto out;
> > 
> > No matter whether we add a new element to the tt hash or not we always
> > generate a log message and throw a tt_local_event(). Is that what we want
> > ?
> 
> What about going to 'out' in case of hash_added != 0? In both cases (<0 or
> >0) we cannot go ahead with the function as the entry has already been
> added or it is not possible to add it.

If I am not mistaken we should keep the additional "tt_local_entry_free_ref()" 
because we initialize the newly allocated struct with 2.
Still, the original problem remains: We generate a log message claiming to 
have added a new entry even though it might fail later. You have to move the 
log message to the end of the function.


> > > +		hash_added = hash_add(bat_priv->tt_global_hash, compare_gtt,
> > > +				      choose_orig, tt_global_entry,
> > > +				      &tt_global_entry->hash_entry);
> > > +		if (hash_added != 0)
> > > +			tt_global_entry_free_ref(tt_global_entry);
> > > +
> > > +		if (hash_added < 0)
> > > +			goto out;
> > > +
> > > +		if (!hash_added)
> > > +			atomic_inc(&orig_node->tt_size);
> > 
> > Here we only generate a log message when the element has been added or
> > already exists. Do we want that too ?
> 
> The same as before.

Yeah, same problem as above.  :-)

Cheers,
Marek
