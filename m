MIME-version: 1.0
Content-type: multipart/alternative;
	boundary="Boundary_(ID_EKVPHtiCc/Q1DO5jLJCrrA)"
Message-id: <B0598FDC-F54D-4D67-BEE2-670F6BD8A064@philippeapril.com>
From: Philippe April <isf_lists@philippeapril.com>
In-reply-to: <854CEDF6-8307-4BB8-AFD0-EAC208163FE3@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Node keeps switching back and forth
Date: Thu, 17 Apr 2008 14:40:49 -0400
References: <7BE4D55B-B938-45A8-BCF4-923632152CFC@philippeapril.com>
	<a934d3f30804150104w4c4c47fp766cce05ae014ae2@mail.gmail.com>
	<018CC2A5-4DD5-421B-AD00-AF9B3CC50D2B@philippeapril.com>
	<200804160202.23971.lindner_marek@yahoo.de>
	<C2223079-2ACE-4EA6-BB82-C9B4A1547149@philippeapril.com>
	<4804FC55.3010407@gmx.net>
	<A46801E6-B4A6-452F-A1DE-C787A4E947D5@philippeapril.com>
	<4805198F.8080705@gmx.net>
	<a934d3f30804160140h36192f2ci3bed5efe52ff78f9@mail.gmail.com>
	<CDC8E1A4-5F56-4849-A251-9067DA06DF64@philippeapril.com>
	<854CEDF6-8307-4BB8-AFD0-EAC208163FE3@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Boundary_(ID_EKVPHtiCc/Q1DO5jLJCrrA)
Content-type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-transfer-encoding: 7BIT

Yes, the settings were all related to the madwifi drivers but it looks  
like I was wrong, I'm back to square one, my nodes are not reliable at  
all even after the tweaks. Sometimes I think I have it and it's stable  
for hours, and then for some reason it stops working.

Most of the time the ad-hoc network (for the mesh) is reliable (the  
nodes themselves are fine) but laptop clients can't associate to the  
nodes or the connection is flaky!

On my mac, it keeps disassociating and associating every 2 seconds...  
But this only happens sometimes!

I tried the RO.B.IN firmware on 4 nodes and the symptoms are the same,  
it's basically unusable.

Does anybody have a great success story to tell me with this hardware  
(FON/Accton with Atheros) and mesh networks? B.A.T.M.A.N seems to be  
the only thing stable in my setup after all :)

On 16-Apr-08, at 12:29 PM, Vinay Menon wrote:

> Hi Philippe,
> My gateway is a old fonera and nodes are meraki. I am using kamikaze  
> 7. 09 with 2.6.21 Kernel .
>
> The tweaks you speak of are they related to madwifi drivers I had  
> diversity and stuff ON on the nodes
> Which I changed on the nodes but they dont seem to help.
>
> Would be great if you could tell me more about the radio settings  
> and firewall rules (which I suspect is crashing my gateway )
>
> Regards,
>
> On Apr 16, 2008, at 21:11, Philippe April  
> <isf_lists@philippeapril.com> wrote:
>
>> Hi Vinay,
>>
>> What kind of hardware are you running this on? I had a lot of  
>> problems when it switched route until I tweaked some radio settings  
>> and FW rules, it seems better now.
>>
>> On 16-Apr-08, at 4:40 AM, Vinay Menon wrote:
>>> Philippe...seems your problem and mine are similar hence  
>>> continuing posting in
>>> this thread,if you feel its different please tell me ill repost as  
>>> a new thread.
>>>
>>> My network setup is as shown
>>>
>>>                         Gateway 10.24.249.96
>>>                         -------------------------------------
>>>                                      |
>>>                 50ft             |
>>>                                  |
>>>                                |
>>>                              |
>>>                    Node 1  (10.1.125.158)
>>>                    -------------------------------------
>>>                                    |
>>>                  25ft               |
>>>                                           |
>>>                                 Node 2 (10.1.52.)236
>>>                                -------------------------------------
>>>
>> _______________________________________________
>> B.A.T.M.A.N mailing list
>> B.A.T.M.A.N@open-mesh.net
>> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--Boundary_(ID_EKVPHtiCc/Q1DO5jLJCrrA)
Content-type: text/html; charset=US-ASCII
Content-transfer-encoding: quoted-printable

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; "><div>Yes, the settings were all =
related to the madwifi drivers but it looks like I was wrong, I'm back =
to square one, my nodes are not reliable at all even after the tweaks. =
Sometimes I think I have it and it's stable for hours, and then for some =
reason it stops working.</div><div><br></div><div>Most of the time the =
ad-hoc network (for the mesh) is reliable (the nodes themselves are =
fine) but laptop clients can't associate to the nodes or the connection =
is flaky!</div><div><br></div><div>On my mac, it keeps disassociating =
and associating every 2 seconds... But this only happens =
sometimes!</div><div><br></div><div>I tried the RO.B.IN firmware on 4 =
nodes and the symptoms are the same, it's basically =
unusable.</div><div><br></div><div>Does anybody have a great success =
story to tell me with this hardware (FON/Accton with Atheros) and mesh =
networks? B.A.T.M.A.N seems to be the only thing stable in my setup =
after all :)</div><div><br></div><div><html>On 16-Apr-08, at 12:29 PM, =
Vinay Menon wrote:</html><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
bgcolor=3D"#FFFFFF"><div>Hi Philippe,</div><div>My gateway is a old =
fonera and nodes are meraki. I am using kamikaze 7. 09 with 2.6.21 =
Kernel .</div><div>&nbsp;</div><div>The tweaks you speak of are they =
related to madwifi drivers I had diversity and stuff ON on the =
nodes</div><div>Which I changed on the nodes but they dont seem to =
help.&nbsp;</div><div><br =
class=3D"webkit-block-placeholder"></div><div>Would be great if you =
could tell me more about the radio settings and firewall rules (which I =
suspect is crashing my gateway )</div><div><br =
class=3D"webkit-block-placeholder"></div><div>Regards,</div><div><br =
class=3D"webkit-block-placeholder"></div><div>On Apr 16, 2008, at 21:11, =
Philippe April &lt;<a =
href=3D"mailto:isf_lists@philippeapril.com">isf_lists@philippeapril.com</a=
>> wrote:<br><br></div><div></div><blockquote type=3D"cite"><div><div>Hi =
Vinay,</div><div><br></div><div>What kind of hardware are you running =
this on? I had a lot of problems when it switched route until I tweaked =
some radio settings and FW rules, it seems better now.</div><br><div>On =
16-Apr-08, at 4:40 AM, Vinay Menon wrote:<br =
class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">Philippe...seems your problem and mine are similar hence =
continuing posting in<br>this thread,if you feel its different please =
tell me ill repost as a new thread.<br><br>My network setup is as =
shown<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gateway =
<a =
href=3D"http://10.24.249.96">10.24.249.96</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-------------------------------------<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; =
50ft&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |<br> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;&nbsp; =
|<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp;&nbsp; &nbsp; Node 1&nbsp; (<a =
href=3D"http://10.1.125.158">10.1.125.158</a>)<br>&nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; =
-------------------------------------<br> &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;&nbsp; 25ft&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
|<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Node 2 =
(10.1.52.)236<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; =
-------------------------------------<br>&nbsp;&nbsp; &nbsp; =
</blockquote></div></div></blockquote><blockquote =
type=3D"cite"><div><span>_______________________________________________</=
span><br><span>B.A.T.M.A.N mailing list</span><br><span><a =
href=3D"mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a></s=
pan><br><span><a =
href=3D"https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n">https://list.o=
pen-mesh.net/mm/listinfo/b.a.t.m.a.n</a></span><br></div></blockquote></di=
v>_______________________________________________<br>B.A.T.M.A.N mailing =
list<br><a =
href=3D"mailto:B.A.T.M.A.N@open-mesh.net">B.A.T.M.A.N@open-mesh.net</a><br=
>https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n<br></blockquote></div>=
<br></body></html>=

--Boundary_(ID_EKVPHtiCc/Q1DO5jLJCrrA)--
