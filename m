Return-Path: <emiliemeyer1016@gmail.com>
MIME-Version: 1.0
References: <CAFF9uhp7M94yAPhWnpUkBwLzQa8rgxMGdBYU2CNQ203QtJZs9g@mail.gmail.com>
 <1873965.jgP86xNRV2@sven-edge>
In-Reply-To: <1873965.jgP86xNRV2@sven-edge>
From: Emilie Meyer <emiliemeyer1016@gmail.com>
Date: Fri, 21 Feb 2020 14:41:28 -0800
Message-ID: <CAFF9uhqaC0HOhiYxVaHAvU++enbO2STjupsoCiNauaeRTynu8g@mail.gmail.com>
Subject: Re: Issue with bridging LAN and mesh network
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven and thanks for your kindness helping me out.

I have spent some time trying a few of your suggestions. In my case
using the brctl commands was the easiest and most successful.
However, what I've learned so far is that using brctl and other CLI
commands according to

https://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide

is not a persistent solution. Each time the router is restarted, all
previous configurations are lost.
I guess one way to solve this is by using UCI configurations, but I am
not certain how to translate all the steps above to UCI.

I sincerely hope for your kind advice and guidance.

Kind regards

Emilie

On Sun, Feb 16, 2020 at 10:39 AM Sven Eckelmann <sven@narfation.org> wrote:
>
> On Sunday, 16 February 2020 19:20:41 CET Emilie Meyer wrote:
> [...]
> > root@OpenWrt:~# ip link set eth0 master mesh-bridge
> > ip: either "dev" is duplicate, or "master" is garbage
> [...]
> > OpenWrt 18.06.4, r7808-ef686b7292
> [...]
>
> The problem here is that the networking/libiproute/iplink.c from busybox in
> OpenWrt 18.04.x has the code for the "master" interface configuration
> disabled. You have various options:
>
> * switch to the current release OpenWrt 19.07
> * switch from busybox's iplink applet to the package ip-full
> * use netifd to configure the interfaces [1]
> * use brctl to configure the bridge slave interfaces
>
>      brctl addif mesh-bridge eth0
>
> Kind regards,
>         Sven
>
> [1] https://www.open-mesh.org/projects/batman-adv/wiki/Batman-adv-openwrt-config#Batman-adv-201300-till-20190-2



-- 
Regards

Emilie
