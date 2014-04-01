Return-Path: <gui@altermundi.net>
Message-ID: <533A2A75.4000602@altermundi.net>
Date: Mon, 31 Mar 2014 23:54:45 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <0643725B-CC5E-4AAA-8908-C6A0EA4CE631@gmail.com>
 <26865236.GIsAj78OZH@diderot> <533A078C.7060803@wirelesspt.net>
In-Reply-To: <533A078C.7060803@wirelesspt.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Batman-adv 2014.1.0 and 2014.0.0 issues with
 3.10 and 3.8 kernels
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
To: b.a.t.m.a.n@lists.open-mesh.org

On 03/31/2014 09:25 PM, cmsv wrote:
>>>
>>> After following the instructions from cmsv <cmsv@wirelesspt.net>
>>> and replacing the feeds.conf with
>>> src-git routing https://github.com/libre-mesh/openwrt-routing-packages
>>
>> Note that this is not the official openwrt-routing repository but a fork
>> maintained by 'people on the internet'. If you do experience problems with the
>> code coming from this repository, please contact the people maintaining this
>> fork.
>>
>
> As far as i know; it is a clone of the batman-adv 2013.* without any
> modification. Perhaps the maintainer could shed some light into this
> subject.

Indeed, currently it's just a "snapshot" of the official 
openwrt-routing/packages as it was back in december.

I guess cmsv suggested Bruno to use this as an easy way to get 2013.4.0 
source code, instead of properly checking out an older version of the 
official repo

something like

     $ cd feeds/routing
     $ git log batman-adv # find your favorite old version
     $ git checkout e2cfab7f287673b1d6854c59db6e710668d145f3

> https://github.com/libre-mesh/openwrt-routing-packages/tree/master/batman-adv
> I have it fully working without any problems as a clone of batman-adv
> 2013.* without any modifications from "people on the internet".

As long as those people on the internet don't decide is time to move 
"master" further on, and break your tree on your next git pull :)

>
> There are also other ways to use the current official
> openwrt-routing-packages repository and selecting only the 2013.* releases.

Indeed, and you should do so,

maybe even add your own frozen fork to the list,
https://github.com/openwrt-routing/packages/network
and be surprised when another random folk starts using it? yay! :P

cheerfully,

gui

>
>>
>> Cheers,
>> Marek
>>
