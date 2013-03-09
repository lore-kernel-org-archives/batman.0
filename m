Return-Path: <mihail.costea90@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201303091812.18563.lindner_marek@yahoo.de>
References: <CAP5XTDMu4ujnntwCANw1etKK_KYWt22UvR0HBCbama41hViQ9Q@mail.gmail.com>
 <201303091812.18563.lindner_marek@yahoo.de>
Date: Sat, 9 Mar 2013 12:55:46 +0200
Message-ID: <CAP5XTDOfduGu-pELQJOcXvt09AFXc_V0rYzJJ6nvyHgxKpGmRg@mail.gmail.com>
From: Mihail Costea <mihail.costea90@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Added IP enum types for dat
 and generic functions for comparing IPs and calculating hash
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

On 9 March 2013 12:12, Marek Lindner <lindner_marek@yahoo.de> wrote:
> On Friday, March 08, 2013 18:50:46 Mihail Costea wrote:
>> From d7a67d268ddd4d8788f806872459609994da7586 Mon Sep 17 00:00:00 2001
>> From: Mihail Costea <mihail.costea90@gmail.com>
>> Date: Fri, 8 Mar 2013 12:43:16 +0200
>> Subject: [PATCH] batman-adv: Added IP enum types for dat and generic
>> functions for
>>  comparing IPs and calculating hash
>>
>> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>>
>> ---
>>  distributed-arp-table.c |   54
>> ++++++++++++++++++++++++++++++++++++++---------
>> types.h                 |   10 +++++++++
>>  2 files changed, 54 insertions(+), 10 deletions(-)
>
> Is the rest of the patchset still coming or did it get lost in transit ?
>
> Cheers,
> Marek

I thought do send it in steps to make it easier for reading. This is
the first part. The second would be generic debug method and the last
would be all functions transformed.
Or should I send it all (its the first time I submit a patch, so I'm not sure).

-- 
Mihail Costea
E-mail : mihail.costea90@gmail.com
Telephone : +40725245085
