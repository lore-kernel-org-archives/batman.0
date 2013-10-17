Return-Path: <zaki.bm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20131014153709.GF14032@Linus-Debian>
References: <CABQkniC4b-CEdx9-7rNBuG0p5a5tM1fptsKjida0vThVUYVtug@mail.gmail.com>
 <20131013143649.GA27965@pandem0nium>
 <CABQkniCDwfVB+1n5W0M-xqkWKtkO+xKqqGSEtLm9zaYfEZC8YA@mail.gmail.com>
 <20131014153709.GF14032@Linus-Debian>
Date: Thu, 17 Oct 2013 11:21:57 +0800
Message-ID: <CABQkniBdkUhROWGXZ4FDGwXZb5ycw6tuix-tknJ7Jonf4gGqHA@mail.gmail.com>
From: Zaki <zaki.bm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Batman-Adv : Hops and Throughput with Collocated
	dual-radio
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

Hi Linus,

From A to B(radio 1) it is 5.24GHz. Throughput is 40Mbps.

From B(radio 2) to C it is 2.412GHz.
Throughput is 38Mbps.

From A to C the throughput is just 20Mbps.

Thanks.
Jack.

On Mon, Oct 14, 2013 at 11:37 PM, Linus L=FCssing <linus.luessing@web.de> w=
rote:
> Hi Jack,
>
> what is the throughput you get from B to C? What was the
> throughput you got on the 2.4GHz link alone? Did you change to
> 2.4GHz on A-B or B-C?
>
> Cheers, Linus
>
>
> On Mon, Oct 14, 2013 at 09:26:41AM +0800, Zaki wrote:
>> Hi Simon,
>>
>> Thanks for your reply.  I am using omni antenna right now and what i
>> got when i did an iPerf from A to C is only 20Mbps.  It looks like the
>> throughput is cut to half (just like a single radio mesh).  Tried 2.4G
>> frequency in one of the pair, had the same result too.  Anything in
>> terms of setting of batman-adv i can look for?.
>>
>> Rgds,
>> Jack
>>
>> On Sun, Oct 13, 2013 at 10:36 PM, Simon Wunderlich
>> <simon.wunderlich@s2003.tu-chemnitz.de> wrote:
>> > Hi Zaki/Jack,
>> >
>> > On Fri, Oct 11, 2013 at 11:11:04AM +0800, Zaki wrote:
>> >> Hi,
>> >>
>> >> I am a newbie in batman-adv.  I got a question regarding Hops and
>> >> Throughput, especially in regards with a collocated dual-radio device=
.
>> >>  Hopefully somebody could offer some help here for me to fully
>> >> understand batman-adv operation.  I have 3 devices, namely A, B and C=
.
>> >>
>> >> A is only having single radio (operating at Freq 5.20G in AdHoc mode)=
.
>> >>  Put this under bat0.  Bridge bat0 with eth0.
>> >> B is having dual-radio (radio1 operates at 5.20G in AdHoc mode, radio=
2
>> >> is at 5.24G in AdHoc mode). Put these under bat0. Bridge bat0 with
>> >> eth0
>> >> C is like A (single radio, operating at 5.24G in AdHoc mode). Put thi=
s
>> >> under bat0.  Bridge bat0 with eth0.
>> >>
>> >> So, the wireless link will be like this :
>> >>
>> >> [A]::::::::::::::: [B(radio1)---B(radio2)]::::::::::::::::[C]
>> >>
>> >> 1) If i were to ping from A to C, how many hops is it considered?.  I=
s
>> >> it 2 hops or 3 hops?.
>> >
>> > that would be two hops. One hop is considered traversing one link, and
>> > you have two links here.
>> >
>> >> 2) If my Iperf TCP throughput from A to B is 40Mbps, what is the
>> >> expected throughput of Iperf from A to C ?.
>> >
>> > That depends. If the links are not interferring, you should get approx=
.
>> > the maximum of both link throughputs. So if one link is 30 mbit/s, the=
 second
>> > is 25 mbit/s, that whole path would yield 25 mbit/s - there might be t=
cp
>> > effects further decreasing throughput (latency etc).
>> >
>> > However you use two frequencies adjacent to each other. If you use omn=
i
>> > antennas, expect a lot of interferences (even if the channels are not
>> > overlapping). If you use directional antennas you should be fine.
>> >
>> > Cheers,
>> >         Simon
>> >
>> >
>> >>
>> >> Thanks a lot.
>> >>
>> >> Jack.
