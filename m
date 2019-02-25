Return-Path: <klukonin@gmail.com>
MIME-Version: 1.0
References: <20190224165113.15726-1-sven@narfation.org>
 <037B7BA7-8D64-4B46-BDA8-C4D45AC9E61A@altermundi.net>
 <2667717.mmYbNj13ue@bentobox>
In-Reply-To: <2667717.mmYbNj13ue@bentobox>
From: =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>
Date: Mon, 25 Feb 2019 13:03:52 +0500
Message-ID: <CALYz8yqCAkcrvjcBhgf-2YYTrejhEXnnbRWP3bCtv-joXfP3jA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [RFC openwrt-routing] batman-adv: Split batadv
 proto in meshif and hardif part
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
Cc: Gui Iribarren <gui@altermundi.net>, openwrt-devel@lists.openwrt.org

Hello.


That looks pretty cool.
But what about ELP interval parameter?
As I think, it should be covered by UCI config too.


Best Regards,
Lukonin Kirill

=D0=BF=D0=BD, 25 =D1=84=D0=B5=D0=B2=D1=80. 2019 =D0=B3. =D0=B2 12:36, Sven =
Eckelmann <sven@narfation.org>:
>
> On Monday, 25 February 2019 02:24:56 CET Gui Iribarren wrote:
> > have you considered, to simplify backwards compatibility, to keep proto
> > "batadv" as it currently is (hardif) and naming "batadv_mesh" the new p=
roto?
>
> It was one of the goals to *not* name the batadv hardif interface proto
> "batadv". And I wanted to have the batman-adv interface proto named "bata=
dv"
> because this is the rtnl kind string. So you actually create batman-adv
> meshifs using:
>
>    ip link add dev bat0 type batadv
>
> But we can call this proto also "batadv_meshif" if there is a strong
> preference for this name.
>
> Kind regards,
>         Sven
