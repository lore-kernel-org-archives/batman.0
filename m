Return-Path: <linus.luessing@c0d3.blue>
Date: Mon, 13 Feb 2017 20:21:08 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20170213192108.GJ29718@otheros>
References: <20170212102634.6279-1-sven@narfation.org>
 <20170212102634.6279-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170212102634.6279-2-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Keep fragments equally
 sized
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

On Sun, Feb 12, 2017 at 11:26:34AM +0100, Sven Eckelmann wrote:
> The batman-adv fragmentation packets have the design problem that they
> cannot be refragmented. This often leads to problems when networks are
> incorrectly configured and don't use a common MTU.
> 
> The sender could for example fragment a 1500 byte packet to fit in a 1280
> bytes large MTU. This would create a 1280 large packet and a 284 bytes
> large packet. But the next hop is then not able to transport 1280 bytes to
> its next hop. The 1280 byte large packet will be dropped but the 284 bytes
> large packet will still be forwarded to its destination.
> 
> This can partly being avoided by splitting packets more equally. In this
> example, the two 782 bytes large packets could both potentially reach its
> destination.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch is meant to enter master together with
> https://patchwork.open-mesh.org/patch/16933/
> 
>  net/batman-adv/fragmentation.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Acked-by: Linus Lüssing <linus.luessing@c0d3.blue>
