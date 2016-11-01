Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 1 Nov 2016 01:53:46 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161101005346.GD3264@otheros>
References: <1637163.TC9CcXIrIP@sven-edge>
 <20161031073629.31819-4-sven@narfation.org>
 <20161101004619.GC3264@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161101004619.GC3264@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/6] batman-adv: Revert "compat: Move
 netlink const compat to coccinelle"
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

On Tue, Nov 01, 2016 at 01:46:19AM +0100, Linus Lüssing wrote:
> 684d4cad930d97902 ("batman-adv: Remove replacement compat script")
> needs to be reverted first before this patch applies cleanly,
> doesn't it?

Ah, sorry, no, just noticed you rebased it on master +
"batman-adv: Install module in $INSTALL_MOD_DIR/updates/net/batman-adv".

Cherry-picking that commit onto master first helped.
