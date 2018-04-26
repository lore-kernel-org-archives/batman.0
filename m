Return-Path: <luc.vanoostenryck@gmail.com>
Date: Thu, 26 Apr 2018 22:05:11 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Message-ID: <20180426200511.j45uth6y5y6ncsj6@ltop.local>
References: <20180424131847.5469-1-luc.vanoostenryck@gmail.com>
 <2141097.l2ETxyu3Mo@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2141097.l2ETxyu3Mo@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix batadv_interface_tx()'s
 return type
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Marek Lindner <mareklindner@neomailbox.ch>, netdev@vger.kernel.org, Antonio Quartulli <a@unstable.cc>

On Wed, Apr 25, 2018 at 07:35:00PM +0200, Sven Eckelmann wrote:
> On Dienstag, 24. April 2018 15:18:46 CEST Luc Van Oostenryck wrote:
> > The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> > which is a typedef for an enum type, but the implementation in this
> > driver returns an 'int'.
> > 
> > Fix this by returning 'netdev_tx_t' in this driver too.
> > 
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> > ---
> >  net/batman-adv/soft-interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Applied as 6bf9e4d39a58 [1] but the alignment was fixed

Thanks for this,
-- Luc 
