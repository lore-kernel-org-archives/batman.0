Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 4 Feb 2014 17:46:02 +0100
References: <1390816116-23804-1-git-send-email-linus.luessing@web.de>
 <1410522.xVbSBtgclD@diderot> <20140204020018.GB28274@Linus-Debian>
In-Reply-To: <20140204020018.GB28274@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402041746.03043.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/6] batman-adv: Send multicast packets
	to nodes with a WANT_ALL flag
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

> > Maybe I am missing the whole point of WANT_ALL but why do we maintain a
> > list of WANT_ALL nodes to only send the packet to the first valid entry
> > in the list?
> 
> Hm, the thing is, there can be multiple nodes with that flag. But
> most of the time we only end up in this function when there's just
> a single node in this list. (when there's more than one, we'd
> usually end up in the broadcast instead of unicasting path)

As far as I see, send_skb_via_mcast() is only called if forw_mode returned 
BATADV_FORW_SINGLE, that is there is only one recipient in the list, and there 
is no "regular" listener in TT.

(I don't see any good reason for calling that "most of the time" and 
"usually")

> 
> We could remove the list entirely but then we'd have to loop over
> all orig_nodes and check their mcast_flags for every packet -
> which is too costly on the fast path.
> 
> We could replace these two lists by two variables holding a single
> originator address or orig_node each. But then we'd still have to
> loop over all originators when the numbers of nodes with such a
> flag decreases to one to find this one node to update the variable
> with.
> 
> 
> But yes, this pointer pointer to a list head is not really nice
> either... what do you think about returning a pointer pointer to
> an orig_node with batadv_mcast_want_all_count() already, instead?
> That way we'd spare checking the IP address family twice, too. Or
> the list-to-orig_node-variable substitution approach?

I think that would be good to do (returning an orig_node, that is). And also 
please return an orig_node if a TT match was found for the single case.

With this we would unify the multicast sending in batadv_interface_tx() as 
well which would make it more readable. Right now mcast packets are sent via 
batadv_send_skb_via_mcast() if the want_all_list is present or via 
batadv_send_skb_via_tt() if want_all_list is not present, which isn't exactly 
easy to understand. :)

something like

                        forw_mode = batadv_mcast_forw_mode(bat_priv, skb,
                                                           &mcast_single_orig);

and then in the unicast branch below

     } else if (mcast_single_orig) {
               ret = batadv_send_skb_unicast(bat_priv, skb, BATADV_UNICAST, 0, 
mcast_single_orig, vid);
     }

should do the trick, no?

Thanks,
    Simon
