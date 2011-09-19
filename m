Return-Path: <ordex@autistici.org>
Date: Tue, 20 Sep 2011 00:41:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110919224146.GA3410@ritirata.org>
References: <CAOaDhSTS8L33RuZDdJbc2AHw-TCBVTTeV1UbvpOMAtobPN6WfQ@mail.gmail.com>
	<2420094.p5eCaRlTMC@sven-desktop.home.narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2420094.p5eCaRlTMC@sven-desktop.home.narfation.org>
Subject: Re: [B.A.T.M.A.N.] drop dhcp batman-adv
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

On Mon, Sep 19, 2011 at 08:19:24PM +0200, Sven Eckelmann wrote:
> On Monday 19 September 2011 20:12:49 Gioacchino Mazzurco wrote:
> > I am looking for a way to drop dhcp packets forwarding with batman-adv
> > there is some way to do that ?
> 
> This doesn't look like a task for batman-adv, but for ebtables/iptables.

I think iptables can do that. You can simply add a specific rule in the FORWARD
chain.

Cheers,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
