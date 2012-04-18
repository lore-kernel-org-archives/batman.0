Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E7CE0.2010409@hundeboll.net>
Date: Wed, 18 Apr 2012 10:35:44 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-2-git-send-email-ordex@autistici.org>
	<4F8E777A.5010901@hundeboll.net>
	<20120418083137.GF27966@ritirata.org>
In-Reply-To: <20120418083137.GF27966@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/5] batman-adv: don't delay OGM
 information announcement
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 04/18/2012 10:31 AM, Antonio Quartulli wrote:
> On Wed, Apr 18, 2012 at 10:12:42AM +0200, Martin Hundebøll wrote:
>> Hi Antonio,
>>
>> One minor/trivial change below.
>>
>> On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
>>> +	/* if we have too many changes for one packet don't send any
>>> +	 * and wait for the tt table request which will be fragmented */
>>
>> Better change that comment te end with */ on a newline, before sending to David :)
>
> I definitely agree. Thank you. I would really like to see this check in
> checkpatch.pl :(:(

I think you are free to send a patch to checkpatch.pl :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
