Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 21 Nov 2013 14:22:44 +0100
References: <1384366492-27310-1-git-send-email-sw@simonwunderlich.de>
 <1384366492-27310-8-git-send-email-sw@simonwunderlich.de>
 <12732164.njm70c9A0l@diderot>
In-Reply-To: <12732164.njm70c9A0l@diderot>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201311211422.44620.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 7/8] batman-adv: add debugfs structure
	for information per interface
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

Hi Marek,

> On Wednesday 13 November 2013 19:14:51 Simon Wunderlich wrote:
> >  void batadv_debugfs_init(void)
> >  {
> >  
> >         struct batadv_debuginfo **bat_debug;
> > 
> > @@ -378,6 +395,11 @@ void batadv_debugfs_init(void)
> > 
> >         if (!batadv_debugfs)
> >         
> >                 goto err;
> > 
> > +       batadv_hardif_debugfs =
> > debugfs_create_dir(BATADV_DEBUGFS_HARDIF_SUBDIR,
> > +                                                  batadv_debugfs);
> > +       if (batadv_hardif_debugfs == ERR_PTR(-ENODEV))
> > +               goto err;
> > +
> > 
> >         for (bat_debug = batadv_general_debuginfos; *bat_debug;
> >         ++bat_debug)
> > 
> > { file = debugfs_create_file(((*bat_debug)->attr).name, S_IFREG |
> > ((*bat_debug)->attr).mode,
> 
> I see no specific reason to create a 'hardif' subdirectory. We developers
> may know what the term relates to but it is reasonable to assume our users
> do not. How about adding the interface directory (e.g. wlan0) right next
> to the batX directory ? 

thanks for the suggestion, I've done that in the reviewed patch v4 (there is 
also a v5 fixing another style issue antonio pointed out).

> For clarity we could also move the interface
> directory into the corresponding batX folder. In case multiple batX
> interfaces it might makes things more obvious.

That's a little harder to do as the folder creation is done when the interface 
is registered to batman-adv, just as for sysfs. Although not impossible, as 
discussed on IRC, I'd like to keep it at the proposal from above. This will 
also keep the folders in the same flat hierarchy as we have in /sys/class/net/* 
to manage batman devices. I think it's good to keep it at this consistent 
scheme.

Thanks,
    Simon
