Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 24 Jan 2013 21:31:18 +0800
References: <c15e0026ed81d2da11ee59ab7bfcb3a6271cd10b.1358961079.git.mschiffer@universe-factory.net>
 <20130123211137.GB10344@ritirata.org> <20130123211403.GC10344@ritirata.org>
In-Reply-To: <20130123211403.GC10344@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301242131.18392.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: fix skb leak in
	batadv_dat_snoop_incoming_arp_reply()
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

On Thursday, January 24, 2013 05:14:03 Antonio Quartulli wrote:
> On Thu, Jan 24, 2013 at 05:11:37AM +0800, Antonio Quartulli wrote:
> > Hi Matthias,
> > 
> > very good catch!
> > 
> > On Wed, Jan 23, 2013 at 06:11:53PM +0100, Matthias Schiffer wrote:
> > > The callers of batadv_dat_snoop_incoming_arp_reply() assume the skb has
> > > been freed when it returns true; fix this by calling kfree_skb before
> > > returning as it is done in batadv_dat_snoop_incoming_arp_request().
> > > 
> > > Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> > 
> > Acked-by: Antonio Quartulli <ordex@autistici.org>
> 
> I forgot to say that this fix should be merged into maint, so that we can
> send it to net.

Applied in revision 977d8c6.

Thanks,
Marek
