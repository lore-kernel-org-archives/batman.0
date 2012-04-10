Return-Path: <martin@hundeboll.net>
Message-ID: <4F8416FD.5010707@hundeboll.net>
Date: Tue, 10 Apr 2012 13:18:21 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<201204041008.06362.lindner_marek@yahoo.de>
	<4F840CC6.8000404@hundeboll.net>
	<201204101408.39431.lindner_marek@yahoo.de>
In-Reply-To: <201204101408.39431.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [RFC 0/2] Create counters for measuring behaviour
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On 04/10/2012 01:08 PM, Marek Lindner wrote:
> On Tuesday, April 10, 2012 13:34:46 Martin Hundebøll wrote:
>>>> Currently, my catwoman branch uses these counters (e.g. to tell how many
>>>> packets are coded together), but other counters can easily be added.
>>>> E.g. counters relevant to the BLA, DAT, OGM/ELP code.
>>>>
>>>> If this feature is unneeded/unwanted, I will remove the dependency in
>>>> catwoman.
>>>
>>> Could you explain in a few words how catwoman depends on the stats
>>> counter ?
>>
>> Sure, it's merely because I use the bat_stats-functions in the catwoman
>> branch. Nothing more than that.
>
> If the traffic counter code provides empty functions to be called when it is
> not compiled into the module it should all work ?

Yeah, but these empty functions wan't be here, if the bat_stats code is never merged :)


-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
