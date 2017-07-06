Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 6 Jul 2017 07:05:03 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170706050503.GA4511@otheros>
References: <20170623154826.7792-1-linus.luessing@c0d3.blue>
 <3606832.Ug1eaxX1Ot@lafayette> <20170701173456.GB13650@otheros>
 <20170703040801.GD27857@prodigo.unstable.cc>
 <20170705055939.GF3112@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170705055939.GF3112@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH maint] batman-adv: fix TT sync flag
 inconsistencies
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

On Wed, Jul 05, 2017 at 07:59:40AM +0200, Linus Lüssing wrote:
> If so, what would you prefer, should I replace the
> "common->flags |= flags" with something like a
> "common->flags |= flags & (~BATADV_TT_SYNC_MASK)"? Or would you
> prefer setting the TEMP flag somewhere else explicitly, similarly
> like we seemingly handle the ROAM flag explicitly, too?

Went with the former approach to keep the change less invasive.

Regards, Linus
