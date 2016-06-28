Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 28 Jun 2016 04:14:41 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160628021441.GT4407@otheros>
References: <1467008142-3797-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1467008142-3797-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH v3] batman-adv: Remove orig_node
 reference handling from send_skb_unicast
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

On Mon, Jun 27, 2016 at 08:15:42AM +0200, Sven Eckelmann wrote:
> The function batadv_send_skb_unicast is not acquiring a reference for an
> orig_node nor removing it from any datastructure. It still reduces the
> reference counter for an object which is still in the hands of the caller.
> 
> This is confusing and can lead in the future to problems in the reference
> handling of the caller function.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v3:
>  - adjust commit message to sound less like an fix (thanks Linus)
>  - Remove " and release a reference to this orig_node" from kerneldoc of
>    batadv_send_skb_unicast (thanks Linus)
> v2:
>  - remove bogus multicast example
>  - remove Fixes:
> ---

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
