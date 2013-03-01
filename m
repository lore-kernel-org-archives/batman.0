Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 1 Mar 2013 10:15:01 +0800
References: <1362049727-16411-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <20130228111330.GC4530@ritirata.org>
In-Reply-To: <20130228111330.GC4530@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201303011015.01793.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: change compat code to remove
	sparse warning
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
Cc: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

On Thursday, February 28, 2013 19:13:30 Antonio Quartulli wrote:
> On Thu, Feb 28, 2013 at 12:08:47 +0100, Simon Wunderlich wrote:
> > The latest compat patch fixing rtnl ops compile errors from 2.6.32
> > ("batman-adv: add compat support for the new netlink ops") fixes
> > the compilation, but leaves some sparse errors:
> > batman-adv/soft-interface.c:573:10: warning: Initializer entry defined
> > twice batman-adv/soft-interface.c:574:10: also defined here
> >
> > This patch uses another approach by moving the initializers in a dummy
> > struct instead. This also removes the sparse errors.
> >
> > Signed-off-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 2caa9e1.

Thanks,
Marek
