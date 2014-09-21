Return-Path: <r.krishnathiepan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <541C2B58.8070703@altermundi.net>
References: <CAEbDFcQQMaRNam=ZWBqV4yOke2SZjE8JbpDNTQKcTzzHEz=Vhg@mail.gmail.com>
 <541C2B58.8070703@altermundi.net>
Date: Sun, 21 Sep 2014 12:27:37 +0530
Message-ID: <CAEbDFcQ=SXy4OrUrD99Fi4nN9kLdNBTyDwr0Sr6HS5tDmUm4Kg@mail.gmail.com>
From: Krishnathiepan Rasanayagam <r.krishnathiepan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] traceroute help
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

hi all,

this is the error i'm getting for batctl commands like tr and p.
batctl o is working fine though.


Error - can't write to batman adv kernel file
'/sys/kernel/debug//batman_adv/bat0/socket': Invalid argument
49: *   *   *   *

cheers!

On Fri, Sep 19, 2014 at 6:40 PM, Gui Iribarren <gui@altermundi.net> wrote:
> On 19/09/14 09:43, Krishnathiepan Rasanayagam wrote:
>> dear all,
>>
>> do we have to follow different way than batctl 2012 version when we
>> are using batctl traceroute 2014 ?
>>
>>  I'm getting an error when trying to use batctl commands.
>
> *which* error?
>
> maybe you're trying to use batctl-2014 with a kernel module batadv-2012?
> (not sure if that should work)
>
> maybe you're on openwrt, and installed only "kmod-batman-adv" (which
> used to include batctl tool) , but not the (relatively new) "batctl"
> package?
>
> cheers!



-- 
Best regards,
Krishna.
