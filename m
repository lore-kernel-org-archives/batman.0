Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 20 Aug 2013 16:13:04 +0800
References: <1376595170-506-1-git-send-email-ordex@autistici.org>
 <20130819202028.GB18020@pandem0nium> <20130820063906.GA2963@ritirata.org>
In-Reply-To: <20130820063906.GA2963@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201308201613.04678.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: check if a softif_vlan
	already exists
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Tuesday, August 20, 2013 14:39:06 Antonio Quartulli wrote:
> > Tested-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
> >
> > 
> >
> > Just one thing ...
> >
> > 
> >
> > On Thu, Aug 15, 2013 at 11:05:55PM +0200, Antonio Quartulli wrote:
> > > From: Antonio Quartulli <antonio@open-mesh.com>
> > >
> > > 
> > >
> > > Before creating a new softif_vlan it is better to check if
> > > that does already exist.
> > > If so batman-adv should refuse to create a new structure
> > > otherwise this would lead to an inconsistent state.
> > >
> > > 
> > >
> > > Normally this is not a problem because the operating system
> > > will prevent from creating the same vlan twice, but some
> > > ancient kernels exhibited an improper behaviour that led to
> > > a bug.
> >
> > 
> >
> > You might want to skip that when sending upstream? They might not
> > care about older kernels. Duno. :)
> 
> This patch is only for us, because it is going to be squashed with a
> previous one before going to David. So I'd leave the commit message as it
> is.

Applied in revision 00f2151.

Thanks,
Marek
