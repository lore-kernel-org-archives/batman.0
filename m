Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jan 2013 08:38:28 +0800
References: <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
 <463977c0dcf7b3fcc6a2aebbb87add0d2377d3de.1359047612.git.mschiffer@universe-factory.net>
 <20130125132849.GC8211@ritirata.org>
In-Reply-To: <20130125132849.GC8211@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301270838.28986.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batman-adv: filter ARP packets
	with invalid MAC addresses in DAT
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

On Friday, January 25, 2013 21:28:49 Antonio Quartulli wrote:
> On Thu, Jan 24, 2013 at 06:18:27PM +0100, Matthias Schiffer wrote:
> > We never want multicast MAC addresses in the Distributed ARP Table, so
> > it's best to completely ignore ARP packets containing them where we
> > expect unicast addresses.
> >
> > Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision ab361a9.

Thanks,
Marek
