Return-Path: <bethencourt@gmail.com>
MIME-Version: 1.0
Sender: bethencourt@gmail.com
In-Reply-To: <20100507152606.GA18943@kroah.com>
References: <201005072243.12054.lindner_marek@yahoo.de>
	<20100507152606.GA18943@kroah.com>
Date: Fri, 7 May 2010 18:41:45 +0100
Message-ID: <y2x506b70dc1005071041zb0659d46n73f4faf14625ec41@mail.gmail.com>
From: Luis de Bethencourt <luisbg@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman patch authorship mangled
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
To: Greg KH <greg@kroah.com>
Cc: b.a.t.m.a.n@lists.open-mesh.net, Marek Lindner <lindner_marek@yahoo.de>

On Fri, May 7, 2010 at 4:26 PM, Greg KH <greg@kroah.com> wrote:
> On Fri, May 07, 2010 at 10:43:11PM +0800, Marek Lindner wrote:
>>
>> Hi Greg,
>>
>> the last patchset sent by Andrew contained a few errors regarding the
>> authorship due to incorrect handling on our side. We did not notice thes=
e
>> issues until the patches went out to get included by you.
>
> Ick.
>
>> Here is the complete list of incorrect assignments:
>> =A0* should be Linus instead of Simon
>> =A0=3D> [PATCH 07/26] staging:batman-adv: Remove dead max addr and obsol=
ete
>> VIS_FORMAT strings
>> =A0=3D> [PATCH 09/26] staging:batman-adv: Update README about vis raw ou=
tput
>>
>> =A0* should be Luis instead of Marek
>> =A0=3D> [PATCH 12/26] staging:batman-adv: fix whitespace style issues
>>
>> =A0* should be Sven instead of Marek
>> =A0=3D> [PATCH 24/26] staging:batman-adv: Fix whitespace problems critic=
ized by
>> checkpatch.pl
>> =A0=3D> [PATCH 25/26] staging:batman-adv: Reduce max characters on a lin=
e to 80
>>
>> Is there any way to correct the authors of the patches in question ? I k=
now
>> that modifying the git history to fix the author will change all followi=
ng
>> hashes and everyone has to rebase its tree.
>> Personally, I'm not so worried about Linus & Sven, since they are longte=
rm
>> contributors and somewhat close to the project. I'm sure a beer or two c=
an
>> compensate them for the loss of fame. Luis on the other hand seemed to b=
e
>> quite thrilled about getting his patch in and I'd rather not leave him w=
ith
>> the impression we don't want to credit him for his work.
>
> Hm, ok, I'll try to rebase the whole tree :(
>
> Can you resend me the set of 26 patches with the correct authorship set
> so I know I get it right?
>
> thanks,
>
> greg k-h
>

Greg, wait!

No need for this. I understand the problem, can imagine why it
happened and I don't mind the wrong authorship. I prefer avoiding the
general head-ache of rebasing the whole tree.

To be honest I noticed this in yesterday's emails but I decided to not
mention it.

Marek,
Any beers for me then :P

Huge thanks to you both.

Luis
