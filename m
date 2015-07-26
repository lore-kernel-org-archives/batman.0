Return-Path: <carlosmeralto@gmail.com>
MIME-Version: 1.0
In-Reply-To: <11411625.XETR6nI4Wt@bentobox>
References: <CALaFpeUvicwHWQag0Upv5UNQ935TYY-RJuXVUtpT7gfORWZm7A@mail.gmail.com>
 <CALaFpeWSYsMCVFf5mSCnVyOZJRpRzFahSRD5ndVg8rUc9jHpYA@mail.gmail.com>
 <5967184.Q5nWeNzPJU@sven-edge> <11411625.XETR6nI4Wt@bentobox>
Date: Sun, 26 Jul 2015 19:27:28 +0100
Message-ID: <CALaFpeUeV9sOnBp=oj-gfjbFd=hd=SPMBPE7+VS+Q6S0e9tsbg@mail.gmail.com>
From: Carlos Meralto <carlosmeralto@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Recover in case of node fail
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

I tried "batctl ping -R MAC" and the node recover well. But when i try
"ping IP" does not work and the ping blocks...
It is normal that this happens?

Best Regards,
Carlos Meralto

2015-07-23 8:57 GMT+01:00 Sven Eckelmann <sven@narfation.org>:
> On Wednesday 22 July 2015 20:01:51 Sven Eckelmann wrote:
>> This was not what I said. ICMP ping should work perfectly fine. I just
>> suggested that you try `batctl -R`
>
> batctl ping -R ...
