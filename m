Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHD-aqLC=xuknD_HWJS1NzrZAcwgxYb3Q4DBVm6cgUYMosCiUw@mail.gmail.com>
References: <CAHD-aqLcsciDBA=4D3ZH0yP4WEYsgY7BhZ+3NFmnm4vQF_apmw@mail.gmail.com>
 <50944FF6.5070504@eigenlab.org>
 <CAHD-aqLC=xuknD_HWJS1NzrZAcwgxYb3Q4DBVm6cgUYMosCiUw@mail.gmail.com>
From: Esteban Municio <emunicio@gmail.com>
Date: Mon, 19 Nov 2012 16:32:51 -0500
Message-ID: <CAMVTf1jua9ZN58Jx=p7kDOn3QbQi_Eo1Mt3taZ2D0ra_td=gGQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] A batman-adv success story
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

Thanks Gui for share your experiences. As soon as we can give formal
results from our implementation in Huancavelica, (Peru) we'll share it
too.

PD: it's nice the test of the roaming through the river ;-)

2012/11/16 Gui Iribarren <gui@altermundi.net>:
> On Fri, Nov 2, 2012 at 7:57 PM, Gioacchino Mazzurco <gio@eigenlab.org> wrote:
>> In Ninux Pisa we use batman-adv too with similar results!
>
> Great! I'm partially aware of it, but have no idea of the scale and
> the details. Do share your experience! :D
>
> I also came accross this
>
> http://www.open-mesh.org/projects/open-mesh/wiki/New_papers
>
> some interesting readings
>
>>
>> eccept for this:
>>
>> On 11/02/12 22:21, Gui Iribarren wrote:
>>> As it is today, you can't put 2 ipv6 gateways doing SLAAC in the same
>>> batman-adv cloud.
>>
>> This sentence is a little misleading, it is not true you cannot do it,
>> you can but you just receive multiple route announcement that may be not
>> optimal but it is not problematic in most cases
>
> IF they are announcing the same prefix, then i agree with your statement
> But AFAIU it's currently not possible to have different gateways
> announcing two different prefixes... Clients get SLAAC addresses on
> two different networks, and things break, (at least that's what i
> understand about how things should work?)
>
> If batman-adv could segregate RAs broadcast domains, it would separate
> ipv6 networks much like it does now with dhcpv4 servers offering ips
> on different subnets
>
> Gui



-- 
Esteban
