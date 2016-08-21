Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 21 Aug 2016 05:51:15 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160821035115.GC29805@otheros>
References: <20160821032534.11074-1-linus.luessing@c0d3.blue>
 <20160821032534.11074-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160821032534.11074-3-linus.luessing@c0d3.blue>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: fix batadv_forw_packet
 kerneldoc for list attribute
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Aug 21, 2016 at 05:25:34AM +0200, Linus Lüssing wrote:
> The forw_packet list node is wrongly attributed to the icmp socket code.
> 
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---

Fixes: 2191c1bcbc64 ("batman-adv: kernel doc for types.h")
