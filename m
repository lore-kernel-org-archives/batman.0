Return-Path: <joe@perches.com>
Message-ID: <1497432736.18751.39.camel@perches.com>
From: Joe Perches <joe@perches.com>
Date: Wed, 14 Jun 2017 02:32:16 -0700
In-Reply-To: <5300874.nPgxNW8UST@bentobox>
References: <1497390701.18751.26.camel@perches.com>
 <5300874.nPgxNW8UST@bentobox>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Odd use of %14pM in
 net/batman-adv/distributed-arp-table.c
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org

On Wed, 2017-06-14 at 10:23 +0200, Sven Eckelmann wrote:
> On Dienstag, 13. Juni 2017 14:51:41 CEST Joe Perches wrote:
> > An output mac address is 17 bytes
> 
> [...]
> > but in net/batman-adv/distributed-arp-table.c
> 
> [...]
> > %14pM is odd as this should not emit the last byte of the
> > mac address.  So given the example above, it would output
> > 00:11:22:33:44
> 
> [...]
> 
> I completely agree too the "wrong length" part. It is currently not omitting 
> the last byte:

Right, I only looked at vsprintf.c and mistook precision for
field_width.

Do you want to provide a patch to convert it to simple %pM's?

OK.
