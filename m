Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 7 Oct 2012 00:43:34 +0800
References: <1349282136-23059-1-git-send-email-ordex@autistici.org>
 <201210040106.55685.lindner_marek@yahoo.de>
 <20121003211800.GH10663@ritirata.org>
In-Reply-To: <20121003211800.GH10663@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201210070043.34560.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: export compatibility version
	via debugfs
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

On Thursday, October 04, 2012 05:18:00 Antonio Quartulli wrote:
> On Thu, Oct 04, 2012 at 01:06:55AM +0800, Marek Lindner wrote:
> > On Thursday, October 04, 2012 00:35:36 Antonio Quartulli wrote:
> > > @@ -355,6 +366,13 @@ void batadv_debugfs_init(void)
> > > 
> > >         if (!file)
> > >         
> > >                 pr_err("Can't add debugfs file: %s\n",
> > > 
> > > bat_debug->attr.name);
> > > +       bat_debug = &batadv_debuginfo_compat_version;
> > > +       file = debugfs_create_file(bat_debug->attr.name,
> > > +                                  S_IFREG | bat_debug->attr.mode,
> > > +                                  batadv_debugfs, NULL,
> > > &bat_debug->fops); +       if (!file)
> > > +               pr_err("Can't add debugfs file: %s\n",
> > > bat_debug->attr.name); +
> > > 
> > >  out:
> > >         return;
> > >  
> > >  }
> > 
> > If we start to create more files here you should add a a loop like in
> > batadv_debugfs_add_meshif() to avoid duplicate code.
> 
> do you think we should do that for two files already?
> I do not think there will be so much to add in this debugfs folder. Maybe
> we can add a loop as soon as add the next one, but for two I think we can
> still leave with this implementation.

Well, when I added the 'routing_algos' file I also thought nobody else would 
want to add something there ... 

Cheers,
Marek

