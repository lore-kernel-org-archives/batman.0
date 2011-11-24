Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <3164615.DFmizAk306@sven-laptop.home.narfation.org>
References: <1322139961-12706-1-git-send-email-daniele.furlan@gmail.com>
	<1848153.OCba6IfGej@sven-laptop.home.narfation.org>
	<CAG7VhQSf-YN5wQA0iuAQa3LqDkKFb=j1f5QfqsNuDVZWeehDYQ@mail.gmail.com>
	<3164615.DFmizAk306@sven-laptop.home.narfation.org>
Date: Thu, 24 Nov 2011 15:56:48 +0100
Message-ID: <CAG7VhQSLjXX_FKSwYpHRQCqC2ro28JWMqFn4kgJ4TL5APqWqng@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] Remove useless condition
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

2011/11/24 Sven Eckelmann <sven@narfation.org>:
> On Thursday 24 November 2011 15:25:40 Daniele Furlan wrote:
>> 2011/11/24 Sven Eckelmann <sven@narfation.org>:
>> > On Thursday 24 November 2011 14:06:01 Daniele Furlan wrote:
>> >> ---
>> >
>> > What do you think about some information, reasoning, examples,....
>>
>> Ok, using letter a,b,c,k instead of:
>>
>> c =3D total_count
>> a =3D neigh_rq_count
>> b =3D orig_eq_count
>> k =3D TQ_LOCAL_BIDRECT_SEND_MINIMUM
>
> what about l =3D TQ_LOCAL_BIDRECT_RECV_MINIMUM?
>
oops I read too fast and i miss the two distinct constants in
the condition...
I complain about this gaff....

>>
>> then the code do the following:
>>
>> c =3D min (a,b)
>> and then check this condition:
>> (c<k OR a<k)
>
> no, it compares (c<k || a<l)
>
> [snip]
> Wrong proof using wrong assumptions. You just cannot say that
> TQ_LOCAL_BIDRECT_SEND_MINIMUM has always the same value as
> TQ_LOCAL_BIDRECT_RECV_MINIMUM just because it is in this particular examp=
le.
>
Anyhow, is there a reason to assign to these constants different values?

> And just as reminder: Such things belong in the commit message.
>
> Kind regards,
> =A0 =A0 =A0 =A0Sven

Regards.

--=20
Daniele Furlan
