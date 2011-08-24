Return-Path: <tonyputi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOaDhSTO8Dhv=Ao62kpZPzXss9kHCAM9TGTpgWzkVZ5fWJHwCg@mail.gmail.com>
References: <201108211629.54193.lindner_marek@yahoo.de>
	<CAOaDhSTO8Dhv=Ao62kpZPzXss9kHCAM9TGTpgWzkVZ5fWJHwCg@mail.gmail.com>
From: Filippo Sallemi <tonyputi@gmail.com>
Date: Wed, 24 Aug 2011 13:49:55 +0200
Message-ID: <CAFevQmMYGt0DY--y432Y3yYUQ46wdw8GQHJ2Sg--gp-cOK+xbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman-adv 2011.3.0 released
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Great work!

2011/8/21 Gioacchino Mazzurco <gmazzurco89@gmail.com>:
> Many thanks!
>
> 2011/8/21 Marek Lindner <lindner_marek@yahoo.de>:
>>
>> The B.A.T.M.A.N. team is delighted to announce its latest release, 2011.=
3.0,
>> introducing major protocol changes for better roaming of non-mesh client=
s,
>> gateway convenience features and a pile of bug fixes & code stability ch=
anges.
>> As the kernel module always depends on the Linux kernel it was compiled
>> against, it does not make sense to provide binaries on our website. As u=
sual,
>> you will find the signed tarballs in our download section:
>>
>> http://downloads.open-mesh.org/batman/releases/batman-adv-2011.3.0/
>>
>> as well as prepackaged binaries in your distribution.
>>
>>
>> Important changes
>> -----------------
>>
>> The extensive work on roaming improvements for non-mesh clients led to a
>> protocol change which breaks backward compatibility. Be sure to update a=
ll
>> your mesh network participants to the latest version to avoid orphan nod=
es.
>> Furthermore, a change in the networking infrastructure of the Linux kern=
el
>> made us drop the support of Linux kernels older than 2.6.29. Maintaining
>> compatibility would be an uphill battle while not being worthwhile for u=
s as a
>> Linux kernel project.
>>
>>
>> Thanks
>> ------
>>
>> Thanks to all people sending in patches:
>>
>> =C2=A0 * Antonio Quartulli <ordex@autistici.org>
>> =C2=A0 * Daniele Furlan <daniele.furlan@gmail.com>
>> =C2=A0 * David Howells <dhowells@redhat.com>
>> =C2=A0 * David S. Miller <davem@davemloft.net>
>> =C2=A0 * Joe Perches <joe@perches.com>
>> =C2=A0 * Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>> =C2=A0 * Marek Lindner <lindner_marek@yahoo.de>
>> =C2=A0 * Sven Eckelmann <sven@narfation.org>
>>
>>
>> batman-adv
>> ----------
>>
>> This release comes with a redesign of one of the oldest code segments /
>> concepts in batman-adv: the non-mesh client announcement mechanism. When
>> batman-adv detects a non-mesh client it automatically starts announcing =
the
>> client's mac address in the mesh network to make the mesh aware of the
>> client's location. The new protocol extension mainly deals with the opti=
mal
>> handling and propagation of these client position packets. Major benefit=
s
>> include: Only changes (client arriving or leaving) are propagated in the=
 mesh,
>> thereby reducing the protocol overhead; traffic redirection when a clien=
t
>> roams from one mesh node to the next until the mesh network has converge=
d to
>> reduce the packet loss while roaming; extensible packet format to constr=
uct
>> more features on top of it.
>> In addition, batman-adv gained support for informing the user space abou=
t
>> events via uevent (a long-standing feature request). The gateway subsyst=
em is
>> the first to make use of it by sending signals when a new gateway has be=
en
>> selected / selected gateway has been changed / the selected gateway has =
been
>> removed. Also, when enabled the gateway subsystem will filter out incomi=
ng
>> DHCP renewal requests if they are not targeted at a high quality gateway=
 to
>> force the client to switch to the best available gateway.
>> The routing algorithm received a minor tweaking which make it accept del=
ayed
>> OGM rebroadcasts to avoid bogus routing under heavy load. A bug hinderin=
g the
>> correct broadcast of OGM packets if interfaces were added & removed in a
>> particular order was fixed. A similar problem affecting the OGM aggregat=
ion
>> was eliminated too. The many smaller bug fixes and code stability improv=
ements
>> make this release a well-rounded package.
>>
>>
>> batctl
>> ------
>>
>> The Makefile received major attention and various cleanups to make packa=
ging
>> of batctl easier. tcpdump was updated, so that it can analyze the new tt=
 &
>> roaming packets and was extended by a new option to filter all packets e=
xcept
>> the specified types. An additional debug level for all client announceme=
nt
>> related information was added too. A pair of small bugs was squashed alo=
ng the
>> way: bisect did not properly initialize a variable which led to a compil=
e time
>> warning and a potential memory leak in the bat-hosts parser fixed.
>>
>>
>> Happy routing,
>> The B.A.T.M.A.N. team
>>
>



--=20
Filippo Sallemi
