Return-Path: <madhuparnabhowmik10@gmail.com>
From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date: Sun, 16 Feb 2020 21:03:24 +0530
Subject: Re: [PATCH] net: batman-adv: Use built-in RCU list checking
Message-ID: <20200216153324.GA4542@madhuparna-HP-Notebook>
References: <20200216144718.2841-1-madhuparnabhowmik10@gmail.com>
 <3655191.udZcvKk8tv@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3655191.udZcvKk8tv@sven-edge>
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
Cc: madhuparnabhowmik10@gmail.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joel@joelfernandes.org, frextrite@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org

On Sun, Feb 16, 2020 at 04:22:51PM +0100, Sven Eckelmann wrote:
> On Sunday, 16 February 2020 15:47:18 CET madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > hlist_for_each_entry_rcu() has built-in RCU and lock checking.
> > 
> > Pass cond argument to hlist_for_each_entry_rcu() to silence
> > false lockdep warnings when CONFIG_PROVE_RCU_LIST is enabled
> > by default.
> > 
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > ---
> >  net/batman-adv/translation-table.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> Added with alignment and line length codingstyle fixes [1].
> 
> Can you tell us how you've identified these four hlist_for_each_entry_rcu?
>
Hi Sven,

Thank you for the fixes.
The other hlist_for_each_entry_rcu() are used under the protection of
rcu_read_lock(). We only need to pass the cond when
hlist_for_each_entry_rcu() is used under a
different lock (not under rcu_red_lock()) because according to the current scheme a lockdep splat
is generated when hlist_for_each_entry_rcu() is used outside of
rcu_read_lock() or the lockdep condition (the cond argument) evaluates
to false. So, we need to pass this cond when it is used under the
protection of spinlock or mutex etc. and not required if rcu_read_lock()
is used.

Thank you,
Madhuparna
> Thanks,
> 	Sven
> 
> [1] https://git.open-mesh.org/linux-merge.git/commit/967709ec53a07d1bccbc3716f7e979d3103bd7c5


