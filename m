Return-Path: <martin@hundeboll.net>
Message-ID: <4F8E7E0F.5080209@hundeboll.net>
Date: Wed, 18 Apr 2012 10:40:47 +0200
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1334701645-25862-1-git-send-email-ordex@autistici.org>
	<1334701645-25862-3-git-send-email-ordex@autistici.org>
	<4F8E7C5E.9010301@hundeboll.net>
	<20120418083714.GG27966@ritirata.org>
In-Reply-To: <20120418083714.GG27966@ritirata.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: clear ADD+DEL (and
 viceversa) events in the same orig-interval
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

On 04/18/2012 10:37 AM, Antonio Quartulli wrote:
> On Wed, Apr 18, 2012 at 10:33:34AM +0200, Martin Hundebøll wrote:
>> Hi Antonio,
>>
>> On 04/18/2012 12:27 AM, Antonio Quartulli wrote:
>>> +	/* check for ADD+DEL or DEL+ADD events */
>>>    	spin_lock_bh(&bat_priv->tt_changes_list_lock);
>>> +	list_for_each_entry_safe(entry, safe,&bat_priv->tt_changes_list,
>>> +				 list) {
>>> +		if (!compare_eth(entry->change.addr, addr))
>>> +			continue;
>>
>> Please add an empty line here.
>
> Is this really needed for some specific reason?

No, but I like it that way :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99A, 1.th
8000 Aarhus C
Denmark
+45 61 65 54 61
martin@hundeboll.net
