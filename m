Return-Path: <martin@hundeboll.net>
Message-ID: <4F310757.7030801@hundeboll.net>
Date: Tue, 07 Feb 2012 12:13:27 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
	<4F30EFDA.9010405@hundeboll.net>
	<201202071911.00384.lindner_marek@yahoo.de>
In-Reply-To: <201202071911.00384.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: randomize initial seqno
 to avoid collision
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

On 2012-02-07 12:10, Marek Lindner wrote:
>>> +	unsigned long random_seqno;
>>> >  >  +
>>> >  >  +	/* randomize initial seqno to avoid collision */
>>> >  >  +	get_random_bytes(&random_seqno, sizeof(unsigned long));
>>> >  >  +	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);
>> >
>> >  Wouldn't it be better to cast "unsigned long" in the call to atomic_set()?
> Why should it better ?

Maybe not better, but at least it is consistent with the type of random_seqno, which is unsigned long. I know the two types are identical, but nevertheless, I like to use the same type of type :)

-- 
Med venlig hilsen
Martin Hundebøll
Nordborggade 57, 2. 1
8000 Aarhus C

+45 61 65 54 61
martin@hundeboll.net
