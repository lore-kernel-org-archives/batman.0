Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <9364270.jsCkp9vufn@sven-edge>
References: <CAA_JP8VLAE7pFH+1ztUp+ZUhJGFFeLR_cWHz=tduRFHPAYv=3g@mail.gmail.com>
 <9364270.jsCkp9vufn@sven-edge>
From: dan <dandenson@gmail.com>
Date: Fri, 11 May 2018 10:08:19 -0600
Message-ID: <CAA_JP8U2fg+gYmhSD+bL7ji8bDNMRi2+hEB2zJkD=t=6MDjRBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] sanity check please
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
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Sven, I'm not actually concerned with the performance here, it's good
enough *if* this is actually realistic and not a weird effect of the
virtual environment.

ALL of my gear is limited by a 1Gbps port and I also basically trapped
all the VMs and virtio ethernet devices to a single CPU.

It's just going to cost me $400-$500 in hardware purchases to take the
next step.

On Fri, May 11, 2018 at 12:06 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Donnerstag, 10. Mai 2018 01:43:56 CEST dan wrote:
> [...]
>> I'm running iperf3 with VM1 the server and VM3 the client
>>
>> VM1
>> iperf3 -s
>> VM3
>> iperf3 -c 192.168.5.1 -b 10000M -t 60 -P 1
>>
>> output is 1.75Gbits
>>
>> -P 99
>>
>> output is 831Mbps
>>
>>
>> -P 99 *BUT* hitting the 'native' LAN address of 192.168.1.1 (each VM
>> has an ens18 on this network)
>>
>> 4.8Gbps
>>
>> -P 99 from VM2
>>
>> ~1.67Gbps
> [...]
>
> Please make sure that you are *not* using fragmented packets and that you have
> the flow dissector support enabled for batman-adv unicast packets [1]. And
> check your RPS/XPS settings.
>
> Kind regards,
>         Sven
>
> [1] https://patchwork.open-mesh.org/cover/17240/
