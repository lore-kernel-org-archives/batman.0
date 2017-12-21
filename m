Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171221122436.GD1930@nanopsycho>
References: <20171221091742.8020-1-sven.eckelmann@openmesh.com>
 <20171221091742.8020-6-sven.eckelmann@openmesh.com>
 <20171221122436.GD1930@nanopsycho>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 21 Dec 2017 11:58:44 -0500
Message-ID: <CAF=yD-Kcdh2q6JJ9kVC8=mbkwaxE0VVrs+DD187j5NzOsayiAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: Sven Eckelmann <sven.eckelmann@openmesh.com>, b.a.t.m.a.n@lists.open-mesh.org, Network Development <netdev@vger.kernel.org>, Tom Herbert <tom@herbertland.com>, Jiri Pirko <jiri@mellanox.com>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>

On Thu, Dec 21, 2017 at 7:24 AM, Jiri Pirko <jiri@resnulli.us> wrote:
> Thu, Dec 21, 2017 at 10:17:42AM CET, sven.eckelmann@openmesh.com wrote:
>>The batman-adv unicast packets contain a full layer 2 frame in encapsulated
>>form. The flow dissector must therefore be able to parse the batman-adv
>>unicast header to reach the layer 2+3 information.
>>
>>  +--------------------+
>>  | ip(v6)hdr          |
>>  +--------------------+
>>  | inner ethhdr       |
>>  +--------------------+
>>  | batadv unicast hdr |
>>  +--------------------+
>>  | outer ethhdr       |
>>  +--------------------+
>>
>>The obtained information from the upper layer can then be used by RPS to
>>schedule the processing on separate cores. This allows better distribution
>>of multiple flows from the same neighbor to different cores.
>>
>>Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
>
> Reviewed-by: Jiri Pirko <jiri@mellanox.com>

Acked-by: Willem de Bruijn <willemb@google.com>
