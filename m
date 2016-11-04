Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 4 Nov 2016 04:42:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161104034207.GD4490@otheros>
References: <20161102171443.9491-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161102171443.9491-1-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: Revert "fix splat on
 disabling an interface"
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
Cc: julian@freifunk-rtk.de

On Wed, Nov 02, 2016 at 06:14:43PM +0100, Sven Eckelmann wrote:
> The commit bac7733d06fa ("batman-adv: fix splat on disabling an interface")
> fixed a warning but at the same time broke the rtnl function add_slave for
> devices which were temporarily removed.
> 
> batadv_softif_slave_add requires soft_iface of and hard_iface to be NULL
> before it is allowed to be enslaved. But this resetting of soft_iface to
> NULL in batadv_hardif_disable_interface was removed with the aforementioned
> commit.
> 
> Reported-by: Julian Labus <julian@freifunk-rtk.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Cc: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Like I said in the ticket, I can't reproduce the splat with
v2016.4 plus this revert right now.

Maybe changes to the hard-interface handling might have fixed it
properly in the mean time.

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
