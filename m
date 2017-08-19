Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA_JP8WWPJK6LccQQRRmjDbFHWCpR9DYBtG0VNjwnA-3d7Ryww@mail.gmail.com>
References: <CAA_JP8UHmeHu_UavyVt9tXQ27AVOdNcznZnuCib3xoSDB0V8Tw@mail.gmail.com>
 <CAA_JP8WWPJK6LccQQRRmjDbFHWCpR9DYBtG0VNjwnA-3d7Ryww@mail.gmail.com>
From: dan <dandenson@gmail.com>
Date: Sat, 19 Aug 2017 17:42:40 -0600
Message-ID: <CAA_JP8WuZcVU1k+H70eqx_qrG9nBa+FYpfZHMmvNmEkjXYnZ7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] wired performance
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

2 hops on full duplex links I'm getting 464Mbps.  There is some loss
at each hop and I'm not sure why.  Could be virtualbox and resource
contension that isn't showing up in task manager and/or top on the
vm's.

is this to be expected?

On Sat, Aug 19, 2017 at 12:25 PM, dan <dandenson@gmail.com> wrote:
> I'm only able to test in virtualbox at the moment.
>
> I have a 3.1Ghz i5 and I'm able to do iperf across a batman-adv
> network (nodes A-B-C with A and C not directly connected).
>
> iperf between a<>b is ~1Gbps, A<>C is ~560Mbps and B has 1 core hit
> 100% by ksoftirqd.
>
> So it looks like I'm stuck in a single thread.
>
> I'm going to add a 4th node and do a double hop A<>D iperf and see
> what happens.  full duplex interfaces here so I don't think I'll see a
> big drop in the next test.
>
> On Wed, Aug 16, 2017 at 9:39 AM, dan <dandenson@gmail.com> wrote:
>> Anyone done any performance testing over wired links?  ie, if two
>> ethernet ports are gigabit and are added to bat0, what kind of
>> throughput is expected across these interfaces and how much CPU is
>> needed to get up near wire-speed?
