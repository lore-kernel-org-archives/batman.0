Return-Path: <jiri@resnulli.us>
Date: Thu, 21 Dec 2017 13:24:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
Message-ID: <20171221122436.GD1930@nanopsycho>
References: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
 <20171221091742.8020-6-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171221091742.8020-6-sven.eckelmann@openmesh.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 5/5] flow_dissector: Parse batman-adv
 unicast headers
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Tom Herbert <tom@herbertland.com>, Jiri Pirko <jiri@mellanox.com>, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>

Thu, Dec 21, 2017 at 10:17:42AM CET, sven.eckelmann@openmesh.com wrote:
>The batman-adv unicast packets contain a full layer 2 frame in encapsulated
>form. The flow dissector must therefore be able to parse the batman-adv
>unicast header to reach the layer 2+3 information.
>
>  +--------------------+
>  | ip(v6)hdr          |
>  +--------------------+
>  | inner ethhdr       |
>  +--------------------+
>  | batadv unicast hdr |
>  +--------------------+
>  | outer ethhdr       |
>  +--------------------+
>
>The obtained information from the upper layer can then be used by RPS to
>schedule the processing on separate cores. This allows better distribution
>of multiple flows from the same neighbor to different cores.
>
>Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>

Reviewed-by: Jiri Pirko <jiri@mellanox.com>
