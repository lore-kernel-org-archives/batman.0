Return-Path: <gtolon@inti.gob.ar>
Message-ID: <51AF567A.7030404@inti.gob.ar>
Date: Wed, 05 Jun 2013 12:17:14 -0300
From: =?UTF-8?B?R2FicmllbCBUb2zDs24=?= <gtolon@inti.gob.ar>
MIME-Version: 1.0
References: <51A3C7E9.7080208@inti.gob.ar>
 <20130528070057.GC3333@ritirata.org> <51ACBCE4.8000506@inti.gob.ar>
 <20130603160813.GC1226@ritirata.org> <51AD0277.1060907@inti.gob.ar>
 <20130604051326.GJ1226@ritirata.org> <20130604053841.GK1226@ritirata.org>
In-Reply-To: <20130604053841.GK1226@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi,

Now I'm with batman-adv 5ffa8f201d085764365d202ace14675032cc3a74, 
batctl 6d3d4d1f80dca31b6400f3794772016cdbc19a73, and openwrt r36826.

The results are almost the same, no batctl pings, and batctl bw much 
slower than iperfs. wdr3500 have 2 radios, these are the routes:





El 04/06/13 02:38, Antonio Quartulli escribió:
> On Tue, Jun 04, 2013 at 07:13:26AM +0200, Antonio Quartulli wrote:
>> On Mon, Jun 03, 2013 at 05:54:15PM -0300, Gabriel Tolón wrote:
>>> So, in menuconfig I should select that id for batman-adv-devel right? I
>>> wanted to see that  commit on the git page using the search field but I
>>> couldn't. By the way, how to know which batctl version use with each
>>> batman-adv-devel commit? Sorry if all these questions are too basic, but
>>> I've tried to compile with this d672369 version and I got some errors,
>>> so I'd like to understand if it was related to these things.
>>
>> no problems. These are not basic questions :) Actually the user usually do not
>> enter these dev details and therefore it is normal to find issues.
>>
>> For batctl, you should use the last commit ID in this branch (ordex/bw_meter)
>> http://git.open-mesh.org/batctl.git/shortlog/refs/heads/ordex/bw_meter
>>
>>>
>>>>
>>>>
>>>> By the way, your iperf tests have been done on top of batman-adv? or directly on
>>>> the wifi interface?
>>>>
>>>> Cheers,
>>>>
>>>
>>> I got the results mentioned using interfaces managed by batman-adv.
>>
>> mh...maybe the pign is not working because of some changes brought by the
>> bw_meter in the icmp packets. I'll check and I'll let you know.
>
> I juested the current ordex/bw_meter branches (batctl and batman-adv) and the
> ping works fine.
>
> Please, let me know your results.
>
> Cheers,
>
>
