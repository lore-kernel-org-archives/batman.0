Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 27 Jan 2013 08:34:42 +0800
References: <20130124151221.GA8211@ritirata.org>
 <a6ad84c212e89c411dab6b40ac613a61c8b9621c.1359047612.git.mschiffer@universe-factory.net>
 <20130125132707.GB8211@ritirata.org>
In-Reply-To: <20130125132707.GB8211@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201301270834.42637.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/2] batman-adv: check for more types
	of invalid IP addresses in DAT
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

On Friday, January 25, 2013 21:27:07 Antonio Quartulli wrote:
>   On Thu, Jan 24, 2013 at 06:18:26PM +0100, Matthias Schiffer wrote:
> > There are more types of IP addresses that may appear in ARP packets that
> > we don't want to process. While some of these should never appear in
> > sane ARP packets, a 0.0.0.0 source is used for duplicate address
> > detection and thus seen quite often.
> >
> > Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 3b24193.

Thanks,
Marek
