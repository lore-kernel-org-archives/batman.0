Return-Path: <panickiss@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5556611.7sBE4ScoTE@rousseau>
References: <CALb7xhwsssLtKnT+Y8pmVch7OOUdUQ_n+yN61tUfQx7RE0KOCw@mail.gmail.com>
 <5556611.7sBE4ScoTE@rousseau>
From: Nicu Pavel <panickiss@gmail.com>
Date: Thu, 26 Jul 2018 09:14:14 +0300
Message-ID: <CALb7xhz53Z+ykBxAGgEb5oixf-KVHXTc_ooECZ2ZMARxDvvnfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, Jul 26, 2018 at 4:12 AM, Marek Lindner
<mareklindner@neomailbox.ch> wrote:
> On Thursday, 26 July 2018 03:50:10 HKT Nicu Pavel wrote:
>> Everything works fine with 31 hosts when I add more (34 max)
>> everything stop working, hosts start to drop, I do see a lot ICMP6
>> neighbor advertisement/solicitation. I increased the default values
>> for elp_interval and orig_interval to 5 and 10 seconds. Once I power
>> down  the extra host(s) everything goes back to normal. The actual
>> traffic in the mesh beside the ICMP6 is low a few KB sent once per
>> minute.
>
> There is no hard-coded host limit in batman-adv. It is more likely to do with
> your wifi driver. What wifi chip & driver have you deployed ?

I'm using kernel 4.9.111 with latest brcmfmac driver which loads the
brcmfmac43430-sdio firmware
for this board.
The strange part is that once I get over 31 hosts the ICMP6 "explodes"
with no apparent reason.

I'm also not sure about the originators list, if you look at the
attached file, all originators TQ is pretty low and also each
originator has all other hosts as NextHop. Not sure if this is correct
or can affect.
All these 30 hosts are pretty close to one another.

> If you check the mailing list archives you will see the wifi driver issue
> coming up on a regular basis. This example discussion is merely a few days
> old:
>
> https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2018-July/017952.html

Yes, I found that thread, but problem is quite different as with
RealTek chipsets seems like nothing really works.

Thanks,
Nicu
