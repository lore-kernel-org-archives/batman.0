Return-Path: <a.mailevent@gmail.com>
MIME-Version: 1.0
Date: Wed, 7 Oct 2009 17:12:12 +0200
Message-ID: <d9bba8670910070812s16f9a1bne9c3ab97d61bf6fd@mail.gmail.com>
From: a <a.mailevent@gmail.com>
Content-Type: multipart/alternative; boundary=001485e36bef7ac66e047559c5a6
Subject: Re: [B.A.T.M.A.N.] batman-adv and TCP problem - SOLVED
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

--001485e36bef7ac66e047559c5a6
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,

I have solved my problem.

It is related to the TCP checksum offload function: I am using as embedded
platform PCEngines Alix 3d2, that do not support this function (and also
qemu virtual machines do not support it).

This patch disable the tx checksum offload and everything now works fine fo=
r
me!

--- soft-interface.c.old    2009-10-07 17:10:25.000000000 +0200
+++ soft-interface.c    2009-10-07 17:00:29.000000000 +0200
@@ -114,7 +114,7 @@
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29) */
     dev->destructor =3D free_netdev;

-    dev->features |=3D NETIF_F_NO_CSUM;
+    /* dev->features |=3D NETIF_F_NO_CSUM; */
     dev->mtu =3D hardif_min_mtu();
     dev->hard_header_len =3D BAT_HEADER_LEN; /* reserve more space in the
skbuff for our header */


I=92m not a kernel expert, and then let me know what do you think about thi=
s
solution/workaround

andrea


On Tue, Oct 6, 2009 at 6:31 PM, a <a.mailevent@gmail.com> wrote:

> Dear all,
>
> analyzing in deep the problem I have seen that the problem is the checksu=
m:
> as you can see in my previous .cap file, the packets with data from
> 192.168.100.2 have a wrong checksum (and my nodes are not using the HW
> checksum offload function)
> Then, I=92m starting to investigate how the checksum is calculated. If yo=
u
> have any suggestion or comment, you are welcome!
>
> andrea
>
>
>
>
>
> On Tue, Oct 6, 2009 at 3:14 PM, a <a.mailevent@gmail.com> wrote:
>
>> Dear Marek,
>>
>> On Tue, Oct 6, 2009 at 2:55 PM, Marek Lindner <lindner_marek@yahoo.de>wr=
ote:
>>
>>>
>>> Hi,
>>>
>>> > you can find as attachment the dump on eth2 of GW (tcpdump -ni eth2 -=
s
>>> 0 -w
>>> > gw.cap);
>>> > the output of batctl td -p 4 eth1 is:
>>>
>>> I could not find anything revealing in the logs you provided. Could you
>>> please
>>> follow Sven's suggestion to log both ends as well ?
>>>
>>> I could log on every interface; I will do it and send .cap files.
>>
>>
>>> Just to not forget the obvious:
>>> * What batman-adv version are you running ?
>>>
>> revision 1439
>>
>>
>>> * GW1 routes the packets - does this work via NAT or do you manually ad=
d
>>>
>> GW1 routes packets, without NAT
>>
>>
>>> routing entries to both ends ?
>>>
>>>
>>> > A question: am I the first one with this problem?
>>>
>>> AFAIK batman-adv has no problem transporting TCP traffic (unless you
>>> found an
>>> undiscovered bug nobody has seen before). The most common source of
>>> trouble is
>>> the configuration of the setup, in particular MTU settings or routing
>>> issues
>>> (which is why most people simply bridge).
>>>
>>
>> I understand your point about batman-adv; also for me, among batman node=
s
>> everything works fine.
>> I will also test the system with bridge on GW
>>
>>
>> andrea
>>
>>>
>>> Regards,
>>> Marek
>>> _______________________________________________
>>> B.A.T.M.A.N mailing list
>>> B.A.T.M.A.N@lists.open-mesh.net
>>> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>>>
>>
>>
>

--001485e36bef7ac66e047559c5a6
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,<br><br>I have solved my problem.<br><br>It is related to the TCP =
checksum offload function: I am using as embedded platform PCEngines Alix 3=
d2, that do not support this function (and also qemu virtual machines do no=
t support it).<br>
<br>This patch disable the tx checksum offload and everything now works fin=
e for me!<br><br>--- soft-interface.c.old=A0=A0=A0 2009-10-07 17:10:25.0000=
00000 +0200<br>+++ soft-interface.c=A0=A0=A0 2009-10-07 17:00:29.000000000 =
+0200<br>
@@ -114,7 +114,7 @@<br>=A0#endif /* LINUX_VERSION_CODE &lt; KERNEL_VERSION(=
2, 6, 29) */<br>=A0=A0=A0=A0 dev-&gt;destructor =3D free_netdev;<br>=A0<br>=
-=A0=A0=A0 dev-&gt;features |=3D NETIF_F_NO_CSUM;<br>+=A0=A0=A0 /* dev-&gt;=
features |=3D NETIF_F_NO_CSUM; */<br>
=A0=A0=A0=A0 dev-&gt;mtu =3D hardif_min_mtu();<br>=A0=A0=A0=A0 dev-&gt;hard=
_header_len =3D BAT_HEADER_LEN; /* reserve more space in the<br>skbuff for =
our header */<br><br><br>I=92m not a kernel expert, and then let me know wh=
at do you think about this solution/workaround<br>
<br>andrea<br><br><br><div class=3D"gmail_quote">On Tue, Oct 6, 2009 at 6:3=
1 PM, a <span dir=3D"ltr">&lt;<a href=3D"mailto:a.mailevent@gmail.com">a.ma=
ilevent@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
Dear all,<br><br>analyzing in deep the problem I have seen that the problem=
 is the checksum: as you can see in my previous .cap file, the packets with=
 data from 192.168.100.2 have a wrong checksum (and my nodes are not using =
the HW checksum offload function)<br>

Then, I=92m starting to investigate how the checksum is calculated. If you =
have any suggestion or comment, you are welcome!<br><font color=3D"#888888"=
><br>andrea</font><div><div></div><div class=3D"h5"><br><br><br><br><br><di=
v class=3D"gmail_quote">
On Tue, Oct 6, 2009 at 3:14 PM, a <span dir=3D"ltr">&lt;<a href=3D"mailto:a=
.mailevent@gmail.com" target=3D"_blank">a.mailevent@gmail.com</a>&gt;</span=
> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Dear Marek,<br><b=
r><div class=3D"gmail_quote"><div>On Tue, Oct 6, 2009 at 2:55 PM, Marek Lin=
dner <span dir=3D"ltr">&lt;<a href=3D"mailto:lindner_marek@yahoo.de" target=
=3D"_blank">lindner_marek@yahoo.de</a>&gt;</span> wrote:<br>

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
d send .cap files.<br>=A0<br></div><div><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">



Just to not forget the obvious:<br>
* What batman-adv version are you running ?<br></blockquote></div><div>revi=
sion 1439<br>=A0<br></div><div><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">



* GW1 routes the packets - does this work via NAT or do you manually add<br=
></blockquote></div><div>GW1 routes packets, without NAT<br>=A0</div><div><=
blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 2=
04, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



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
<br>andrea<br></font></div><div><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
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
</div></div></blockquote></div><br>

--001485e36bef7ac66e047559c5a6--
