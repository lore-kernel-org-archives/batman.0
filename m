Return-Path: <apw@shadowen.org>
Date: Fri, 17 Sep 2010 15:48:11 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-ID: <20100917144811.GA3805@shadowen.org>
References: <20100916235908.51ab3bfc@rechenknecht>
	<201009170027.16080.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201009170027.16080.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv: unicast fragmentation enhancements
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Fri, Sep 17, 2010 at 12:27:13AM +0200, Sven Eckelmann wrote:
> Andreas Langer wrote:
> > Sven, any idea why checkpatch (0.31)b do this ?
> > 
> > ERROR: space prohibited after that '-' (ctx:WxW)
> > #10: FILE: batman-adv/routing.c:1146:
> > +	    uni_diff = sizeof(struct unicast_frag_packet) - hdr_len;
> 
> Because... what the heck? Usually it says that you should use consistent 
> spaces around '-'. So better use spaces in patch 1 and 6 and don't remove the 
> space before hdr_len as you did now.

Because it is wrong.  I believe that I've fixed that one up in my
development tree.  Could you confirm it is correctly left alone with the
version below:

  http://www.kernel.org/pub/linux/kernel/people/apw/checkpatch/checkpatch.pl-testing

> My version from linux-next (today) is 0.30 and doesn't have a problem with 
> spaces around those '-' (but with your version of the patches). The 
> checkpatch.pl-testing also don't have the problem.
> 
> I would guess that it was a regression in checkpatch.pl. Maybe Andy Whitcroft 
> knows more about it

-apw
