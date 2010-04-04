Return-Path: <bethencourt@gmail.com>
MIME-Version: 1.0
Sender: bethencourt@gmail.com
In-Reply-To: <201004041246.38682.sven.eckelmann@gmx.de>
References: <1270341625-28764-1-git-send-email-luisbg@ubuntu.com>
	<201004040312.28481.sven.eckelmann@gmx.de>
	<p2x506b70dc1004031845p81705070o325d93f839c80e9a@mail.gmail.com>
	<201004041246.38682.sven.eckelmann@gmx.de>
Date: Sun, 4 Apr 2010 12:10:12 +0100
Message-ID: <t2v506b70dc1004040410qbae117b7r3e6c02ccb616c73a@mail.gmail.com>
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Sun, Apr 4, 2010 at 11:46 AM, Sven Eckelmann <sven.eckelmann@gmx.de> wro=
te:
> On Sunday 04 April 2010 03:45:52 Luis de Bethencourt wrote:
>> Sorry about the conflict, thanks for redoing the changes. Where can I
>> find the current and development branches?
>
> The development is currently done in different branches and SCMs outside =
the
> kernel. Andrew Lunn prepares a maint branch for submission to GregKH and =
sends
> it to him for staging.
>
> Most of the development of future features are done in
> =A0http://downloads.open-mesh.org/svn/batman/ under trunk/batman-adv-kern=
elland/
> This is usually not what you deal with as only the maint branch is submit=
ted
> for inclusion into linux staging. Nevertheless all changes in svn for bat=
man-
> adv-kernelland are automatically imported into
> http://git.open-mesh.net/?p=3Dbatman-adv (branch master).
>
> The maint work is now done inside the maint branch of that git repository=
. It
> doesn't contain the whole linux tree and holds all files to build an exte=
rnal
> module (used for example in OpenWRT and Debian). When Andrew thinks that =
it is
> ready to be send to GregKH, he will do a subtree merge into linus (holds =
the
> linux tree) and then rebase the changes in a private branch. This is need=
ed to
> have the correct directories inside the patches and that files removed/ad=
ded
> for the kernel are still being deleted/available.
>
> So doing your changes against the git maint branch is the correct way in =
most
> situations.
>
>> I want to avoid doing this
>> mistake again in the future. Specially since I'm planning on doing
>> some janitorial work on Staging for a while if it's OK with you guys.
>> I see it as nice experience and practice while learning and getting
>> ready for more valuable contributions :)
>
> Yes, contributors are welcome.
>
> There is also a userspace part which must also work with your changes. On=
e
> problem was spotted by Marek. So it is maybe a good idea to send changes =
over
> the b.a.t.m.a.n. mailing list.
>
> Best regards,
> =A0 =A0 =A0 =A0Sven
>

Thanks a lot for the help Sven.

My patch didn't include changes to bat_sysfs.c, where are this changes
coming from? Sorry if I'm missing something obvious.

Luis
