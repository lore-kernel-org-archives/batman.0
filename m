Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
 <4485194.d5W8GeZ6RB@sven-edge> <CAOVt3fE8-U73oJV2XjnxFzWc35LAMeXeaNsTUUgPaLqvchv-Cw@mail.gmail.com>
 <6286065.m5U1xfpyP1@rousseau>
In-Reply-To: <6286065.m5U1xfpyP1@rousseau>
From: Alexey Ermakov <axel101@gmail.com>
Date: Sun, 24 May 2020 18:49:23 +0300
Message-ID: <CAOVt3fHXmMbTeg1SN9Ngpf7ju6FeUvWzFa9ZsSBLuVhjF503_w@mail.gmail.com>
Subject: Re: Batman-adv packet retranslation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Yes, in real world I set throughput overriode for each interface, but
in my example only one interface configured in batman network and if
it works as you said there are several questions:
- Why direct connections work properly (I mean connections Node1-Node2
and Node2-Node3 ) even with this throughput?
- Why this scheme works then all nodes had seen originators before
throughput overrided?
- If I override throughput to 10000, for example, will it work properly?

=D0=B2=D1=81, 24 =D0=BC=D0=B0=D1=8F 2020 =D0=B3., 18:29 Marek Lindner <mare=
klindner@neomailbox.ch>:
>
> On Sunday, 24 May 2020 16:43:55 CEST Alexey Ermakov wrote:
> > [B.A.T.M.A.N. adv 2020.1, MainIF/MAC: eth0/00:04:23:dc:3b:01
> > (bat0/62:7f:0f:87:43:78 BATMAN_V)]
> >   Originator        last-seen ( throughput)  Nexthop           [outgoin=
gIF]
> > * 00:04:23:dc:3b:10    0.580s (        0.1)  00:04:23:dc:3b:10 [      e=
th0]
>
> BATMAN V chooses routes based on link throughput. If the throughput drops
> below a certain value the route is dropped. As you can imagine, a through=
put
> of 0.1 is pretty close to non-usable.
>
> BATMAN V attempts to auto-detect the throughput using various methods whi=
ch
> does not work in a virtualized environment. I suggest you go with the per=
-
> interace /sys/class/net/<iface>/batman-adv/throughput_override setting.
>
> Kind regards,
> Marek Lindner
>
