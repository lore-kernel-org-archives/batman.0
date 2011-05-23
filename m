Return-Path: <ordex@autistici.org>
Date: Mon, 23 May 2011 15:23:08 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110523132308.GA19939@ritirata.org>
References: <1303940106-1457-1-git-send-email-ordex@autistici.org>
	<1306013107-18515-2-git-send-email-ordex@autistici.org>
	<201105221301.03376.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201105221301.03376.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/3] batman-adv: improved client
 announcement mechanism
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

On Sun, May 22, 2011 at 01:01:02PM +0200, Sven Eckelmann wrote:
> Antonio Quartulli wrote:
> > - Cleaned following ecsv's patches/suggestions.
> > - recv_unicast_packet() now uses seq_before()
> 
> Antonio Quartulli wrote:
> > +           (diff < 0 && diff > -0xff/2)) {
> > +               /* Linearize the skb before accessing it */
> 
> What?
> 
> Sry, have to Nack this one.
> 

Thanks! Fixed


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
