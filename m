Return-Path: <linus.luessing@web.de>
Date: Thu, 10 Feb 2011 11:42:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110210104250.GA13038@Sellars>
References: <201102031802.52134.lindner_marek@yahoo.de>
	<1296832896-30081-6-git-send-email-linus.luessing@ascom.ch>
	<201102081418.38151.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201102081418.38151.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/7] batman-adv: Make bat_priv->curr_gw
 an rcu protected pointer
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

On Tue, Feb 08, 2011 at 02:18:37PM +0100, Marek Lindner wrote:
> 
> On Friday 04 February 2011 16:21:34 Linus Lüssing wrote:
> > +	if (curr_gw) {
> > +		rcu_read_unlock();
> >  		return;
> > +	}
> > 
> > -	rcu_read_lock();
> >  	if (hlist_empty(&bat_priv->gw_list)) {
> > -		rcu_read_unlock();
> > 
> > -		if (bat_priv->curr_gw) {
> > +		if (curr_gw) {
> > +			rcu_read_unlock();
> >  			bat_dbg(DBG_BATMAN, bat_priv,
> >  				"Removing selected gateway - "
> >  				"no gateway in range\n");
> >  			gw_deselect(bat_priv);
> >  		}
> > +		else
> > +			rcu_read_unlock();
> 
> This is a bit odd here - we return if curr_gw is not NULL and later we print a 
> message if curr_gw is not NULL ? 
> The issue existed before your patch came along.
That's right. What do you think, is it worth an extra patch as it
is not a problem which patch 5/7 does not really try to address?
> 
> 
> >  void gw_check_election(struct bat_priv *bat_priv, struct orig_node
> > *orig_node) {
> > -	struct gw_node *curr_gateway_tmp = bat_priv->curr_gw;
> > +	struct gw_node *curr_gateway_tmp;
> >  	uint8_t gw_tq_avg, orig_tq_avg;
> > 
> > +	rcu_read_lock();
> > +	curr_gateway_tmp = rcu_dereference(bat_priv->curr_gw);
> >  	if (!curr_gateway_tmp)
> > -		return;
> > +		goto rcu_unlock;
> > 
> >  	if (!curr_gateway_tmp->orig_node)
> >  		goto deselect;
> 
> It seems if we jump to "deselect" here the rcu_lock() will never be unlocked.
True, will add that rcu_read_unlock() in the deselect jump mark.

> 
> 
> > @@ -316,7 +342,7 @@ void gw_node_purge(struct bat_priv *bat_priv)
> > -		if (bat_priv->curr_gw == gw_node)
> > +		if (rcu_dereference(bat_priv->curr_gw) == gw_node)
> >  			gw_deselect(bat_priv);
> 
> At this point we neither hold a rcu_lock() nor the newly created spinlock ...
True again. I would prefer just adding an rcu-lock here...
> 
> 
> >  	spinlock_t gw_list_lock; /* protects gw_list */
> > +	spinlock_t curr_gw_lock; /* protects curr_gw updates */
> 
> Would speak anything against re-using the gw_list_lock ?
... as we are usually changing the gw_list more often than the
curr_gw, so it's not really necessary to let a gw_list change for
another node wait for a curr_gw_node reassignment to finish.
What is speaking for using the same lock for both, just having
less spinlocks in total in the code?
Does anyone know how it is usually done in the rest of the kernel,
are people tending to reduce the atomic context to the minimum
amount needed? Or is it usually a trade-off between two many locks
and and small atomic contexts?
> 
> Regards,
> Marek
> 
Cheers, Linus
