Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Nov 2012 09:15:44 +0800
References: <cover.1353331252.git.martin@hundeboll.net>
 <e0944b8b9fcc9f288f11789a5f7f499b266caa2a.1353331252.git.martin@hundeboll.net>
 <20121126004117.GI14547@ritirata.org>
In-Reply-To: <20121126004117.GI14547@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201211260915.44897.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 2/6] batman-adv: Detect coding nodes and
	remove these after timeout
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
Cc: Martin =?iso-8859-15?q?Hundeb=F8ll?= <martin@hundeboll.net>

On Monday, November 26, 2012 08:41:17 Antonio Quartulli wrote:
> >  struct batadv_priv_nc {
> >  
> >  	struct delayed_work work;
> > 
> > +	struct dentry *debug_dir;
> > +	u8 min_tq;
> 
> If I am not mistaken min_tq is never modified. Why do we need to store it
> in a bat_priv field? And being a constant is it worth a define? In this
> way it an be easily found and tuned like the other constant params.

It can be modified via debugfs:

+       file = debugfs_create_u8("min_tq", S_IRUGO | S_IWUSR, nc_dir,
+                                &bat_priv->nc.min_tq);


Cheers,
Marek
