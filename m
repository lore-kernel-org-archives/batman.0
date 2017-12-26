Return-Path: <laurent@wifibot.com>
References: <b00b8bd2-68bc-54fd-4d1c-cd3f9655fac1@wifibot.com>
 <3091209.OFEMCjJbTv@sven-edge>
From: laurent <laurent@wifibot.com>
Message-ID: <dfbc17dc-bc7d-d830-79c8-50db9e0ee0a9@wifibot.com>
Date: Tue, 26 Dec 2017 10:08:15 +0100
MIME-Version: 1.0
In-Reply-To: <3091209.OFEMCjJbTv@sven-edge>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [B.A.T.M.A.N.] cannot recompile my openwrt image with last
 version of batman-adv 2017-4
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, b.a.t.m.a.n@lists.open-mesh.org

Hello,

I was using the openwrt package feed for my version, but finally it=20
works by cleaning properly the old version and re update the feed again,=20
I had also corrected a small error line 324 in the new "compat-hacks.h"=20
for 2017.4 :

static inline void =A0=A0=A0 (struct timer_list *timer,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 void (*callback)(struct t=
imer_list *),
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 unsigned int flags)
{
 =A0=A0=A0 __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 (TIMER_DATA_TYPE)timer, flags);
}

by

static inline void *timer_setup(struct timer_list *timer,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 void (*callback)(struct t=
imer_list *),
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0=A0 unsigned int flags)
{
 =A0=A0=A0 __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0 (TIMER_DATA_TYPE)timer, flags);
}

it is fine now.

I am doing this upgrade because I had some trouble by settings 5 fixed=20
nodes in our place and making a robot passing at 6km/h near them, the=20
route was not stable.
So i am trying to have the new version to begin to tune some parameters.
The robot is using 1.5Mbs bandwidth and it stream UDP h264 video packet,=20
the other side is sending only a few tcp control packets.
A long time ago I was using ubiquity hardware but now for batman-adv we=20
have bought gateworks hardware, they are more maintained.

i am still have this feeling that when all nodes see each-other the=20
calculated route is not stable in my case (version IV or V).

Does batman-adv have like olsr an hysteresis parameter to stabilize the=20
route once calculated ?

With 3 nodes all is ok.

I will make a new test and post a new thread with more infos

Best Regards,

Laurent



On 25/12/2017 20:24, Sven Eckelmann wrote:
> On Montag, 25. Dezember 2017 18:36:56 CET laurent wrote:
> [...]
>> I am able to compile alone the module in the build forlder:
>>
>> /home/user/gateworks-openwrt/build_dir/target-arm_mpcore+vfp_musl-1.1.12=
_eabi/linux-cns3xxx/batman-adv-2017.4/net/batman-adv/bat_iv_ogm.c:734:2:
>> error: implicit declaration of function 'skb_put_data'
>> [-Werror=3Dimplicit-function-declaration]
>>     skb_put_data(forw_packet_aggr->skb, packet_buff, packet_len);
>>     ^
> Please use a batman-adv package which is compatible for your OpenWrt vers=
ion.
> Or use LEDE (master) with openwrt-routing. Don't try to compile
> openwrt-routing master (which is for LEDE master) against OpenWrt Chaos
> Calmer.
>
> Kind regards,
> 	Sven


