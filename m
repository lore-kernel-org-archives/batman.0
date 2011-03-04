Return-Path: <linus.luessing@web.de>
Date: Fri, 4 Mar 2011 22:18:44 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20110304211844.GA6473@Sellars>
References: <1299184756-26069-1-git-send-email-sven@narfation.org>
	<1299186519-27314-1-git-send-email-sven@narfation.org>
	<201103042155.12557.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201103042155.12557.lindner_marek@yahoo.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Disallow regular interface
 as mesh device
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

On Fri, Mar 04, 2011 at 09:55:12PM +0100, Marek Lindner wrote:
> On Thursday 03 March 2011 22:08:39 Sven Eckelmann wrote:
> > When trying to associate a net_device with another net_device which
> > already exists, batman-adv assumes that this interface is a fully
> > initialized batman mesh interface without checking it. The behaviour
> > when accessing data behind netdev_priv of a random net_device is
> > undefined and potentially dangerous.
> 
> Linus, can you confirm this patch fixes the problem for you ?
> 
> Thanks,
> Marek
> 
Yep, works as expected, thanks Sven!

"Can't create batman mesh interface interface %s:"
-> there's one 'interface' too much though

Cheers, Linus
