Return-Path: <ordex@autistici.org>
Date: Wed, 1 Jun 2011 08:19:59 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110601061949.GA25850@ritirata.org>
References: <1306763217-27752-1-git-send-email-lindner_marek@yahoo.de>
	<1306780839-9375-1-git-send-email-ordex@autistici.org>
	<20110601053425.GA27695@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110601053425.GA27695@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: modify
 TT_RESPONSE-full-table format
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

On mer, giu 01, 2011 at 07:34:25 +0200, Andrew Lunn wrote:
> > +	ssize_t tt_query_size = sizeof(struct tt_query_packet);
> > +	int i;
> > +
> > +	if (sizeof(struct tt_query_packet) + tt_len >
> > +						primary_if->soft_iface->mtu) {
> > +		tt_len = primary_if->soft_iface->mtu - tt_query_size;
> > +		tt_len -= tt_len % sizeof(struct tt_change);
> > +	}
> 
> Hi Antonio
> 
> This first struck me as being asymmetric. Then i say that
> tt_query_size is sizeof(struct tt_query_packet). So use it in the if
> statement, and then symmetry is restored and probably the indentation
> looks better.

Oh, thanks Andrew! I'm going to fix it

> 
>       Andrew

-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
