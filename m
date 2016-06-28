Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 28 Jun 2016 17:40:34 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160628154034.GG3221@otheros>
References: <1466865846-32621-1-git-send-email-sven@narfation.org>
 <1666680.Y9BoZfK7nu@sven-edge> <20160627040218.GP4407@otheros>
 <8290095.7NSUu8plcS@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8290095.7NSUu8plcS@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: use kmem_cache for
 translation table
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

On Mon, Jun 27, 2016 at 08:09:58AM +0200, Sven Eckelmann wrote:
> On Monday 27 June 2016 06:02:18 Linus Lüssing wrote:
> [...]
> > Looks good. Do you have any typical numbers regarding tt_change_cache
> > and tt_req_cache sizes for specific setups?
> 
> No, I don't have any numbers.

Freifunk Rhein-Neckar at about 4pm (~700 nodes, ~1800 clients, batman-adv compat15):

-----
batadv_tt_roam_cache      0      0     64   63    1 : tunables  120   60    8 : slabdata      0      0      0
batadv_tt_req_cache      1     63     64   63    1 : tunables  120   60    8 : slabdata      1      1      0
batadv_tt_change_cache      0      0     32  124    1 : tunables  120   60    8 : slabdata      0      0      0
batadv_tt_orig_cache   3210   3213     64   63    1 : tunables  120   60    8 : slabdata     51     51      0
batadv_tg_cache     3162   3162    128   31    1 : tunables  120   60    8 : slabdata    102    102      0
batadv_tl_cache        2     31    128   31    1 : tunables  120   60    8 : slabdata      1      1      0
-----

-> snapshot taken from an x86 machine connected to a Gluon ar71xx node.

So the roam, req, change and tl cache are mostly empty here. On the other hand, they could
probably gain a significant size once a larger LAN gets bridged to bat0, I guess.
Also looks like various file systems have about half a dozen caches each with most
of them being quite empty most of the time.

So, I guess it's ok to have the roam/req/change/tl caches.


Not sure whether I should (since TT is Antonio's part) but the patch looks
correct, the previous version with the same concept tested and looks very
similar to what I had incidentally been coding at the same time as Sven :), so:

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
