Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 10 May 2013 11:37:55 +0800
References: <1368109009-2100-1-git-send-email-ordex@autistici.org>
 <201305100007.08742.lindner_marek@yahoo.de>
 <20130509164426.GF1415@ritirata.org>
In-Reply-To: <20130509164426.GF1415@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305101137.55418.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix VLAN Ethernet
	header access
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

On Friday, May 10, 2013 00:44:26 Antonio Quartulli wrote:
>   On Fri, May 10, 2013 at 12:07:08AM +0800, Marek Lindner wrote:
> > On Thursday, May 09, 2013 22:16:49 Antonio Quartulli wrote:
> > > From: Antonio Quartulli <antonio@open-mesh.com>
> > >
> > > 
> > >
> > > In interface_rx() skb->data cannot be directly used to
> > > access the Ethernet header because it point to the batman
> > > one.
> >
> > 
> >
> > You don't believe that these calls (shortly before the code chunks you
> > are  changing) are helpful ?
> >
> > 
> >
> > skb_pull_rcsum(skb, hdr_size);
> > skb_reset_mac_header(skb);
> 
> You are right. Hence this is not fixing anything. It is just a
> beautification and therefore we don't need it in maint.

Are you going to resend the patch with an updated commit message and subject 
line ?

Cheers,
Marek
