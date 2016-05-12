Return-Path: <alvaro.antelo@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160512085749.GE21549@prodigo.lan>
References: <CAKOC6KQMSca-tSOoKFm9t1LXrOnwHKbf3Ac0hXT6QZWxM_uwtw@mail.gmail.com>
 <1588847.AaxGtfAtFh@sven-edge> <20160512085749.GE21549@prodigo.lan>
Date: Thu, 12 May 2016 10:42:11 -0300
Message-ID: <CAKOC6KTQpUZRVUZ36yKigYDweHiKALKngOR7f5p4vVbZLEL-GA@mail.gmail.com>
From: Alvaro Antelo <alvaro.antelo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Problem with DHCP on batman-adv V
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Thank you Sven and Antonio,

I will try both options.

Best regards,

On Thu, May 12, 2016 at 5:57 AM, Antonio Quartulli <a@unstable.cc> wrote:
> On Thu, May 12, 2016 at 07:05:20AM +0200, Sven Eckelmann wrote:
>> On Wednesday 11 May 2016 18:58:48 Alvaro Antelo wrote:
>> > Hi everyone,
>> >
>> > I am testing batman-adv V5 from the development feed on Chaos Calmer
>> > and so far everything is working except for DHCP IPv4, only static
>> > addresses.
>> > In the same setup wich involves bridges connected to bat0 interfaces,
>> > if I change only the routing algorithm to batman-adv IV, DHCP works
>> > fine.
>> >
>> > Is it a expected behaviour?
>>
>> Afaik there is no working gateway selection logic in B.A.T.M.A.N. V. At least
>> Antonio works on some patches for this:
>>
>> https://patchwork.open-mesh.org/patch/16139/
>> https://patchwork.open-mesh.org/patch/16140/
>> https://patchwork.open-mesh.org/patch/16141/
>> https://patchwork.open-mesh.org/patch/16142/
>> https://patchwork.open-mesh.org/patch/16143/
>>
>> This includes splitting up the logic and use the metrics for each routing
>> algorithm. But I think he can tell you more about now works (or doesn't) and
>> what will work after his patchset is applied.
>
> Sven was right. In our current code, the GW selection logic doesn't work when
> using B.A.T.M.A.N. V. We are working on it.
>
> Maybe you could try applying the patches suggested by Sven and let us know if it
> works for you ?
>
> In the meanwhile you can just disable GW mode (batctl gw off).
>
> Cheers,
>
>
>
> --
> Antonio Quartulli



-- 
Alvaro Antelo
