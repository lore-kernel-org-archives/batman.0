Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1591888.FGtWPsc1tq@sven-edge>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <1780732.fBLghQceHc@bentobox>
 <CAF=yD-JTfT-iOBG6KMhXv=KggoZ4tEP1fiJMiHMA_d0-wYncLQ@mail.gmail.com>
 <1591888.FGtWPsc1tq@sven-edge>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 15 Dec 2017 12:23:04 -0500
Message-ID: <CAF=yD-++aNL_0WB8VqHo3cLGzp692L-L_HrvPAzR2EMYFuTBpA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
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
Cc: b.a.t.m.a.n@lists.open-mesh.org, Eric Dumazet <edumazet@google.com>, Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Pirko <jiri@mellanox.com>, "David S . Miller" <davem@davemloft.net>

On Fri, Dec 15, 2017 at 12:18 PM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> On Freitag, 15. Dezember 2017 11:57:55 CET Willem de Bruijn wrote:
>> > No, this is also bad because batman_adv.h is MIT license and packet.h is
>> > GPL-2. So what other name would you suggest for packet.h? batman_adv_packet.h?
>>
>> Sure, that sounds great. Thanks.
>
> Really? Isn't include/uapi/linux/batman_adv_packet.h looking like an accident
> which never should have had happened?

My only point was that renaming and modifying existing uapi files
can break userspace compilation.

As long as the existing files are not changed, I don't have a strong
opinion on naming for new files.
