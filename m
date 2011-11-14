Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4EC171B2.9070605@inti.gob.ar>
Date: Mon, 14 Nov 2011 16:53:22 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.5.1321268402.29081.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.5.1321268402.29081.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Problem to find better Route
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

Hi. We are using batman-adv 2011.2.0 with Openwrt Backfire-rc6 on D-Link=20
routers, and we're making some tests with iperf to measure bitrate=20
capabilities between nodes. When we put three nodes aligned we notice=20
that the obtained bitrate between the extreme nodes strongly depends on=20
the batman path between them. To make it clear, we have:

A ---------- B ---------- C

With a dinstance of about 20 meters between A and B, and the same=20
distance between B and C. The problem is that sometimes, A and C get=20
connected directly in terms of batman-adv protocol (checked with batctl=20
o), and when that happens, the bitrates are very poor (less than 1Mbps),=20
like if B wasn't there. In fact we disconnected B and obtained very=20
similar results.

Then we reduced tx power settings on A and C, forcing the B hop between=20
them, and we got much better speeds (~20Mbps). We've read about ELP and=20
think that maybe simple OGM messages are not good to measure link=20
quility between A and C in this example, could that be the problem? In=20
that case is there a way to fix this with actual batman-adv algorithms?=20
Thanks in advance!

Gabriel


El 14/11/2011 08:00 a.m., b.a.t.m.a.n-request@lists.open-mesh.org escribi=
=F3:
> Send B.A.T.M.A.N mailing list submissions to
> 	b.a.t.m.a.n@lists.open-mesh.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> 	https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
> or, via email, send a message with subject or body 'help' to
> 	b.a.t.m.a.n-request@lists.open-mesh.org
>
> You can reach the person managing the list at
> 	b.a.t.m.a.n-owner@lists.open-mesh.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of B.A.T.M.A.N digest..."
>
>
> Today's Topics:
>
>     1. Re: [PATCH] add make install (Sven Eckelmann)
>     2. Re: [PATCH] add make install (Sven Eckelmann)
>     3. Re: [PATCH] add make install (Alexey Fisher)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 14 Nov 2011 11:21:12 +0100
> From: Sven Eckelmann<sven@narfation.org>
> To: b.a.t.m.a.n@lists.open-mesh.org
> Cc: lindner_marek@yahoo.de
> Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
> Message-ID:<1428522.agqKBYpyMC@sven-laptop.home.narfation.org>
> Content-Type: text/plain; charset=3D"iso-8859-1"
>
> On Monday 14 November 2011 10:38:07 Sven Eckelmann wrote:
>> On Monday 14 November 2011 10:11:32 Alexey Fisher wrote:
>>> Signed-off-by: Alexey Fisher<bug-track@fisher-privat.net>
>>> ---
>>>
>>>   Makefile |    3 +++
>>>   1 files changed, 3 insertions(+), 0 deletions(-)
> [...]
>> NAck: Sven Eckelmann<sven@narfation.org>
> And also "Nack" for not updating the README [1]
>
> Kind regards,
> 	Sven
>
> [1] http://www.open-mesh.org/wiki/open-mesh/Contribute#Submitting-patches
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 836 bytes
> Desc: This is a digitally signed message part.
> URL:<http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/2011111=
4/850391c0/attachment-0001.pgp>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 14 Nov 2011 11:29:36 +0100
> From: Sven Eckelmann<sven@narfation.org>
> To: Alexey Fisher<bug-track@fisher-privat.net>
> Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de
> Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
> Message-ID:<1956205.mQFSXpQuIf@sven-laptop.home.narfation.org>
> Content-Type: text/plain; charset=3D"utf-8"
>
> On Monday 14 November 2011 11:19:19 Alexey Fisher wrote:
> [...]
>> Thank you,
>> so you will send your patch? I prefer last version, to make testing easi=
er.
> I personally don't care. Feel free to fix your patch and send a new versi=
on
> (but think about adding the ":" after "install" -- the character magically
> disappeared when I wrote the mail).
>
> And don't forget the documentation part as it is always hard to remember
> everything on the day the release is made, but easy when you just made the
> patch. :)
>
> Thanks,
> 	Sven
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: signature.asc
> Type: application/pgp-signature
> Size: 836 bytes
> Desc: This is a digitally signed message part.
> URL:<http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/2011111=
4/329c477e/attachment-0001.pgp>
>
> ------------------------------
>
> Message: 3
> Date: Mon, 14 Nov 2011 11:37:55 +0100
> From: Alexey Fisher<bug-track@fisher-privat.net>
> To: Sven Eckelmann<sven@narfation.org>
> Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de
> Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
> Message-ID:<4EC0EF83.2060602@fisher-privat.net>
> Content-Type: text/plain; charset=3D"utf-8"
>
> On 14.11.2011 11:29, Sven Eckelmann wrote:
>> On Monday 14 November 2011 11:19:19 Alexey Fisher wrote:
>> [...]
>>> Thank you,
>>> so you will send your patch? I prefer last version, to make testing eas=
ier.
>> I personally don't care. Feel free to fix your patch and send a new vers=
ion
>> (but think about adding the ":" after "install" -- the character magical=
ly
>> disappeared when I wrote the mail).
>>
>> And don't forget the documentation part as it is always hard to remember
>> everything on the day the release is made, but easy when you just made t=
he
>> patch. :)
> Corrected.
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: 0001-add-make-install-option.patch
> Type: text/x-patch
> Size: 959 bytes
> Desc: not available
> URL:<http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/attachments/2011111=
4/969101dd/attachment-0001.bin>
>
> ------------------------------
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.org
> https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n
>
>
> End of B.A.T.M.A.N Digest, Vol 59, Issue 19
> *******************************************
>
