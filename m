Return-Path: <moritzwarning@web.de>
Subject: Re: Unknown symbol cfg80211_get_station
References: <cef22736-91db-6a22-6da4-35a4d53a4adc@web.de>
 <91929546.yq5N1g86sx@bentobox>
 <e8205d24-56d7-14fd-6cd8-367791c2c003@canonical.com>
 <10352586.3EjdGBoHHf@bentobox>
 <af494410-d3a2-4602-644a-1eab1536f9b6@canonical.com>
From: Moritz Warning <moritzwarning@web.de>
Message-ID: <a812be07-c2b8-b58c-2d31-f76747402344@web.de>
Date: Mon, 15 Jul 2019 18:28:04 +0200
MIME-Version: 1.0
In-Reply-To: <af494410-d3a2-4602-644a-1eab1536f9b6@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Stefan Bader <stefan.bader@canonical.com>, Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Ubuntu Kernel Team <kernel-team@lists.ubuntu.com>

Yes this is what I meant. Thank you all for addressing this.

On 7/15/19 6:04 PM, Stefan Bader wrote:
> On 10.07.19 11:56, Sven Eckelmann wrote:
>> On Wednesday, 10 July 2019 10:56:36 CEST Stefan Bader wrote:
>> [...]
>>>>> As Jens pointed out the missing modules are in linux-modules-extra n=
ot in
>>>>> linux-modules (the former is not installed by default).
>>>>
>>>> Who is Jens and where did he point something out?
>>>>
>>>> On Saturday, 6 July 2019 17:22:01 CEST Moritz Warning wrote:
>>>>> The module linux-modules-extra-4.15.0-1032 installs the following fi=
les:
>>>
>>> Sorry, I meant Moritz ^
>>
>> But he said something else. Or maybe I misunderstood him.
>>
>> I think Moritz meant that he didn't find the cfg80211.ko for his kernel=
. And
>> thus cannot run batman-adv due to the missing dependency (which was int=
roduced
>> because the kernel was compiled with cfg80211 but the cfg80211.ko was t=
hen not
>> shipped).
>>
>> I also just tried to find linux-modules-extra-4.15.0-1032 but there are=
 only
>> following packages in bionic:
>>
>> * linux-modules-extra-4.15.0-1032-azure
>> * linux-modules-extra-4.15.0-1032-gcp
>> * linux-modules-extra-4.15.0-1032-gke
>
> Sorry for the late reply. This was discussed internally now and we will =
be
> working on getting this resolved (by starting to ship modules-extra for =
aws, too).
>
> -Stefan
>
>>
>> There is none which looks like it is for aws (something like
>> linux-modules-extra-4.15.0-1032-aws).
>>
>> Kind regards,
>> 	Sven
>>
>
>

