MIME-Version: 1.0
In-Reply-To: <4313f3060905270921p31ea2a10m21d1b9bf61170132@mail.gmail.com>
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<200905270013.12447.sven.eckelmann@gmx.de>
	<4313f3060905270720k45859cb5y822c47397482b77c@mail.gmail.com>
	<200905271816.04764.sven.eckelmann@gmx.de>
	<4313f3060905270921p31ea2a10m21d1b9bf61170132@mail.gmail.com>
Date: Wed, 27 May 2009 11:35:42 -0500
Message-ID: <4313f3060905270935ub7f69fct239833a3bcaf742c@mail.gmail.com>
From: Nathan Wharton <naw@greptar.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@open-mesh.net

On Wed, May 27, 2009 at 11:21 AM, Nathan Wharton <naw@greptar.com> wrote:
> On Wed, May 27, 2009 at 11:16 AM, Sven Eckelmann <sven.eckelmann@gmx.de> =
wrote:
>> Thanks. This is completely unexpecting for a kernel with alignment trap.=
 The
>> expected result is =A0"Value: 12389ab 89abcdef". Can you check the value=
 of
>> /proc/cpu/alignment ? I will look further at it this evening.
>>
>> Regards,
>> =A0 =A0 =A0 =A0Sven
>>
>
> User: =A00
> System: =A00
> Skipped: 0
> Half: =A00
> Word: =A00
> DWord: =A00
> Multi: =A00
> User faults: 0 (ignored)
>

I do get the correct result after echo 2 > /proc/cpu/alignment
