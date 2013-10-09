Return-Path: <bittorf@bluebottle.com>
Date: Wed, 9 Oct 2013 12:35:15 +0200
From: Bastian Bittorf <bittorf@bluebottle.com>
Message-ID: <20131009103515.GI8785@medion.lan>
References: <1380834133-10808-1-git-send-email-siwu@hrz.tu-chemnitz.de>
 <12447770.xO0R1XlQHM@diderot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12447770.xO0R1XlQHM@diderot>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix compat of
 net_ratelimited_function for >3.2.46
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Simon Wunderlich <simon@open-mesh.com>

* Marek Lindner <mareklindner@neomailbox.ch> [09.10.2013 12:28]:
> > Appearently net_ratelimited_function was added to the stable series of
> > from 3.2.47, which results in a lot of warnings when compiling against
> > this kernel. This patch avoids this redefinition.
> > 
> > Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> > ---
> >  compat.h |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> Applied in revision 227df84.

can this be backported to 'openwrt-routing' feed?

bye, bastian
