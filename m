Return-Path: <linus.luessing@c0d3.blue>
Date: Tue, 20 Dec 2016 12:55:50 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20161220115550.GN6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161219105027.GL6323@otheros> <3103100.ET4KBLGWzf@sven-edge>
 <3954768.uotHLiEBeb@sven-edge>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3954768.uotHLiEBeb@sven-edge>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
 independent TVLV handler API
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

On Mon, Dec 19, 2016 at 12:43:49PM +0100, Sven Eckelmann wrote:
> On Montag, 19. Dezember 2016 12:37:43 CET Sven Eckelmann wrote:
> > I was not talking about the packing functions.
> 
> Just read my initial mails. Looks like I've copied the wrong function name 
> "batadv_tvlv_ogm_pack_ctx". But I was talking about the parameter in of 
> "batadv_tvlv_containers_process2". So I am the reason for the confusion :)

Just to check, you suggest removing this line:
https://git.open-mesh.org/batman-adv.git/blob/1ddd189528fc332bf286ffd56b629da26a6b149c:/net/batman-adv/tvlv.c#l662

And to replace the passing of "ctx" with an "orig_node" here:
https://git.open-mesh.org/batman-adv.git/blob/1ddd189528fc332bf286ffd56b629da26a6b149c:/net/batman-adv/tvlv.c#l682

(which works as a "void *" parameter accepts any type, without the
need of casting explicitly)


If that's what you mean, hm, not sure. Feels dangerous, such
automatic casting, doesn't it?

I'm really wondering whether I should go for the approach of
hiding the "void *" in a new type. And only having the "void *"
fiddeling inside _pack()/_unpack() functions.
