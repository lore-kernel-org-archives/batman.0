Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 15 Jun 2011 23:42:38 +0200
References: <1307307664-19910-1-git-send-email-ordex@autistici.org>
	<1307307664-19910-4-git-send-email-ordex@autistici.org>
	<20110605215552.GX4071@lunn.ch>
In-Reply-To: <20110605215552.GX4071@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106152342.39423.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: implement AP-isolation
	on the receiver side
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

On Sunday, June 05, 2011 11:55:52 PM Andrew Lunn wrote:
> > diff --git a/translation-table.c b/translation-table.c
> > index e0c5945..24e48e7 100644
> > --- a/translation-table.c
> > +++ b/translation-table.c
> > @@ -1683,3 +1683,33 @@ void tt_free(struct bat_priv *bat_priv)
> > 
> >  	kfree(bat_priv->tt_buff);
> >  
> >  }
> > 
> > +
> > +bool is_ap_isolated(struct bat_priv *bat_priv, uint8_t *src, uint8_t
> > *dst)
> 
> Doh!
> 
> O.K. The ordering could of been better... but the code at the end is
> O.K, which is what matters.

Aarrgh, same here. Let's see how many others fall into this trap.
How about reversing the order of these patches to avoid this "problem" ?

Regards,
Marek
