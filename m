Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 17 May 2015 02:40:26 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20150517004026.GB2411@odroid>
References: <1430940562-12148-1-git-send-email-linus.luessing@c0d3.blue>
 <1430940562-12148-4-git-send-email-linus.luessing@c0d3.blue>
 <1572715.c14tfryD1Z@bentobox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1572715.c14tfryD1Z@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 3/3] compat: Compat code for IGMP/MLD
 report unicast forwarding
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

On Thu, May 07, 2015 at 09:33:17AM +0200, Sven Eckelmann wrote:
> The split header files were only there to fix the problem of the header mess 
> which couldn't be resolved with a single compat.h that forced a specific 
> include order. It is not really necessary to have the same for the source 
> files. Maybe your solution is good or maybe not. Only the future will tell. :)
> 
> The other solution would be more like backports [1]. They seem to use one 
> backport-/compat-*.c file for each kernel they support and introduced features 
> which they require. So all kernel < 3.19 will build the content of 
> backport-3.19.c to get the functions introduced by this version. But there are 
> also some larger ones for special stuff. Maybe you can check this out and 
> decide what you like more.

For the backport compat code I'm always getting confused with the
kernel versions. But maybe that's more because their latest
downloads, for instance the one with 4.0 in its name, is actually
not just for 4.0 but older kernels, too (unless I'm again mixing
things up...). With our current implementation I like it quite a
lot that while reading it's always clear which code is being used
thanks to the explicit #if's and #endifs. And by keeping the
upstream folder structure, it's immediately clear where code came
from, too (though that could be figured out via git-grep as well,
of course).

> 
> To the copyright stuff... hm, if you didn't write it yourself then the 
> copyright stuff from the original source should be there. backports [1] 
> doesn't seem to do this very well. They have for example used larger portions 
> from files marked as copyright Yu Zhao <yu.zhao@intel.com> but have only the 
> copyright header with Copyright (c) 2013  Luis R. Rodriguez <mcgrof@do-not-
> panic.com>. Not sure that I can give a good answer here. Maybe someone else 
> has an opinion about this part

Had some small discussions with Simon today, too. I now simply copied the
copyright headers from the upstream files. Even though I know that
ip_mc_check_igmp() in igmp.c was not written by Alan Cox (more by
Herbert Xu with refactoring by me). Or the copied skbuff.c stuff
wasn't written by Alan Cox/Florian La Roche either (where some
stuff was written by me and some was moved from br_multicast.c
where I don't know who actually wrote that - would need to do
deeper git-blame analysis...).

But I guess if people didn't claim copyright for things in the
header of the C file, then I'd assume they are okay with what we
do. Otherwise they would need to complain in the upstream kernel
too or everyone else would need to do hours of git history digging
and analysis to find out where input might have come from.

As always, thanks for your valuable feedback!

Cheers, Linus
