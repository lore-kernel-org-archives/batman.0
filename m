Return-Path: <simon@open-mesh.com>
From: Simon Wunderlich <simon@open-mesh.com>
Date: Thu, 25 Jun 2015 14:00:31 +0200
Message-ID: <2302094.zTNhOhfvN8@prime>
In-Reply-To: <558AE222.4050806@meshcoding.com>
References: <1435150249-25322-1-git-send-email-sw@simonwunderlich.de>
 <558AE222.4050806@meshcoding.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: remove obsolete deleted
	attribute for gateway node
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <antonio@meshcoding.com>

On Wednesday 24 June 2015 19:00:18 Antonio Quartulli wrote:
> On 24/06/15 14:50, Simon Wunderlich wrote:
> > @@ -537,9 +529,15 @@ void batadv_gw_node_update(struct batadv_priv
> > *bat_priv,> 
> >  		/* Note: We don't need a NULL check here, since curr_gw never
> >  		
> >  		 * gets dereferenced.
> >  		 */
> > 
> > +		spin_lock_bh(&bat_priv->gw.list_lock);
> > +		hlist_del_rcu(&gw_node->list);
> > +		spin_unlock_bh(&bat_priv->gw.list_lock);
> > +
> 
> have you verified that we can't get to this point through two threads
> and enter the same problem that Sven and Marek have been discussing and
> fixing in these days: removing an element from a list twice
> 
> If this is possible, you should check that this element is in the list
> before deleting it.

That's an excellent point, I didn't check that. It also appears a little 
complicated, so I'll add some more protection at this point and resend v2.

Thank you!
     Simon
