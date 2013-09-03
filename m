Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 3 Sep 2013 17:05:37 +0800
References: <1378103705-23183-1-git-send-email-lindner_marek@yahoo.de>
 <20130902064325.GE1871@ritirata.org>
In-Reply-To: <20130902064325.GE1871@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201309031705.37657.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: limit local translation
	table max size
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

On Monday, September 02, 2013 14:43:25 Antonio Quartulli wrote:
> On Mon, Sep 02, 2013 at 02:35:05PM +0800, Marek Lindner wrote:
> > The local translation table size is limited by what can be
> > transferred from one node to another via a full table request.
> >
> > 
> >
> > The number of entries fitting into a full table request depend
> > on whether the fragmentation is enabled or not. Therefore this
> > patch introduces a max table size check and refuses to add
> > more local clients when that size is reached. Moreover, if the
> > max full table packet size changes (MTU change or fragmentation
> > is disabled) the local table is downsized instantaneously.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> for the TT bit:
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision fb8d7c7.

Regards,
Marek
