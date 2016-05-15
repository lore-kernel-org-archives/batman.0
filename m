Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 15 May 2016 14:37:33 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160515123733.GH4375@otheros>
References: <20160514145129.GD4375@otheros> <2911091.OSPWlnrdxm@sven-edge>
 <20160515120626.GG4375@otheros> <22866212.dooYpi8Uhz@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22866212.dooYpi8Uhz@sven-edge>
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
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

On Sun, May 15, 2016 at 02:15:01PM +0200, Sven Eckelmann wrote:
> On Sunday 15 May 2016 14:06:26 Linus Lüssing wrote:
> [...]
> > [0]
> > https://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/linus/kmem-cac
> > he
> 
> This patchset has a bad bug. It still uses kfree for tt_local objects 
> allocated via kmem_cache_(z)alloc.

Where?
