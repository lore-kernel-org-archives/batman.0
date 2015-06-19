Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 19 Jun 2015 17:43:37 +0800
Message-ID: <2847732.AL4EavTU5J@voltaire>
In-Reply-To: <1674100.1XU1fCZBAt@bentobox>
References: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
 <1674100.1XU1fCZBAt@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1713152.GSRoOHlBrQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert tt request list into
	hlist
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1713152.GSRoOHlBrQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, June 19, 2015 11:32:00 Sven Eckelmann wrote:
> On Friday 19 June 2015 15:09:18 Marek Lindner wrote:
> >  		spin_lock_bh(&bat_priv->tt.req_list_lock);
> > 
> > -		list_del(&tt_req_node->list);
> > +		/* only remove tt_req_node if it still is in the list */
> > +		if (!hlist_unhashed(&tt_req_node->list))
> > +			hlist_del_init(&tt_req_node->list);
> > 
> >  		spin_unlock_bh(&bat_priv->tt.req_list_lock);
> >  		kfree(tt_req_node);
> >  	
> >  	}
> 
> hlist_del_init doesn't require the hlist_unhashed check because this is
> already done inside of this function [1].

Thanks! I did not know that. Will send a v2 shortly.

Cheers,
Marek

--nextPart1713152.GSRoOHlBrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVg+RJAAoJEFNVTo/uthzAi2sH+gIs+SeK6U0d2EMVY/XxoLsi
oV7Daia4Z2v771HCNHoB88pCSOAsHx5Ca6QSJ+x/FR31niOf23RE2VnEXsUHFgOq
ArxTmPPkOlBYHY5380JfoBKJ08kmE7avt92tPP4f45haOuUcKdiG+T0e7GY/+bQM
HZwM7gGA4sV41pjQS0FaiLtdXZSk9alL44sSbYU3bLZLCcTP6Rc0SxQiiLrHg+sP
+TsWv+1V9oXL9EaA3BAtklcF/20FZgY/9tbaKEE8plPJ9rHNo0pYLyfkjPJfI0Yn
LfvnJBDQGYSEaSkxx8PyVdaKMgTvueSa6I3+TfPjisfS6iMR9V89LYRf8H1oYaA=
=XJ8q
-----END PGP SIGNATURE-----

--nextPart1713152.GSRoOHlBrQ--

