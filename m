Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 19 Feb 2014 19:18:26 +0100
References: <1392732804-23206-1-git-send-email-sw@simonwunderlich.de>
 <3768164.qYOYKYLPuX@diderot>
In-Reply-To: <3768164.qYOYKYLPuX@diderot>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201402191918.26582.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: add option for multiif orig table
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

> On Tuesday 18 February 2014 15:13:24 Simon Wunderlich wrote:
> > @@ -162,7 +175,10 @@ int handle_debug_table(char *mesh_iface, int
> > debug_table, int argc, char **argv) return EXIT_FAILURE;
> > 
> >         }
> > 
> > -       debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface,
> > full_path, sizeof(full_path)); +       if (orig_iface)
> > +               debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", orig_iface,
> > full_path, sizeof(full_path)); +       else
> > +               debugfs_make_path(DEBUG_BATIF_PATH_FMT "/", mesh_iface,
> > full_path, sizeof(full_path)); return read_file(full_path, (char
> > *)batctl_debug_tables[debug_table].debugfs_name, read_opt, orig_timeout,
> > watch_interval,
> > 
> >                          batctl_debug_tables[debug_table].header_lines);
> 
> While playing with your patch I noticed a couple of things:
> 
>  * 'batctl originators -i eth0' is equivalent to 'batctl -m eth0
> originators'
> * the latter works even without your patch

Both is true, because the originators file is at the same position 
(eth0/originators instead of bat0/originators).

>  * the orig table output does not say which interface we are looking at but
> always reports: (bat0 BATMAN_IV)

Yes, check the whole first line:
bat0/originators: [B.A.T.M.A.N. adv master-b82b9b2, MainIF/MAC: 
eth0/fe:f0:00:00:02:01 (bat0 BATMAN_IV)]
eth0/originators: [B.A.T.M.A.N. adv master-b82b9b2, IF/MAC: 
eth0/fe:f0:00:00:02:01 (bat0 BATMAN_IV)]
eth1/originators: [B.A.T.M.A.N. adv master-b82b9b2, IF/MAC: 
eth1/fe:f1:00:00:02:01 (bat0 BATMAN_IV)]

>  * /sys/kernel/debug/batman_adv/ contains all sorts of hard-interfaces on
> my test setup even if they are not used by batman-adv - is the intended ?

Yes. Like the for the sysfs, a folder is created for every interface even if 
not used - creating/removing on the fly would bring us a lot of locking fun 
which I wanted to avoid (I think we have discussed that when the batman-adv 
patches came in).

Cheers,
    Simon
