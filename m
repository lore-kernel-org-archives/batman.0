Return-Path: <linus.luessing@c0d3.blue>
Date: Thu, 26 Jul 2018 09:24:01 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20180726072401.GA1557@otheros>
References: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] ICMP6 flood or nodes limit ?
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

On Wed, Jul 25, 2018 at 10:50:10PM +0300, Nicu Pavel wrote:
> root@gateway-b827ebecbfa7:~# batctl o
> [B.A.T.M.A.N. adv 2018.2, MainIF/MAC: wlan0/b8:27:eb:ec:bf:a7 (bat0/4e:06:5f:54:e5:d5 BATMAN_IV)]
>    Originator        last-seen (#/255) Nexthop           [outgoingIF]
>    b8:27:eb:a7:ed:ff    0.330s   ( 24) b8:27:eb:ad:4b:7e [     wlan0]
>    b8:27:eb:a7:ed:ff    0.330s   (  0) b8:27:eb:ec:e5:9f [     wlan0]
>    b8:27:eb:a7:ed:ff    0.330s   ( 43) b8:27:eb:97:55:b6 [     wlan0]
>    b8:27:eb:a7:ed:ff    0.330s   ( 38) b8:27:eb:1b:61:f0 [     wlan0]
>    b8:27:eb:a7:ed:ff    0.330s   ( 15) b8:27:eb:91:5c:41 [     wlan0]
[...]

Overall, the TQ values seem rather low.

>  root@gateway-b827ebecbfa7:~# batctl n
> [B.A.T.M.A.N. adv 2018.2, MainIF/MAC: wlan0/b8:27:eb:ec:bf:a7 (bat0/4e:06:5f:54:e5:d5 BATMAN_IV)]
> IF             Neighbor              last-seen
>         wlan0     b8:27:eb:ad:df:c0    1.000s
>         wlan0     b8:27:eb:30:15:c9    0.390s
>         wlan0     b8:27:eb:a8:22:f6    1.560s
>         wlan0     b8:27:eb:92:eb:b8    0.650s
[...]
>         wlan0     b8:27:eb:bb:a1:94   11.710s
>         wlan0     b8:27:eb:91:5c:41    1.480s
>         wlan0     b8:27:eb:5f:eb:e8    7.600s

Those are quite a lot of neighbor nodes. Do you actually have any
airtime left? I can recommend H.O.R.S.T. to check that:

https://github.com/br101/horst

As a rule of thumb, BATMAN IV overhead increases linear to the
overall number of mesh nodes, but squared to the number of
neighbor nodes a particular node has.

Also, just to be on the safe side, check that there is no MAC
address conflict / duplicate MAC address somewhere.

Regards, Linus
