Return-Path: <madhuparnabhowmik10@gmail.com>
From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date: Sun, 16 Feb 2020 21:22:44 +0530
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Message-ID: <20200216155243.GB4542@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
 <3655191.udZcvKk8tv@sven-edge>
 <20200216153324.GA4542@madhuparna-HP-Notebook>
 <1634394.jP7ydfi60B@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634394.jP7ydfi60B@sven-edge>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org

On Sun, Feb 16, 2020 at 04:35:54PM +0100, Sven Eckelmann wrote:
> On Sunday, 16 February 2020 16:33:24 CET Madhuparna Bhowmik wrote:
> [...]
> > > Can you tell us how you've identified these four hlist_for_each_entry_rcu?
> >
> > The other hlist_for_each_entry_rcu() are used under the protection of
> > rcu_read_lock(). We only need to pass the cond when
> > hlist_for_each_entry_rcu() is used under a
> > different lock (not under rcu_red_lock()) because according to the current scheme a lockdep splat
> > is generated when hlist_for_each_entry_rcu() is used outside of
> > rcu_read_lock() or the lockdep condition (the cond argument) evaluates
> > to false. So, we need to pass this cond when it is used under the
> > protection of spinlock or mutex etc. and not required if rcu_read_lock()
> > is used.
> 
> I understand this part. I was asking how you've identified them. Did you use 
> any tool for that? coccinelle, sparse, ...
>
Hi,

Not really, I did it manually by inspecting each occurence.
Thank you,
Madhuparna

> Kind regards,
> 	Sven


