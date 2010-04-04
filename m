Return-Path: <bethencourt@gmail.com>
MIME-Version: 1.0
Sender: bethencourt@gmail.com
In-Reply-To: <201004041330.37112.sven.eckelmann@gmx.de>
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004041246.38682.sven.eckelmann@gmx.de>
	<t2v506b70dc1004040410qbae117b7r3e6c02ccb616c73a@mail.gmail.com>
	<201004041330.37112.sven.eckelmann@gmx.de>
Date: Sun, 4 Apr 2010 13:39:49 +0100
Message-ID: <g2o506b70dc1004040539weff4c04akcbde4ef62dcdaeb@mail.gmail.com>
From: Luis de Bethencourt <luisbg@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] Staging: batman-adv: fix whitespace
	style issues
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>, Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Apr 4, 2010 at 12:30 PM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> On Sunday 04 April 2010 13:10:12 you wrote:
>
>> Thanks a lot for the help Sven.
>>
>> My patch didn't include changes to bat_sysfs.c, where are this changes
>> coming from? Sorry if I'm missing something obvious.
>
> Correct, that was part of the redoing of your changes. bat_sysfs.c is onl=
y
> part of the current development version and not in your patch (you still =
had
> the /proc stuff).
>
> But maybe you could explain to Marek why it is important/correct/good/...=
 to
> have no whitespaces before \n or if the part for /proc or /sys files can =
be
> ignored.
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>

I saw the bat_sysfs.c in the redoing of the changes. It is OK with me.

IMHO a whitespace before a \n is unneccesary, since it is a blank
character at the end of the line. Like adding a 0 at the left of a
number.
The obvious minor issue to try and avoid is space since having a big
number of these can bloat slightly the size of code/kernel. But the
whitespace can create other bigger issues, an example is when the
whitespace coincidentally falls one character out of the length of the
terminal, this will screw up the line break formatting in an ugly way.

I think these are the reasons why the coding style guidelines of the
Linux Kernel ask to avoid these whitespaces. Which also means removing
this helps the consistency of the kernel's code.

> Marek wrote:
> The whitespaces in bat_sysfs.c after the "commands" string are intentiona=
l.
> Userspace applications can simply split the string after each whitespace.=
 Of
> course, it can be done differently but it only "costs" us a whitespace. I=
 was
> not aware this would be an issue. Can we keep it or should we change e.g.
> batctl ?

Honestly, I don't understand the intention of the whitespaces you are
talking about. Userspace applications have to split the string after
each whitespace because there is a \n there, my fix just suggested to
split the line before the whitespace since I see no need for it.

So am I missunderstanding and there is a need for that whitespace?
Same question asked differently: Will there be any difference in the
print out if the line is broken before the whitespace instead of
after?

If so, please show me an example :)

Luis
