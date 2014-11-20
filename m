Return-Path: <martin@hundeboll.net>
Message-ID: <546DE067.8070807@hundeboll.net>
Date: Thu, 20 Nov 2014 13:36:55 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
In-Reply-To: <1416486149.2747.9.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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

Hi Phi

On 2014-11-20 13:22, Philipp Psurek wrote:
> Hi Martin
>
> /usr/src/linux/net/batman-adv/fragmentation.c is patched. I'm sorry I
> oversaw your attachment. the new module is running, the size differs
>
> # lsmod
> [ … ]
> batman_adv            147774  0 # old
> batman_adv            148030  0 # new
> [ … ]

Cool!

>
> Batman-adv runs with
>
> # batctl if
> fastd0: active
>
> # batctl it
> 5000
>
> # batctl ap
> disabled
>
> # batctl bl
> enabled
> # batctl dat
> enabled
>
> # batctl ag
> enabled
>
> # batctl b
> disabled
>
> # batctl f
> enabled
>
> # batctl nc
> enabled
>
> # batctl mark
> 0x00000000/0x00000000
>
> # batctl mm
> enabled
>
> batctl ll
> Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such
> file or directory [ … ]
>
> batctl gw
> server (announced bw: 100.0/100.0 MBit)
>
> this are also the options while kernel panic.
>

[...]

>> Would you mind sending me your fastd config (without the key), so that I
>> can try to reproduce this in my VMs?
>
> Not at all. Here is the censored /etc/fastd/fastd.conf
>
> #---8<---8<---8<---8<---8<---8<----

[...]

> #---8<---8<---8<---8<---8<---8<----EOF

Thanks for the config. A little more commands than I expected, but I 
will take a look within the following days.

> Now we have to wait till “prime time” or weekend. I always hoped:
> “please don't crush” but now it's different ;-) I hope after that you
> can reproduce the bug and fix it.

Please note that the server shouldn't crash with the patch applied, but 
simply print some info to dmesg. So please please check `dmesg` every 
now and then. You can use grep:

dmesg | grep batadv_frag_merge_packets

Thanks,
Martin
