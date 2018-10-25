Return-Path: <jhaws@sdl.usu.edu>
From: Jonathan Haws <jhaws@sdl.usu.edu>
Date: Thu, 25 Oct 2018 13:42:58 +0000
Message-ID: <fab16bf83af547668393219bec7e35fc@sdl.usu.edu>
References: <20181024192128.22531-1-jhaws@sdl.usu.edu>,
 <2365708.Am9coUDyuZ@bentobox>
In-Reply-To: <2365708.Am9coUDyuZ@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: Request MAC resolution for
 IPv4 address not in ARP cache
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Ah, yes - I see the issue now. I'll update that when I get back. And I apol=
ogize for the top posting! My phone's email client doesn't do inline too we=
ll...



Sent from my Verizon, Samsung Galaxy smartphone


-------- Original message --------
From: Sven Eckelmann <sven@narfation.org>
Date: 10/25/18 3:42 AM (GMT-07:00)
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Jonathan Haws <jhaws@sdl.usu.edu>, guohuizou2000@sina.com
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] alfred: Request MAC resolution for I=
Pv4 address not in ARP cache

On Mittwoch, 24. Oktober 2018 13:21:28 CEST Jonathan Haws wrote:
[...]
>
> +       while (retries-- && !(arpreq.arp_flags & ATF_COM)) {
> +               ipv4_request_mac_resolve(addr);
> +               usleep(200000);
> +
> +               if (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0)
> +                       return -1;
> +       }
> +
>         if (arpreq.arp_flags & ATF_COM) {
>                 memcpy(mac, arpreq.arp_ha.sa_data, sizeof(*mac));
>         } else {

According to gary [1], this doesn't work because the ioctl fails for him an=
d
then the function returns immediately (before the while loop).

Please adjust your patch - but please don't use his code - it looks rather
ugly and also doesn't work for multiple retries. You most likely want to
drop the if-ioctl completely and then put everything in your while loop:

        while (ioctl(interface->netsock, SIOCGARP, &arpreq) < 0 ||
               !(arpreq.arp_flags & ATF_COM)) {
                if (retries-- <=3D 0)
                        break;

                ipv4_request_mac_resolve(addr);
                usleep(200000);
        }

But feel to propose a different (cleaner) approach.

Kind regards,
        Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-October/018195.h=
tml
