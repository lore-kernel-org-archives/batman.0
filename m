Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
In-Reply-To: <d9bba8670910060614i6f3f53fbg309efb2cc5fab893@mail.gmail.com>
References: <d9bba8670910050221m476d31eaodcdb8e9cdfbe8fa3@mail.gmail.com>
	<200910061143.08021.sven.eckelmann@gmx.de>
	<d9bba8670910060333i45d91b8eyc5fb1f1b05b94194@mail.gmail.com>
	<200910062055.14214.lindner_marek@yahoo.de>
	<d9bba8670910060614i6f3f53fbg309efb2cc5fab893@mail.gmail.com>
Date: Tue, 6 Oct 2009 18:31:31 +0200
Message-ID: <d9bba8670910060931s2f2468e9l2932ad192f5dd3a6@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=00c09ffb561c53449b047546c3ee
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--00c09ffb561c53449b047546c3ee
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,

analyzing in deep the problem I have seen that the problem is the checksum:
as you can see in my previous .cap file, the packets with data from
192.168.100.2 have a wrong checksum (and my nodes are not using the HW
checksum offload function)
Then, I=92m starting to investigate how the checksum is calculated. If you
have any suggestion or comment, you are welcome!

andrea




On Tue, Oct 6, 2009 at 3:14 PM, a <a.mailevent@gmail.com> wrote:

> Dear Marek,
>
> On Tue, Oct 6, 2009 at 2:55 PM, Marek Lindner <lindner_marek@yahoo.de>wro=
te:
>
>>
>> Hi,
>>
>> > you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s=
 0
>> -w
>> > gw.cap);
>> > the output of batctl td -p 4 eth1 is:
>>
>> I could not find anything revealing in the logs you provided. Could you
>> please
>> follow Sven's suggestion to log both ends as well ?
>>
>> I could log on every interface; I will do it and send .cap files.
>
>
>> Just to not forget the obvious:
>> * What batman-adv version are you running ?
>>
> revision 1439
>
>
>> * GW1 routes the packets - does this work via NAT or do you manually add
>>
> GW1 routes packets, without NAT
>
>
>> routing entries to both ends ?
>>
>>
>> > A question: am I the first one with this problem?
>>
>> AFAIK batman-adv has no problem transporting TCP traffic (unless you fou=
nd
>> an
>> undiscovered bug nobody has seen before). The most common source of
>> trouble is
>> the configuration of the setup, in particular MTU settings or routing
>> issues
>> (which is why most people simply bridge).
>>
>
> I understand your point about batman-adv; also for me, among batman nodes
> everything works fine.
> I will also test the system with bridge on GW
>
>
> andrea
>
>>
>> Regards,
>> Marek
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@lists.open-mesh.net
>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>
>
>

--00c09ffb561c53449b047546c3ee
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>analyzing in deep the problem I have seen that the problem=
 is the checksum: as you can see in my previous .cap file, the packets with=
 data from 192.168.100.2 have a wrong checksum (and my nodes are not using =
the HW checksum offload function)<br>
Then, I=92m starting to investigate how the checksum is calculated. If you =
have any suggestion or comment, you are welcome!<br><br>andrea<br><br><br><=
br><br><div class=3D"gmail_quote">On Tue, Oct 6, 2009 at 3:14 PM, a <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:a.mailevent@gmail.com">a.mailevent@gmail.c=
om</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear Marek,<br><b=
r><div class=3D"gmail_quote"><div class=3D"im">On Tue, Oct 6, 2009 at 2:55 =
PM, Marek Lindner <span dir=3D"ltr">&lt;<a href=3D"mailto:lindner_marek@yah=
oo.de" target=3D"_blank">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
Hi,<br>
<div><br>
&gt; you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -s=
 0 -w<br>
&gt; gw.cap);<br>
&gt; the output of batctl td -p 4 eth1 is:<br>
<br>
</div>I could not find anything revealing in the logs you provided. Could y=
ou please<br>
follow Sven&#39;s suggestion to log both ends as well ?<br>
<br></blockquote></div><div>I could log on every interface; I will do it an=
d send .cap files.<br>=A0<br></div><div class=3D"im"><blockquote class=3D"g=
mail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;">


Just to not forget the obvious:<br>
* What batman-adv version are you running ?<br></blockquote></div><div>revi=
sion 1439<br>=A0<br></div><div class=3D"im"><blockquote class=3D"gmail_quot=
e" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt =
0.8ex; padding-left: 1ex;">


* GW1 routes the packets - does this work via NAT or do you manually add<br=
></blockquote></div><div>GW1 routes packets, without NAT<br>=A0</div><div c=
lass=3D"im"><blockquote class=3D"gmail_quote" style=3D"border-left: 1px sol=
id rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


routing entries to both ends ?<br>
<div><br>
<br>
&gt; A question: am I the first one with this problem?<br>
<br>
</div>AFAIK batman-adv has no problem transporting TCP traffic (unless you =
found an<br>
undiscovered bug nobody has seen before). The most common source of trouble=
 is<br>
the configuration of the setup, in particular MTU settings or routing issue=
s<br>
(which is why most people simply bridge).<br></blockquote></div><div><br>I =
understand your point about batman-adv; also for me, among batman nodes eve=
rything works fine.<br>I will also test the system with bridge on GW<br>
<font color=3D"#888888"><br>
<br>andrea<br></font></div><div class=3D"im"><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
<br>
Regards,<br>
<font color=3D"#888888">Marek<br>
</font><div><div></div><div>_______________________________________________=
<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@lists.open-mesh.net" target=3D"_blank">B.A.T.=
M.A.N@lists.open-mesh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</div></div></blockquote></div></div><br>
</blockquote></div><br>

--00c09ffb561c53449b047546c3ee--
