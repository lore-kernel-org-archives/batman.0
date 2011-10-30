Return-Path: <ordex@autistici.org>
Date: Sun, 30 Oct 2011 10:29:24 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111030092924.GA7395@ritirata.org>
References: <1319964962-5092-1-git-send-email-ordex@autistici.org>
	<1319964962-5092-6-git-send-email-ordex@autistici.org>
	<6028805.d7dOrXsFof@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6028805.d7dOrXsFof@sven-laptop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 5/6] batman-adv: Distributed ARP Table -
 add snooping functions for ARP messages
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Oct 30, 2011 at 10:18:42AM +0100, Sven Eckelmann wrote:
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> [...]
> > diff --git a/Makefile.kbuild b/Makefile.kbuild
> > index c8d6543..3076c22 100644
> > --- a/Makefile.kbuild
> > +++ b/Makefile.kbuild
> > @@ -25,7 +25,7 @@ ifeq ($(MAKING_MODULES),1)
> >  -include $(TOPDIR)/Rules.make
> >  endif
> > 
> > -# ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
> > +ccflags-y += -DCONFIG_BATMAN_ADV_DEBUG
> > 
> >  ifneq ($(REVISION),)
> >  ccflags-y += -DSOURCE_VERSION=\"$(REVISION)\"
> 
> Please remove that change.

Done. Thanks for highlighting it.




-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
