Return-Path: <andrew@lunn.ch>
Date: Sun, 13 Mar 2016 16:24:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20160313152423.GA9674@lunn.ch>
References: <1456867148-31883-1-git-send-email-andrew@lunn.ch>
 <1456867148-31883-2-git-send-email-andrew@lunn.ch>
 <5081672.FTLI5Uv8oX@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5081672.FTLI5Uv8oX@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/4] batman-adv: NETIF_F_NETNS_LOCAL
 feature to prevent netns moves
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>

On Sun, Mar 13, 2016 at 10:29:21AM +0100, Sven Eckelmann wrote:
> On Tuesday 01 March 2016 22:19:05 Andrew Lunn wrote:
> > The batX soft interface should not be moved between network name
> > spaces. This is similar to bridges, bonds, tunnels, which are not
> > allowed to move between network namespaces.
> > 
> > Suggested-by: Daniel Ehlers <danielehlers@mindeye.net>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Antonio Quartulli <a@unstable.cc>
> > ---
> >  net/batman-adv/soft-interface.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>
> 
> Andrew, would it be ok for you to apply this patch first while the last 
> two/three patches are still discussed?

Sure, no problem. Please take it.

      Andrew
