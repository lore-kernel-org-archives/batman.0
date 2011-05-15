Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 15 May 2011 18:27:02 +0200
References: <1305396082-30309-1-git-send-email-lindner_marek@yahoo.de>
	<201105142008.23630.sven@narfation.org>
In-Reply-To: <201105142008.23630.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105151827.03104.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: reset broadcast flood
	protection on error
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

On Saturday 14 May 2011 20:08:20 Sven Eckelmann wrote:
> >       primary_if = primary_if_get_selected(bat_priv);
> >       if (!primary_if)
> >
> > -             goto out;
> > +             goto out_and_inc;
> >
> > 
> >       forw_packet = kmalloc(sizeof(struct forw_packet), GFP_ATOMIC);
> 
> Acked-by: Sven Eckelmann <sven@narfation.org>

Applied in revision 49eb173.

Regards,
Marek
