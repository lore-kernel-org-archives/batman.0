MIME-Version: 1.0
In-Reply-To: <200906130538.06620.lindner_marek@yahoo.de>
References: <5161afcd0906111040v1e2831ccv79c8ab6a5ca6cb58@mail.gmail.com>
	<200906130408.45362.lindner_marek@yahoo.de>
	<5161afcd0906121327m603d4c4ftc02458f30d39ff9c@mail.gmail.com>
	<200906130538.06620.lindner_marek@yahoo.de>
Date: Fri, 12 Jun 2009 15:52:19 -0600
Message-ID: <5161afcd0906121452p7fd294daha8915c906d7bb00e@mail.gmail.com>
From: Jacob Marble <jacobmarble@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] batman advanced in openwrt
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Fri, Jun 12, 2009 at 3:38 PM, Marek Lindner<lindner_marek@yahoo.de> wrot=
e:
> On Saturday 13 June 2009 04:27:44 Jacob Marble wrote:
>> > This message indicates that this nodes already has one interface which=
 is
>> > not activate. Could you post "cat /proc/net/batman-adv/interfaces" aft=
er
>> > you get this result ?
>>
>> "echo 'ath0' > interfaces"
>> "cat interfaces"
>> ath0
>>
>> [ =C2=A0 =C2=A0 97532] Adding interface: ath0
>> [ =C2=A0 =C2=A0 97532] Can't activate module: the primary interface is n=
ot active
>> [ =C2=A0 =C2=A0 97534] Adding route towards: 00:15:6d:a7:6a:14 (via
>> 00:15:6d:a7:6a:14) [ =C2=A0 =C2=A0 97534] Creating new global hna entry:
>> 00:ff:cf:5c:68:e0 (via 00:15:6d:a7:6a:14)
>
> It looks like a bug that I fixed in revision 1254. What version are you u=
sing ?
>

1176 (from OpenWrt repositories).  I'll get the latest svn.
