Return-Path: <linus.luessing@web.de>
Date: Sun, 10 Oct 2010 16:51:19 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20101010145119.GB1843@Sellars>
References: <1286685001-15227-1-git-send-email-linus.luessing@web.de>
	<1286685001-15227-3-git-send-email-linus.luessing@web.de>
	<201010101449.52124.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201010101449.52124.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/5] batman-adv: Make hop_penalty
 configurable via sysfs
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

On Sun, Oct 10, 2010 at 02:49:51PM +0200, Marek Lindner wrote:
> Any good reason for all these "originator interval" explanations here ?
> 
> 
> > @@ -592,6 +592,7 @@ struct net_device *softif_create(char *name)
> >  	atomic_set(&bat_priv->gw_mode, GW_MODE_OFF);
> >  	atomic_set(&bat_priv->gw_class, 0);
> >  	atomic_set(&bat_priv->orig_interval, 1000);
> > +	atomic_set(&bat_priv->hop_penalty, 30);
> 
> Either you initialize the value with TQ_HOP_PENALTY or you remove the define 
> from the main.h file.
Argh, ehm, thanks... thought I had removed the define and set the
hop_penalty to 10... but...

eh, nevermind, will redo that :)

Cheers, Linus
> 
> Regards,
> Marek
> 
