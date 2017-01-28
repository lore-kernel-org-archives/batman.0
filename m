Return-Path: <linus.luessing@c0d3.blue>
Date: Sat, 28 Jan 2017 22:22:49 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170128212249.GA3311@otheros>
References: <20170128092526.9219-1-sven@narfation.org>
 <20170128092526.9219-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170128092526.9219-2-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Fix includes for
 IS_ERR/ERR_PTR
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

On Sat, Jan 28, 2017 at 10:25:26AM +0100, Sven Eckelmann wrote:
> IS_ERR/ERR_PTR are not defined in linux/device.h but in linux/err.h. The
> files using these macros therefore have to include the correct one.
> 
> Reported-by: Linus Luessing <linus.luessing@web.de>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Hm, my @web.de mail address is deprecated (read-only, don't ask me
why :D).

Would be nice if it could be updated upon committing. (but if
someone forgets not a big problem either, as it's documented in
.mailmap)
