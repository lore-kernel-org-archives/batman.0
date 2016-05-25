Return-Path: <hannes.harms@tu-bs.de>
References: <5732316F.7020209@tu-bs.de> <1572215.6K5rTnkNup@voltaire>
From: "Harms, Hannes" <hannes.harms@tu-bs.de>
Message-ID: <5745DA52.4000403@tu-bs.de>
Date: Wed, 25 May 2016 19:01:06 +0200
MIME-Version: 1.0
In-Reply-To: <1572215.6K5rTnkNup@voltaire>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Unable to ping interface in ap mode / client
 mode with IP4 addr
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

ip route did the trick.
Now it is working.

Thanks,
Hannes


Am 10.05.2016 um 23:16 schrieb Marek Lindner:
> On Tuesday, May 10, 2016 21:07:27 Hannes Harms wrote:
>> But I can not ping with an IP4 addr.
>>
>> bat0 was added to a bridge interface with a static IP on both machines.
>> No DHCP server is running, because only static IPS are needed.
> Can you describe from where you are pinging (which hosts are involved) and
> post the IP configuration (e.g. ip addr && ip route) ?
>
> Thanks,
> Marek

-- 

