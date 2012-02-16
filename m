Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Feb 2012 14:35:34 +0800
References: <1328830902-11574-1-git-send-email-ordex@autistici.org>
	<201202102232.01329.lindner_marek@yahoo.de>
	<20120215194707.GB29190@ritirata.org>
In-Reply-To: <20120215194707.GB29190@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201202161435.34586.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 7/9] batman-adv: Distributed ARP Table
	- add compile option
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

On Thursday, February 16, 2012 03:47:08 Antonio Quartulli wrote:
> On Fri, Feb 10, 2012 at 10:32:00PM +0800, Marek Lindner wrote:
> > On Friday, February 10, 2012 07:41:40 Antonio Quartulli wrote:
> > > @@ -23,6 +23,8 @@
> > >
> > >  export CONFIG_BATMAN_ADV_DEBUG=n
> > >  # B.A.T.M.A.N. bridge loop avoidance:
> > >  export CONFIG_BATMAN_ADV_BLA=y
> > >
> > > +# B.A.T.M.A.N. distributed ARP table:
> > > +export CONFIG_BATMAN_ADV_DAT=n
> >
> > 
> >
> > Any particular reason why you wish to disable it by default ?
> 
> It's a new (read experimental) feature. I don't want people that just
> upgrade their batman-adv package to get this new code without having been
> asked :-)
> 
> This is the only reason for being off by default. But if you think we
> should push people to test it....then ok :) I can switch it to true!

It is a feature most people will benefit from. Of course it has to work! :)
IMHO the compile time option is for those that want a "slim" batman-adv.

Regards,
Marek
